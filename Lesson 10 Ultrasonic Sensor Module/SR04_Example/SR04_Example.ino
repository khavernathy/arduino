//www.elegoo.com
//2016.12.08
#include "SR04.h"
#define TRIG_PIN 12
#define ECHO_PIN 11

#define ledPin 2
SR04 sr04 = SR04(ECHO_PIN,TRIG_PIN);
long a;

void setup() {
   Serial.begin(9600);
   delay(1000);
   pinMode(ledPin, OUTPUT);
}

void loop() {
   digitalWrite(ledPin, LOW);
   a=sr04.Distance();
   Serial.print(a);
   Serial.print("cm = ");
   Serial.print(a*0.393701);
   Serial.print("in = ");
   Serial.print(a*0.393701/12.0);
   Serial.println("ft");
   if (a*0.393701/12.0 < 2.0) {
    analogWrite(ledPin, 255);
   }
   delay(1000);
}
