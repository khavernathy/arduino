//www.elegoo.com
//2016.12.12

/************************
Exercise the motor using
the L293D chip
************************/

#define ENABLE 5
#define DIRA 3
#define DIRB 4

int i;
 
void setup() {
  //---set pin direction
  pinMode(ENABLE,OUTPUT);
  pinMode(DIRA,OUTPUT);
  pinMode(DIRB,OUTPUT);
  Serial.begin(9600);
}

void loop() {
/*
 digitalWrite(ENABLE,HIGH);
 digitalWrite(DIRA,HIGH);
 digitalWrite(DIRB,LOW);
 for (i=255; i>0; i -= 5) {
  analogWrite(ENABLE,i);
  delay(500);
 }
*/
 
//---back and forth example
    
    Serial.println("One way, then reverse");
    digitalWrite(ENABLE,HIGH); // enable on
    for (i=0;i<5;i++) 
    {
      digitalWrite(DIRA,HIGH); //one way
      digitalWrite(DIRB,LOW);
      delay(4000);
      Serial.println("front");
      digitalWrite(DIRA,LOW);  //reverse
      digitalWrite(DIRB,HIGH);
      delay(4000);
      Serial.println("back");
    }
     
    digitalWrite(ENABLE,LOW); // disable
    delay(3000);
    
}
   
