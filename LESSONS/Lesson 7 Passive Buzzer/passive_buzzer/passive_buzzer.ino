//www.elegoo.com
//2016.12.08

#include "pitches.h"
 
// notes in the melody:
int melody[] = {
  //NOTE_C5, NOTE_D5, NOTE_E5, NOTE_F5, NOTE_G5, NOTE_A5, NOTE_B5, NOTE_C6
  //NOTE_E5, NOTE_DS5, NOTE_E5, NOTE_DS5, NOTE_E5, NOTE_B4, NOTE_D5, NOTE_C5, NOTE_A4
  
  //NOTE_A4, NOTE_FS3, NOTE_G3, NOTE_FS3, NOTE_E3, NOTE_D3, NOTE_FS3, NOTE_D4, NOTE_D3
  NOTE_A5, NOTE_FS4, NOTE_G4, NOTE_FS4, NOTE_E4, NOTE_D4, NOTE_FS4, NOTE_D5, NOTE_D4 // 440 Hz is A4
  };

int whole=100;
int half= 50;
int qtr = 25;
int eth = 13;
int scale = 13; // bigger is slower


  
 
void setup() {
whole = whole* scale;
half *= scale;
qtr *= scale;
eth *= scale;
}
 
void loop() { 
  return;
  int duration[] = {qtr,qtr,eth,eth,qtr,qtr,qtr,qtr,qtr};

  for (int thisNote = 0; thisNote < 9; thisNote++) {
    // pin8 output the voice
    tone(8, melody[thisNote], duration[thisNote]);
    // delay duration of the note before executing next command
    delay(duration[thisNote]);
  }
   
  // restart after two seconds 
  delay(2000);
}
