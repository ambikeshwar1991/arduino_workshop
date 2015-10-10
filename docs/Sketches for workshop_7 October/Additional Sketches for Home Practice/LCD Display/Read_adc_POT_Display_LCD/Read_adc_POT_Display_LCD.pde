/*

Read_ADC_Pot_Display

This program  will read from 1 ADC channel and store in int variable.
The data is a value between 0 to 1023.


 The circuit:
 * LCD RS pin to digital pin 12
 * LCD Enable pin to digital pin 11
 * LCD D4 pin to digital pin 5
 * LCD D5 pin to digital pin 4
 * LCD D6 pin to digital pin 3
 * LCD D7 pin to digital pin 2
 * 10K resistor:
 * ends to +5V and ground
 * wiper to LCD VO pin (pin 3)
 
 
 created by P. W Dandekar on 1st June 2011.
 */

// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);// declare LCD library with 6 wires connected.

int i;
int potPin = 0;

void setup() {
  // set up the LCD's number of rows and columns: 
  lcd.begin(16, 2);// initial LCD display.
  delay (3000);// wait for 3 seconds. here we will screen clear display.

}// end of setup.

void loop() {
  // Read analog value from potentiometer
  i = analogRead(potPin);
  // set the cursor to column 0, line 1
  // (note: line 1 is the second row, since counting begins with 0):
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Potmeter Value!");// Display this in upper row.
  lcd.setCursor(0, 1);// Position cursor to second row or row =1 and column = 0.
  // print the number of seconds since reset:
  lcd.print(i);// display ADC value ( 0 to 1023) on LCD second row.
  
  delay(100);// wait for some time and then repeat.
}

  

