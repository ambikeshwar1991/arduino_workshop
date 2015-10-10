/*
 * IRremote: IRrecvDemo - demonstrates receiving IR codes with IRrecv
 * An IR detector/demodulator must be connected to the input RECV_PIN.
 * Version 0.1 July, 2009
 * Copyright 2009 Ken Shirriff
 * http://arcfn.com
 

 * Board input D0 to digital pin 5
 * Board input D1 to digital pin 6
 * Board input D2 to digital pin 5


 Modified by P W Dandekar on 8th November 2011. 
 
 */

#include <IRremote.h>
// include the library code:
#include <LiquidCrystal.h>


#define bluePin  12    // Blue LED is fed by PWM on pin 12 (PD4)
#define redPin   13   // Blue LED is fed by PWM on pin 13 (PD5)
#define greenPin 4    // Green LED is fed by PWM on pin 14 (Pb4)

// initialize the library with the numbers of the interface pins
// LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
LiquidCrystal lcd(15, 16, 17, 18, 19, 20);

int voltage; // voltage is an integer from 0 to 7.
int d0Pin = 5;
int d1Pin = 6;
int d2Pin = 7;
int ledPin = 0;

int b_intnsty, r_intnsty,g_intnsty; // define 3 variable for intensity of LED to be used in PWM value.
int led_index ; // used as a pointer to select one particular LED at a time. 
                 // It will have value 0 = None, 1= Blue; 2 = red, 3 = Green 4 = AC load.
                 
const int max_led_index =4; 

const unsigned long P_up = 948321266; 
const unsigned long P_down = 948321274; 
const unsigned long volume_down = 948321226; 
const unsigned long volume_up = 948321218; 
const unsigned long menu = 948321244; 
const unsigned long jump = 948321258; 
const unsigned long zoom = 948321222; 
const unsigned long tv_av = 948321268; 
const unsigned long p_dot_p = 948321254; 
const unsigned long disp = 948321270; 

int RECV_PIN = 3; // in Robo sanguino we use ATmega644 whose PB3 (PWM) is at digital pin 3 
unsigned long l;
IRrecv irrecv(RECV_PIN);
decode_results results;

void disp_all(void)
{
  lcd.clear(); // clear previous data on both lines.  
  lcd.setCursor(0, 0);// set cursor to top row col 0.
  lcd.print("Channel No = ");// show label
  lcd.setCursor(11, 0);// set cursor to top row col 11.
  lcd.print(led_index);// show value of label.
  lcd.setCursor(0, 1);// set cursor to second row col 0.
  lcd.print(b_intnsty);// show value of blue intensity.
  lcd.setCursor(5, 1);// set cursor to second row col 5.
  lcd.print(r_intnsty);// show value of red intensity.
  lcd.setCursor(10, 1);// set cursor to second row col 10.
  lcd.print(g_intnsty);// show value of green intensity.
  lcd.setCursor(15, 1);// set cursor to second row col 10.
  lcd.print(voltage);// show value of AC load level number from 0 to 7 in last column.
}


void set_value(int v)
{// This function accepts an integer in range 0 (minimum) to 7 (maximum) 
 // and appropriately sets 3-bit number on D2,D1 and D0
  if (v<0) {v =0;}// no negative values allowed.
  if (v>7) {v =7;}// max positivce value allowed is 7.
  
  switch (v) {
    case 0:
      //put 111 on 3 lines
      digitalWrite(d2Pin, HIGH);   // set the D2 HIGH 
      digitalWrite(d1Pin, HIGH);   // set the D1 HIGH 
      digitalWrite(d0Pin, HIGH);   // set the D0 HIGH      
      break;
      
    case 1:
      //put 110 on 3 lines
      digitalWrite(d2Pin, HIGH);   // set the D2 HIGH 
      digitalWrite(d1Pin, HIGH);   // set the D1 HIGH 
      digitalWrite(d0Pin, LOW);   // set the D0 LOW       
      break;      
      
    case 2:
      //put 101 on 3 lines
      digitalWrite(d2Pin, HIGH);   // set the D2 HIGH 
      digitalWrite(d1Pin, LOW);   // set the D1 LOW 
      digitalWrite(d0Pin, HIGH);   // set the D0 HIGH       
      break;

    case 3:
      //put 100 on 3 lines
      digitalWrite(d2Pin, HIGH);   // set the D2 HIGH 
      digitalWrite(d1Pin, LOW);   // set the D1 LOW 
      digitalWrite(d0Pin, LOW);   // set the D0 LOW       
      break;
      
    case 4:
      //put 011 on 3 lines
      digitalWrite(d2Pin, LOW);   // set the D2 LOW 
      digitalWrite(d1Pin, HIGH);   // set the D1 HIGH 
      digitalWrite(d0Pin, HIGH);   // set the D0 HIGH       
      break;
      
    case 5:
      //put 010 on 3 lines
      digitalWrite(d2Pin, LOW);   // set the D2 LOW 
      digitalWrite(d1Pin, HIGH);   // set the D1 HIGH 
      digitalWrite(d0Pin, LOW);   // set the D0 LOW       
      break;
      
    case 6:
      //put 001 on 3 lines
      digitalWrite(d2Pin, LOW);   // set the D2 LOW 
      digitalWrite(d1Pin, LOW );  // set the D1 LOW
      digitalWrite(d0Pin, HIGH);  // set the D0 HIGH    
      break;
      
    case 7:
      //put 000 on 3 lines
      digitalWrite(d2Pin, LOW);   // set the D2 LOW 
      digitalWrite(d1Pin, LOW );  // set the D1 LOW
      digitalWrite(d0Pin, LOW);  // set the D0 LOW    
      break;
      
    default: 
    {
      // if nothing else matches, do the default
      // default is optional
    }
  }// end of switch case

}// end of set_value


