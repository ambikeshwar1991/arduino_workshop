/*   Single_Motor_Driver_with_LCD_Buzzer
  
  This sketch runs motor in one direction from zero to full speed. Then it brings down speed back to zero slowly.
  
  It repeats above steps for another direction. The whole sequence takes about 10 to 12 seconds.
  
  It also displays teh direction and the speed  on LCD display
  
  Circuit:
  
  Motor wires connected to RIGHT Motor pins on L293D Board
  
  pin 7 -Buzzer +ve
  pin GND - Buzzer -ve
  
  
  Pin D10 - PWM giving signal to IN3 of L293D Board
  Pin D9  - PWM giving signal to IN4 of L293D Board
  FWD direction: pin 10 = 1, pin 9 =0
  REV direction: pin 10 = 0, pin 9 =1
  STOP: pin 10 = 0, pin 9 =0
 
 
 * LCD RS pin to digital pin 16
 * LCD Enable pin to digital pin 17
 * LCD D4 pin to digital pin 18
 * LCD D5 pin to digital pin 19
 * LCD D6 pin to digital pin 20
 * LCD D7 pin to digital pin 21
 * 10K resistor:
 * ends to +5V and ground
 * wiper to LCD VO pin (pin 3)

  Created by P W Dandekar on 1st June 2011
 
 */
 
#define  IN3   10
#define  IN4   9
#define d_count 50
#define buzPin 7




// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);


void setup() {
  // set up 2 PWM output pins used in motor driver in outout mode.
  pinMode(IN3, OUTPUT);   
  pinMode(IN4 , OUTPUT);  
  pinMode(buzPin ,OUTPUT);  
  digitalWrite(buzPin, LOW);// switch off buzzer.
  
   // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  // Print a message to the LCD.
  lcd.print("Motor Driver demo");
  delay (2000);// wait for 2 seconds.
 
}

void  Display_Info(int dir, int pwm_value)
{
    lcd.clear();
    lcd.setCursor(0, 0);// top row, first column
    lcd.print("Direction =");// display text
    lcd.print(dir);// display value
    lcd.setCursor(0, 1);// second row, first column
    // print the number of seconds since reset:
    lcd.print("PWM Setting =");// display text
    lcd.print(pwm_value);// display value    
  
}// end of Display_Info function.

void loop() {
  int i;
  
//----------------------------------------------------------------------------------------------------------------------
  // Run Motor in Clockwise (CW) direction from 0 to 255 PWM value ( 0 to 100%) INCREASING SPEED
  analogWrite(IN4,0);// set PWM value 0 on IN4.Whenever IN3 will be 1 the motor will rotate in forward direction.
  for (i=0;i<255;i++) // rising speed in CW direction
  {  // set PWM pulse width from 0 to 255 in steps of 1.
    analogWrite(IN3,i);// set PWM value i on IN3.
    Display_Info(0, i);// Display Direction & PWM value
    
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 

  digitalWrite(buzPin, HIGH);// switch on buzzer.
  delay(1000);// wait here for 1 second
  digitalWrite(buzPin, LOW);// switch off buzzer.

  // Run Motor in Clockwise (CW) direction from 0 to 255 PWM value ( 0 to 100%) DECREASING SPEED
  for (i=255;i>0;i--) // falling speed in CW direction
  {  // set PWM pulse width from 255 to 0 in steps of 1.
    analogWrite(IN3,i);// set PWM value i on IN3.
    Display_Info(0, i);// Display Direction & PWM value
    
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  digitalWrite(buzPin, HIGH);// switch on buzzer.
  delay(1000);// wait here for 1 second
  digitalWrite(buzPin, LOW);// switch off buzzer.
  

//----------------------------------------------------------------------------------------------------------------------
  // Run Motor in Counter-Clockwise (CCW) direction from 0 to 255 PWM value ( 0 to 100%) INCREASING SPEED
  analogWrite(IN3,0);// set PWM value 0 on IN4.Whenever IN4 will be 1 the motor will rotate in forward direction.
  for (i=0;i<255;i++) // rising speed in CCW direction
  {  // set PWM pulse width from 0 to 255 in steps of 1.
    analogWrite(IN4,i);// set PWM value i on IN4.
    Display_Info(1, i);// Display Direction & PWM value
    
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  digitalWrite(buzPin, HIGH);// switch on buzzer.
  delay(1000);// wait here for 1 second
  digitalWrite(buzPin, LOW);// switch off buzzer.
  
  
  // Run Motor in Counter-Clockwise (CCW) direction from 0 to 255 PWM value ( 0 to 100%) DECREASING SPEED
  for (i=255;i>0;i--) // falling speed in CCW direction
  {  // set PWM pulse width from 255 to 0 in steps of 1.
    analogWrite(IN4,i);// set PWM value i on IN4.
    Display_Info(1, i);// Display Direction & PWM value
    
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  digitalWrite(buzPin, HIGH);// switch on buzzer.
  delay(1000);// wait here for 1 second
  digitalWrite(buzPin, LOW);// switch off buzzer.
  
  
}

