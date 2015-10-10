/*
  This program tests three peripherals at a time.
  Circuit-
  * On board LED anode to digital pin 13 and cathode on ground.
  * buzzer positive to digital pin 12 and other terminal on ground.
  * RGB LED cathode connected to ground.
  * Blue anode (with resistor) to digital pin 9
  * Red anode (with resistor) to digital pin 10
  * green anode (with resistor) to digital pin 11
    The circuit:
  * LCD RS pin to digital pin 12
  * LCD Enable pin to digital pin 6
  * LCD D4 pin to digital pin 5
  * LCD D5 pin to digital pin 4
  * LCD D6 pin to digital pin 3
  * LCD D7 pin to digital pin 2

Created by P W Dandekar on 17 Sept 2011
*/

// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 6, 5, 4, 3, 2);


#define blue_PWMPin    9
#define red_PWMPin     10
#define green_PWMPin   11
#define ledPin 13

void setup() {
  // initialize the digital pin as an output.
  // Pin 13 has an LED connected on most Arduino boards:
  pinMode(ledPin, OUTPUT);     // define ledPin is in  output mode  
  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  // Print a message to the LCD.
  lcd.print("hello, world!");
}

void loop() {
  // now switch on Blue LED 
  analogWrite (blue_PWMPin, 255);// Blue LED ON.
  analogWrite (red_PWMPin, 0);// RED LED OFF.
  analogWrite (green_PWMPin, 0);// GREEN LED OFF.  
  delay (333); // waste 1/3 second second.

  // now switch on Red LED 
  analogWrite (blue_PWMPin, 0);// Blue LED OFF.
  analogWrite (red_PWMPin, 255);// RED LED ON.
  analogWrite (green_PWMPin, 0);// GREEN LED OFF.  
  delay (333); // waste 1/3 second second.

  // now switch on GREEN LED 
  analogWrite (blue_PWMPin, 0);// Blue LED OFF.
  analogWrite (red_PWMPin, 0);// RED LED OFF.
  analogWrite (green_PWMPin, 255);// GREEN LED ON.  
  delay (333); // waste 1/3 second second.
  
  // now blink LED and beep buzzer for 10 ms.
  digitalWrite(ledPin, HIGH);   // set the LED on
  
  delay(3);              // wait for some time.     
  
  digitalWrite(ledPin, LOW);    // set the LED off
    // set the cursor to column 0, line 1
  // (note: line 1 is the second row, since counting begins with 0):
  lcd.setCursor(0, 1);
  // print the number of seconds since reset:
  lcd.print(millis()/1000);

}// end of loop

