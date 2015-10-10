/*
 * IRremote: IRrecvDemo - demonstrates receiving IR codes with IRrecv
 * An IR detector/demodulator must be connected to the input RECV_PIN.
 * Version 0.1 July, 2009
 * Copyright 2009 Ken Shirriff
 * http://arcfn.com
 
 Modified by P W dandekar on 17 Sept 2011.
 
 */

#include <IRremote.h>

#define bluePin  3    // Blue LED is fed by PWM on pin 3
#define redPin   5   // Blue LED is fed by PWM on pin 5
#define greenPin 6    // Green LED is fed by PWM on pin 6


int b_intnsty, r_intnsty,g_intnsty; // define 3 variable for intensity of LED to be used in PWM value.
int led_index; // used as a pointer to select one particular LED at a time. It will have value 0 = None, 1= Blue; 2 = red and 3 = Green.


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

int RECV_PIN = 11;
unsigned long l;
IRrecv irrecv(RECV_PIN);

decode_results results;

void write_all_PWM(void)
{
   analogWrite( bluePin, b_intnsty);// write value of blue intensity on bluepin.
   analogWrite( redPin, r_intnsty);// write value of red intensity on bluepin.
   analogWrite( greenPin, g_intnsty);// write value of blue intensity on bluepin.
   
}// end of function write_all_PWM
  
void setup()
{
  Serial.begin(9600);
  irrecv.enableIRIn(); // Start the receiver
  r_intnsty = g_intnsty = b_intnsty = 0;// make all LEDs off initially. 
  led_index =0;// none of the LEDs is selected.
  write_all_PWM(); // This function sets all 3 PWM variables on three pins.
  
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
      Serial.println("P_+ Pressed");
      led_index++; // select next LED.
      if (
      
      Serial.print("New index value = ");
      Serial.println(led_index);
      
      
    }


    if (l == P_down)             {    Serial.println("P_- Pressed");}
    if (l == volume_down)     {    Serial.println("volume_Down Pressed");}
    if (l == volume_up)       {    Serial.println("volume_Up Pressed");}
    if (l == menu)            {    Serial.println("MENU Pressed");}
    if (l == jump)            {    Serial.println("JUMP Pressed");}
    if (l == zoom)            {    Serial.println("ZOOM Pressed");}
    if (l == tv_av )          {    Serial.println("TV/AV Pressed");}
    if (l == p_dot_p )        {    Serial.println("P.P Pressed");}

    irrecv.resume(); // Receive the next value
  }
}
