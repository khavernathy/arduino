//www.elegoo.com
//2018.10.25

//#include "DateTime.h"
//#include "DateTimeStrings.h"
//#define TIME_MSG_LEN  11   // time sync to PC is HEADER and unix time_t as ten ascii digits
//#define TIME_HEADER  255   // Header tag for serial time sync message

#include "dht_nonblocking.h"
#define DHT_SENSOR_TYPE DHT_TYPE_11

static const int DHT_SENSOR_PIN = 2;
DHT_nonblocking dht_sensor( DHT_SENSOR_PIN, DHT_SENSOR_TYPE );

#include <Wire.h>
#include "DS3231.h"

DS3231 clock;
RTCDateTime dt;

int lightPin = 0;

/* ====================== SETUP ===================== */
void setup( )
{
  Serial.begin(9600);
  //Serial.println("Initialize DS3231");
  // Initialize DS3231
  clock.begin();
  // Manual (YYYY, MM, DD, HH, II, SS
  // clock.setDateTime(2016, 12, 9, 11, 46, 00);
  // Send sketch compiling time to Arduino
  clock.setDateTime(__DATE__, __TIME__);
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
      dt = clock.getDateTime();
      // For leading zero look to DS3231_dateformat example
      Serial.print(dt.year);   Serial.print("-");
      Serial.print(dt.month);  Serial.print("-");
      Serial.print(dt.day);    Serial.print(" ");
      Serial.print(dt.hour);   Serial.print(":");
      Serial.print(dt.minute); Serial.print(":");
      Serial.print(dt.second); Serial.print(" ");

      
      Serial.print( "T = " );
      Serial.print( temperature, 1 );
      Tf = temperature*(9./5.)+32.;
      Serial.print( " C = "); Serial.print(Tf); Serial.print(" F, RH = " );
      Serial.print( humidity, 1 );
      Serial.print( "% " );

      
      int reading = analogRead(lightPin);
      Serial.print("LIGHT = "); Serial.println(reading);

    /* ========================================= */

  }
}
