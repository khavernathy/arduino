#define CUSTOM_SETTINGS
#define INCLUDE_TERMINAL_SHIELD

/* Include 1Sheeld library. */
#include <OneSheeld.h>

char myArray[8];

/* A name for the LED on pin 13. */
int ledPin = 13;

void setup() {

  /* Start communication. */
  OneSheeld.begin();
  /* Set the LED pin as output. */
  pinMode(ledPin, OUTPUT);

}

void loop() {

  Terminal.readBytes(myArray, 8);

  if (!memcmp("turn on", myArray, 7)) {
    /* Turn on the LED. */
    digitalWrite(ledPin, HIGH);
    Terminal.println(" LED turned on");
  }
  else if (!memcmp("turn off", myArray, 8)) {
    /* Turn off the LED. */
    digitalWrite(ledPin, LOW);
    Terminal.println(" LED turned off ");
  }
}
