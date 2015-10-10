/*
 * IRremote: IRrecvDemo - demonstrates receiving IR codes with IRrecv
 * An IR detector/demodulator must be connected to the input RECV_PIN.
 * Version 0.1 July, 2009
 * Copyright 2009 Ken Shirriff
 * http://arcfn.com
 
 Modified by P W Dandekar on 5th October 2011.
 
 */

#include <IRremote.h>
// include the library code:
#include <LiquidCrystal.h>


#define redPin   9   // Blue LED is fed by PWM on pin 9 
#define greenPin 10    // Green LED is fed by PWM on pin 10
#define bluePin  11    // Blue LED is fed by PWM on pin 11 

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(13,12, 5, 4, 3, 2);


int b_intnsty, r_intnsty,g_intnsty; // define 3 variable for intensity of LED to be used in PWM value.
int led_index; // used as a pointer to select one particular LED at a time. It will have value 0 = None, 1= Blue; 2 = red and 3 = Green.


const unsigned long P_up = 0x20; 
const unsigned long P_down = 0x21; 
const unsigned long volume_up = 0x10; 
const unsigned long volume_down = 0x11; 
const unsigned long search = 0x1E; 
const unsigned long alt = 0x22; 
const unsigned long FT_plus = 0x2B; 
const unsigned long FT_minus = 0x2C; 
const unsigned long AV = 0x38; 
const unsigned long PP = 0x0E; 
const unsigned long disp = 0x0F; 
const unsigned long mute = 0x0D; 
const unsigned long store = 0x29; 
const unsigned long timer = 0x26; 
const unsigned long multichannel = 0x0A; 
const unsigned long sfx = 0x24;
const unsigned long menu = 0x3B; 

int RECV_PIN = 8; // in Robo sanguino we use ATmega644 whose PB3 (PWM) is at digital pin 3 
unsigned long l;
int temp;
IRrecv irrecv(RECV_PIN);

decode_results results;

void disp_all(void)
{
  lcd.clear(); // clear previous data on both lines.  
  lcd.setCursor(0, 0);// set cursor to top row col 0.
  lcd.print("led_index");// show label
  lcd.setCursor(11, 0);// set cursor to top row col 11.
  lcd.print(led_index);// show value of label.
  lcd.setCursor(0, 1);// set cursor to second row col 0.
  lcd.print(b_intnsty);// show value of blue intensity.
  lcd.setCursor(5, 1);// set cursor to second row col 5.
  lcd.print(r_intnsty);// show value of red intensity.
  lcd.setCursor(10, 1);// set cursor to second row col 10.
  lcd.print(g_intnsty);// show value of green intensity.
  
}


void write_all_PWM(void)
{
   analogWrite( bluePin, b_intnsty);// write value of blue intensity on bluepin.
   analogWrite( redPin, r_intnsty);// write value of red intensity on bluepin.
   analogWrite( greenPin, g_intnsty);// write value of blue intensity on bluepin.
   
}// end of function write_all_PWM
  
void setup()
{
  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  // Print a message to the LCD.
  lcd.print("TV Remote Demo...");
  // set the cursor to column 0, line 1
  // (note: line 1 is the second row, since counting begins with 0):
  lcd.setCursor(0, 1);
  // print the number of seconds since reset:
  lcd.print(millis()/1000);
  
  // initialize serial port.
  Serial.begin(9600);
  Serial.println("TV Remote Demo starts! ");
  
  irrecv.enableIRIn(); // Start the receiver
  r_intnsty = g_intnsty = b_intnsty = 255;// make all LEDs off initially. 
  write_all_PWM(); // This function sets all 3 PWM variables on three pins.
  Serial.println("Check all 3 LEDs ON!");  
  delay(1000);// keep all 3 LEDs ON for 1 second as testing of hardware.
  r_intnsty = g_intnsty = b_intnsty = 0;// make all LEDs off initially. 
  write_all_PWM(); // This function sets all 3 PWM variables on three pins.
  Serial.println("Check all 3 LEDs OFF!");  

  led_index =0;// none of the LEDs is selected.
  
}// end of setup.


