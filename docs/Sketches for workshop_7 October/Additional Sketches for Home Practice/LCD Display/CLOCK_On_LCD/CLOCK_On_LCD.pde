/*
  CLOCK_On_LCD
 
 This sketch runs a software clock with a 1 second delay. After each second, it updates 
 software counters or variables-  seconds, minutes and hours  and  and shows the time.
 
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
 
By P w Dandekar on 17 June 2011
 */

// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

int seconds, minutes, hours;


void setup() {
  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  // Print a message to the top line of LCD.
  // set the cursor to column 0, line 0
  // (note: line 0 is top row and line 1 is bottom or second row.
  lcd.setCursor(0, 0);
  lcd.print("Clock_display");
  seconds = minutes = hours =0;// initialize to clock to 00:00:00
}

void loop() {

  delay(1000);// waste one second time.
  lcd.clear();// clear display before writing fresh values.
  lcd.setCursor(0, 0);
  lcd.print("Clock_display");
  
  seconds++; // increment seconds counter.
  if (seconds>59)
  {
    seconds =0;// if seconds exceed 59 then make it zero.
    minutes++; // increment minutes counter.
    if (minutes>59)
    {
      minutes =0;// if minutes exceed 59 then make it zero.
      hours++; // increment hours counter.    
      if (hours >23)
       {
          hours =0;// if hours exceed 23 then make it zero.        
       }// end of inner if.
       
    }// end of middle if.
    
  }// end of outer if


  lcd.setCursor(0, 1);  // set the cursor to column 0, line 1
  // print the number of seconds since reset:
  lcd.print(hours);
  lcd.setCursor(5, 1);  // set the cursor to column 5, line 1
  // print the number of seconds since reset:
  lcd.print(minutes);
  
  lcd.setCursor(10, 1);  // set the cursor to column 5, line 1
  // print the number of seconds since reset:
  lcd.print(seconds);  
  
}// end of loop