void write_all_PWM(void)
{
   analogWrite( bluePin, b_intnsty);// write value of blue intensity on bluepin.
   analogWrite( redPin, r_intnsty);// write value of red intensity on bluepin.
   analogWrite( greenPin, g_intnsty);// write value of blue intensity on bluepin.
   
}// end of function write_all_PWM
  
void setup()
{
  // initialize all 3 the digital pins and ledPin as an output.
  pinMode(d0Pin, OUTPUT);     
  pinMode(d1Pin, OUTPUT);     
  pinMode(d2Pin, OUTPUT);     
  pinMode(ledPin, OUTPUT);     
  digitalWrite(ledPin, HIGH);   // set the LED on
  digitalWrite(d2Pin, HIGH);   // set the D2 HIGH so that it will give minimum current
  digitalWrite(d1Pin, HIGH);   // set the D1 HIGH so that it will give minimum current
  digitalWrite(d0Pin, HIGH);   // set the D0 HIGH so that it will give minimum current

  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);  
  // initialize serial port.
  Serial.begin(115200);
  Serial.println("TV Remote Demo starts! ");
  
  irrecv.enableIRIn(); // Start the receiver
  r_intnsty = g_intnsty = b_intnsty = 255;// make all LEDs off initially. 
  write_all_PWM(); // This function sets all 3 PWM variables on three pins.
  
  Serial.println("Check all 3 LEDs ON!");  
  Serial.println("Check AC load fully ON!");  
  voltage = 6;
  set_value(voltage); // set max voltage on AC load.
  lcd.clear();//
  lcd.setCursor(0, 0);
  lcd.print("Check all 3 LEDs and AC load ON!");
  lcd.setCursor(0, 1);
  lcd.print("Check AC load ON!");
  delay(1000);// keep all 3 LEDs ON for 1 second as testing of hardware.    
 
  r_intnsty = g_intnsty = b_intnsty = 0;// make all LEDs off initially. 
  write_all_PWM(); // This function sets all 3 PWM variables on three pins.
  voltage = 0;
  set_value(voltage); // set zero voltage on AC load.
  lcd.clear();//
  lcd.setCursor(0, 0);
  lcd.print("Check all 3 LEDs OFF!");
  lcd.setCursor(0, 1);
  lcd.print("Chek AC load OFF!");
  delay(1000);// keep all 3 LEDs ON for 1 second as testing of hardware.    
  
  Serial.println("Check all 3 LEDs and AC load OFF!");  
  led_index =0;// none of the LEDs is selected.
  
}// end of setup.


