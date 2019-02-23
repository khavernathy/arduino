//www.elegoo.com
//2016.12.08

int ledPin = 5;
int buttonApin = 9;
int buttonBpin = 8;

byte leds = 0;

int state=0;

void setup() 
{
  pinMode(ledPin, OUTPUT);
  pinMode(buttonApin, INPUT_PULLUP);  
  pinMode(buttonBpin, INPUT_PULLUP);  
}

void loop() 
{
  if (digitalRead(buttonApin) == LOW)
  {
    if (state==0) {
      digitalWrite(ledPin, HIGH);
      state=1;
    } else if (state==1) {
      digitalWrite(ledPin, LOW);
      state=0;
    }
     
  }

  
/*
  if (digitalRead(buttonBpin) == LOW)
  {
    digitalWrite(ledPin, LOW);
  }
  */
}
