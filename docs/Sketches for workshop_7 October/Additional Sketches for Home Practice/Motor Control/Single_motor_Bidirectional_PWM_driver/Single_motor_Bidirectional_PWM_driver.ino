/*   Single_Motor_Bidirectional_PWM_Driver
  
  This sketch uses a special motor control board using L293D driver IC whose Enable inputs are tied to '1' permanenetly
  and the speed control is done through direction inputs A and B. Thus to have complete direction and magnitude control, 
  we need to feed PWM signals to both direction inputs.
  
  This sketch runs motor in one direction from zero to full speed. Then it brings down speed back to zero slowly.
  It runs a trapezoidal speed vs time profile, very common in transportaion.
  
  It repeats above steps for another direction. The whole sequence takes about 10 to 12 seconds depending upon the delay set.
  
  Circuit:
  
  Motor wires connected to LEFT Motor pins on L293D Board
  
  Pin D3 - PWM giving signal to IN1 of L293D Board
  Pin D5  - PWM giving signal to IN2 of L293D Board
  FWD direction: pin D3 = 1, pin D5 =0
  REV direction: pin D3 = 0, pin D5 =1
  STOP: pin D3 = 0, pin D5 =0
 
  Originaly written by P W Dandekar in June 2011, modified on 29 Sept 2015.
 
 */
 
#define  IN1   3
#define  IN2   5
#define d_count 50  // this defines delay in milliseconds between two speed increment or decrement

void setup() {
  // set up 2 PWM output pins used in motor driver in output mode.This is not mandatory
  pinMode(IN1, OUTPUT);   
  pinMode(IN2 , OUTPUT);   
}

void loop() {
  int i;
  
//----------------------------------------------------------------------------------------------------------------------
  // Run Motor in Clockwise (CW) direction from 0 to 255 PWM value ( 0 to 100%) INCREASING SPEED
  analogWrite(IN2,0);// set PWM value 0 on IN2. Whenever IN1 will be 1 the motor will rotate in forward direction.

  for (i=0;i<=255;i++) // rising speed in CW direction
  {  // set PWM pulse width from 0 to 255 in steps of 1.
    analogWrite(IN1,i);// set PWM value i on IN1.
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  
  // Run Motor in Clockwise (CW) direction from 0 to 255 PWM value ( 0 to 100%) DECREASING SPEED
  for (i=255;i>=0;i--) // falling speed in CW direction
  {  // set PWM pulse width from 255 to 0 in steps of 1.
    analogWrite(IN1,i);// set PWM value i on IN1.
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  

//----------------------------------------------------------------------------------------------------------------------
  // Run Motor in Counter-Clockwise (CCW) direction from 0 to 255 PWM value ( 0 to 100%) INCREASING SPEED
  analogWrite(IN1,0);// set PWM value 0 on IN2.Whenever IN2 will be 1 the motor will rotate in forward direction.
  for (i=0;i<=255;i++) // rising speed in CCW direction
  {  // set PWM pulse width from 0 to 255 in steps of 1.
    analogWrite(IN2,i);// set PWM value i on IN2.
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  
  
  // Run Motor in Counter-Clockwise (CCW) direction from 0 to 255 PWM value ( 0 to 100%) DECREASING SPEED
  for (i=255;i>=0;i--) // falling speed in CCW direction
  {  // set PWM pulse width from 255 to 0 in steps of 1.
    analogWrite(IN2,i);// set PWM value i on IN2.
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second  
  
}

