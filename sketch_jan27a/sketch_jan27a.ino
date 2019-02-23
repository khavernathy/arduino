
#define BLACK 3


int i;

void setup() {
  // put your setup code here, to run once:

  pinMode(BLACK,OUTPUT);
  Serial.begin(9600);
}

void loop() {
 // exit(0);
  // put your main code here, to run repeatedly:
  for (i=0;i<5;i++) {

     Serial.println("Going high!");
     digitalWrite(BLACK,HIGH);
     delay(2000);

    Serial.println("going low");
     digitalWrite(BLACK,LOW);
     delay(2000);
  }
}