void loop() {
  if (irrecv.decode(&results)) {
    l = results.value;
    if (l == disp)
      {Serial.println("DISP Pressed, all LEDs OFF! ");
      r_intnsty = g_intnsty = b_intnsty = 0;// make all LEDs off.
      write_all_PWM(); // This function sets all 3 PWM variables on three pins.
    }
    
    if (l == P_up)
    {
      Serial.println("P+ Pressed, Increment Channel Number");
      led_index++; // select next LED.
      if (led_index > max_led_index) {led_index = max_led_index;}// do not allow LED number to go above 4.      
      Serial.print("New Channel Number = ");
      Serial.println(led_index);
    }// processing of P+ command done.
    

    if (l == P_down)
    {
      Serial.println("P- Pressed, Decrement Channel Number");
      led_index--; // select next LED.
      if (led_index <0) {led_index=0;}// do not allow LED number to go below 0.      
      Serial.print("New Channel Number = ");
      Serial.println(led_index);
    }// processing of P- command done.
   
    if (l == volume_up) 
    { 
      //---------------------------------------------------------------------------
      if(led_index ==1)
      {
        Serial.println("volume_Up Pressed");
        b_intnsty = b_intnsty + 25;// increment PWM value by 10%. 
        if (b_intnsty >255) {b_intnsty = 255;}// do not let it overflow 255.
        write_all_PWM(); // This function sets all 3 PWM variables on three pins.
        Serial.print("Blue intensity = ");
        Serial.println(b_intnsty);// show latest value.      
      }// end of index = 1
    
      //---------------------------------------------------------------------------
      if(led_index ==2)
      {
        r_intnsty = r_intnsty + 25;// increment PWM value by 10%. 
        if (r_intnsty >255) {r_intnsty = 255;}// do not let it overflow 255.
        write_all_PWM(); // This function sets all 3 PWM variables on three pins.
        Serial.print("RED intensity = ");
        Serial.println(r_intnsty);// show latest value.          
        
      }// end of index = 2
      //---------------------------------------------------------------------------
      if(led_index ==3)
      {
        g_intnsty = g_intnsty + 25;// increment PWM value by 10%. 
        if (g_intnsty >255) {g_intnsty = 255;}// do not let it overflow 255.
        write_all_PWM(); // This function sets all 3 PWM variables on three pins.
        Serial.print("GREEN intensity = ");
        Serial.println(g_intnsty);// show latest value.          
        
      }// end of index = 3
      
      //---------------------------------------------------------------------------
      if(led_index ==4)
      {
        voltage++;// increment voltage var by 1 step.. 
        if (voltage >6) {voltage= 6;}// do not let it overflow 6.
        set_value(voltage); // set max voltage on AC load.
        Serial.print("AC Voltage set = ");
        Serial.println(voltage);// show latest value.          
        
      }// end of index = 4
      
    }// processing of Volume Up  command done.
  
    if (l == volume_down) 
    { 
      //---------------------------------------------------------------------------
      if(led_index ==1)
      {
        Serial.println("Volume_Down Pressed");
        b_intnsty = b_intnsty - 25;// decrement PWM value by 10%. 
        if (b_intnsty <0) {b_intnsty = 0;}// do not let it underflow below 0.
        write_all_PWM(); // This function sets all 3 PWM variables on three pins.
        Serial.print("Blue intensity = ");
        Serial.println(b_intnsty);// show latest value.      
      }// end of index = 1
    
      //---------------------------------------------------------------------------
      if(led_index ==2)
      {
        r_intnsty = r_intnsty - 25;// decrement PWM value by 10%. 
        if (r_intnsty <0) {r_intnsty = 0;}// do not let it underflow below 0.
        write_all_PWM(); // This function sets all 3 PWM variables on three pins.
        Serial.print("RED intensity = ");
        Serial.println(r_intnsty);// show latest value.          
        
      }// end of index = 2
      //---------------------------------------------------------------------------
      if(led_index ==3)
      {
        g_intnsty = g_intnsty - 25;// decrement PWM value by 10%. 
        if (g_intnsty <0) {g_intnsty = 0;}// do not let it underflow below 0.
        write_all_PWM(); // This function sets all 3 PWM variables on three pins.
        Serial.print("GREEN intensity = ");
        Serial.println(g_intnsty);// show latest value.          
        
      }// end of index = 3
      
      //---------------------------------------------------------------------------
      if(led_index ==4)
      {
        voltage--;// decrement voltage var by 1 step.. 
        if (voltage <0) {voltage= 0;}// do not let it go below 0.
        set_value(voltage); // set max voltage on AC load.
        Serial.print("AC Voltage set = ");
        Serial.println(voltage);// show latest value.          
        
      }// end of index = 4

     }// processing of Volume Down  command done.   
     irrecv.resume(); // Receive the next value
     disp_all();// update results on LCD

   }// end of if for irrecv.decode(&results)
    
  
}// end of loop

    
    
/*    
    if (l == menu)            {    Serial.println("MENU Pressed");}
    if (l == jump)            {    Serial.println("JUMP Pressed");}
    if (l == zoom)            {    Serial.println("ZOOM Pressed");}
    if (l == tv_av )          {    Serial.println("TV/AV Pressed");}
    if (l == p_dot_p )        {    Serial.println("P.P Pressed");}
*/

