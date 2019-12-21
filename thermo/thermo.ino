/* OUTPUT COLUMNS ARE
 *  DATE TIME T_humidity Humidity Light T_thermistor T_waterproof
 */

// TEMPERATURE, HUMIDITY
#include "dht_nonblocking.h"
#define DHT_SENSOR_TYPE DHT_TYPE_11
static const int DHT_SENSOR_PIN = 2;
DHT_nonblocking dht_sensor( DHT_SENSOR_PIN, DHT_SENSOR_TYPE );

// TIME
#include <Wire.h>
#include "DS3231.h"
DS3231 clock;
RTCDateTime dt;

// LIGHT
int lightPin = 0;

/* SOUND
int  sensorAnalogPin = A1;    // Select the Arduino input pin to accept the Sound Sensor's analog output
int  sensorDigitalPin = 7;    // Select the Arduino input pin to accept the Sound Sensor's digital output
int  analogValue = 0;         // Define variable to store the analog value coming from the Sound Sensor
int  digitalValue;            // Define variable to store the digital value coming from the Sound Sensor
int  Led13 = 13;              // Define LED port; this is the LED built in to the Arduino (labled L)
                              // When D0 from the Sound Sensor (connnected to pin 7 on the
                              // Arduino) sends High (voltage present), L will light. In practice, you
                              // should see LED13 on the Arduino blink when LED2 on the Sensor is 100% lit.
*/

// TEMPERATURE
int tempPin = 1;

// WATERPROOF TEMPERATURE
#include "OneWire.h"
#include "DallasTemperature.h"
OneWire oneWire(7); // Digital Pin 7
DallasTemperature dTemp(&oneWire);


/* ====================== SETUP ===================== */
void setup( )
{
  Serial.begin(9600);
  
  // TIME
  //Serial.println("Initialize DS3231");
  // Initialize DS3231
  clock.begin();
  // Manual (YYYY, MM, DD, HH, II, SS
  // clock.setDateTime(2016, 12, 9, 11, 46, 00);
  // Send sketch compiling time to Arduino
  clock.setDateTime(__DATE__, __TIME__);

  /* SOUND
  pinMode(sensorDigitalPin,INPUT);
  pinMode(Led13, OUTPUT);
  */
}

/*
 * Poll for a measurement, keeping the state machine alive.  Returns
 * true if a measurement is available.
 */
static bool measure_environment( float *temperature, float *humidity ) {
  static unsigned long measurement_timestamp = millis( );
  /* Measure once every four seconds. */
  if( millis( ) - measurement_timestamp > 3000ul )
  {
    if( dht_sensor.measure( temperature, humidity ) == true )
    {
      measurement_timestamp = millis( );
      return( true );
    }
  }
  return( false );
}


/* ======================================LOOPz========================== */
void loop( )
{
  //exit(0);
  float temperature;
  float humidity;
  float Tf ;
  /* Measure temperature and humidity.  If the functions returns
     true, then a measurement is available. */
  if( measure_environment( &temperature, &humidity ) == true )
  {
      /*
       *       
      char helper[2];
      dt = clock.getDateTime();
      Serial.print(dt.year); Serial.print("-"); 
      sprintf(helper, "%02d", dt.month); Serial.print(helper); Serial.print("-");
      sprintf(helper, "%02d", dt.day); Serial.print(helper); Serial.print(" ");
      sprintf(helper, "%02d", dt.hour); Serial.print(helper); Serial.print(":");
      sprintf(helper, "%02d", dt.minute); Serial.print(helper); Serial.print(":");
      sprintf(helper, "%02d", dt.second); Serial.print(helper); Serial.print(" ");
      memset(helper, 0, 2); 
       */
      
      // TIME
      dt = clock.getDateTime();
      // For leading zero look to DS3231_dateformat example
      
      /*
      Serial.print(dt.year);   Serial.print("-");          
      Serial.print(dt.month); Serial.print("-");
      Serial.print(dt.day);    Serial.print(" ");
      Serial.print(dt.hour);   Serial.print(":");
      Serial.print(dt.minute); Serial.print(":");
      Serial.print(dt.second); Serial.print(" ");
      */
      Serial.print(dt.unixtime); Serial.print(" ");
      
      // TEMPERATURE, HUMIDITY
      Serial.print( " " );
      Tf = temperature*(9./5.)+32.;
      Serial.print(Tf); Serial.print(" " );
      Serial.print( humidity, 1 );
      Serial.print( " " );

      // LIGHT
      int reading = analogRead(lightPin);
      Serial.print(reading);

      // TEMPERATURE (THERMISTOR)
      int tempReading = analogRead(tempPin);

      double tempK = log(10000.0 * ((1024.0 / tempReading - 1)));
      tempK =  1 / (0.001129148 + (0.000234125 + (0.0000000876741 * tempK * tempK )) * tempK );
      float tempC = tempK - 273.15;
      float tempF = (tempC * 9.0)/ 5.0 + 32.0;
      Serial.print(" "); Serial.print(tempF); Serial.print(" "); //Serial.print("\n"); 
      
      // WATERPROOF TEMPERATURE
      dTemp.requestTemperatures();
      Serial.print(dTemp.getTempFByIndex(0)); Serial.print("\n");// Get the first temperature for waterproof probe.
      
      // Serial.println(""); 
    /* ========================================= */
  }
  /* SOUND
  analogValue = analogRead(sensorAnalogPin);
  digitalValue = digitalRead(sensorDigitalPin);
  Serial.print(" SOUND = "); Serial.println(analogValue);
  if (digitalValue==HIGH) digitalWrite(Led13,HIGH);
  else digitalWrite(Led13,LOW);
  delay(50);
  */
}