void loop() {
  if (irrecv.decode(&results)) 
  {
    l = results.value;
    if (l>0x7FF)
    {
      l = l - 0x800; // if code is 800H onwards then subrract base value 800 Hex.Now the code is normalized.
    }
    
    // Decode which key has been pressed and take appropriate action. May use switch case also here..
    if (l == search)            {    Serial.println("SEARCH Pressed");}
    if (l == alt)            {    Serial.println("ALT Pressed");}
    if (l == FT_plus)            {    Serial.println("FT+ Pressed");}
    if (l == FT_minus)            {    Serial.println("FT- Pressed");}
    if (l == AV )          {    Serial.println("AV Pressed");}
    if (l ==  PP )        {    Serial.println("PP Pressed");}
    if (l == mute)            {    Serial.println("MUTE Pressed");}
    if (l == store)            {    Serial.println("STORE Pressed");}
    if (l == timer)            {    Serial.println("TIMER Pressed");}
    if (l == multichannel)            {    Serial.println("-/-- Multi digiti selector for channels Pressed");}
    if (l == sfx)            {    Serial.println("SFX Pressed");}
    if (l == menu)            {    Serial.println("MENU Pressed");}
    
    if( (l>=0) && (l<=9)  )
   {// if the code is between 0 to 9 then print that it self as digit
      Serial.print("Digit Pressed =  ");
      Serial.println(l);
      
   }

    
    
    if (l == disp)
      {Serial.println("DISP Pressed, all LEDs OFF! ");
      r_intnsty = g_intnsty = b_intnsty = 0;// make all LEDs off.
      write_all_PWM(); // This function sets all 3 PWM variables on three pins.
    }
    
    if (l == P_up)
    {
      Serial.println("P+ Pressed, increment LED number");
      led_index++; // select next LED.
      if (led_index >3) {led_index=3;}// do not allow LED number to go above 3.      
      Serial.print("New index value = ");
      Serial.println(led_index);
    }// processing of P+ command done.
    

    if (l == P_down)
    {
      Serial.println("P- Pressed, decrement LED number");
      led_index--; // select next LED.
      if (led_index <0) {led_index=0;}// do not allow LED number to go below 0.      
      Serial.print("New index value = ");
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
      
    }// processing of Volume Up  command done.
  
    if (l == volume_down) 
    { 
      //---------------------------------------------------------------------------
      if(led_index == 1)
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
      
     }// processing of Volume Down  command done.   
     irrecv.resume(); // Receive the next value
     disp_all();// update results on LCD

   }// end of if for irrecv.decode(&results)
    
  
}// end of loop

    
    
/*    

const unsigned long search = 0x1E; 
const unsigned long alt = 0x0F; 
const unsigned long FT_plus = 0x2B; 
const unsigned long FT_minus = 0x2C; 
const unsigned long AV = 0x38; 
const unsigned long PP = 0x0E; 
const unsigned long disp = 0x0F; 
const unsigned long mute = 0x0D; 
const unsigned long store = 0x29; 
const unsigned long timer = 0x26; 

    if (l == search)            {    Serial.println("SEARCH Pressed");}
    if (l == alt)            {    Serial.println("ALT Pressed");}
    if (l == FT_plus)            {    Serial.println("FT+ Pressed");}
    if (l == FT_minus)            {    Serial.println("FT- Pressed");}
    if (l == AV )          {    Serial.println("AV Pressed");}
    if (l == p_dot_p )        {    Serial.println("PP Pressed");}
    if (l == mute)            {    Serial.println("MUTE Pressed");}
    if (l == store)            {    Serial.println("STORE Pressed");}
    if (l == timer)            {    Serial.println("TIMER Pressed");}
    
    if( (l>=0) && (l<=9)
   {// if the code is between 0 to 9 then print that it self as digit
      Serial.println("Digit %d Pressed",l);
   }
   
*/

