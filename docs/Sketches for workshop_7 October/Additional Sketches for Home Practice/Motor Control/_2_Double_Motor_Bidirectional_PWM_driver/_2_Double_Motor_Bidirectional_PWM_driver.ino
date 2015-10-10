/*   Double_Motor_Bidirectional_PWM_Driver
  
  This sketch uses a special motor control board using L293D driver IC whose Enable inputs are tied to '1' permanenetly
  and the speed control is done through direction inputs A and B. Thus to have complete direction and magnitude control, 
  we need to feed PWM signals to both direction inputs.
  
  This sketch runs two motors , one by one to demo individual control. It runs left motor in one direction from zero to full speed. 
  Then it brings down speed back to zero slowly. It repeats the same for right motor. It runs a trapezoidal speed vs time profile, 
  very common in transportaion.  The whole sequence takes about 10 to 12 seconds per motor depending upon the delay set.
  
  Then it runs the same sequence in which both motors run up to full speed and then come down.
  Circuit:
  
  First motor is connected between two pins marked LEFT on Motor Control Board
  Second motor is connected between two pins marked RIGHT on Motor Control Board
  
  Pin D3 - PWM giving signal to IN1 of L293D Board (LEFT Motor)
  Pin D5  - PWM giving signal to IN2 of L293D Board
  FWD direction: pin D3 = 1, pin D5 =0
  REV direction: pin D3 = 0, pin D5 =1
  STOP: pin D3 = 0, pin D5 =0
 
  Pin D6 - PWM giving signal to IN3 of L293D Board (RIGHT Motor)
  Pin D9  - PWM giving signal to IN4 of L293D Board (RIGHT Motor)
 
  Originaly written by P W Dandekar in June 2011, modified on 29 Sept 2015.
 
 */
 
#define  IN1   3
#define  IN2   5
#define  IN3   6
#define  IN4   9

#define d_count 50  // this defines delay in milliseconds between two speed increment or decrement

void set_PWM(int motor_no, int dir, int pwm_value);


void setup() {
  // set up 4 PWM output pins used in motor driver in output mode.This is not mandatory
  pinMode(IN1, OUTPUT);   
  pinMode(IN2 , OUTPUT);   
  pinMode(IN3, OUTPUT);   
  pinMode(IN4 , OUTPUT);   

  Serial.begin(9600);// 
  Serial.println("2 Motor Bidirectional speed profile demo starting up...");// sent starting message to serial monitor.
  delay (2000);// wait for 2 seconds.
 
}

void loop() {
  int i;
  
//---------------------------------------LEFT MOTOR ALONE -------------------------------------------------------------------------------

  Serial.println("Left Motor CW Increasing Speed...");// sent current state message to serial monitor.

  // Run Left Motor in Clockwise (CW) direction from 0 to 255 PWM value ( 0 to 100%) INCREASING SPEED

  for (i=0;i<=255;i++) // rising speed in CW direction
  {  // set PWM pulse width from 0 to 255 in steps of 1.
    set_PWM( 0, 0,  i);// Left motor, CW and PWM = i
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  
  Serial.println("Left Motor CW decreasing Speed...");// sent current state message to serial monitor.
  // Run Left Motor in Clockwise (CW) direction from 255 to 0 PWM value ( 100% to 0%) DECREASING SPEED
  for (i=255; i>=0; i--) // falling speed in CW direction
  {  // set PWM pulse width from 255 to 0 in steps of 1.
    set_PWM( 0, 0,  i);// Left motor, CW and PWM = i
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  

//----------------------------------------------------------------------------------------------------------------------

  Serial.println("Left Motor CCW Increasing Speed...");// sent current state message to serial monitor.

  // Run Left Motor in Counter-Clockwise (CCW) direction from 0 to 255 PWM value ( 0 to 100%) INCREASING SPEED
  for (i=0;i<=255;i++) // rising speed in CCW direction
  {  // set PWM pulse width from 0 to 255 in steps of 1.
    set_PWM( 0, 1, i);// Left motor, CCW and PWM = i
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  
  Serial.println("Left Motor CCW Decreasing Speed...");// sent current state message to serial monitor.
  
  // Run Left Motor in Counter-Clockwise (CCW) direction from 255 to 0 PWM value ( 100% to 0%) DECREASING SPEED
  for (i=255;i>=0;i--) // falling speed in CCW direction
  {  // set PWM pulse width from 255 to 0 in steps of 1.
    set_PWM( 0, 1,  i);// Left motor, CCW and PWM = i
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second  
  
  
  //---------------------------------------RIGHT MOTOR ALONE -------------------------------------------------------------------------------
  Serial.println("Right Motor CW Increasing Speed...");// sent current state message to serial monitor.
 
  // Run Right Motor in Clockwise (CW) direction from 0 to 255 PWM value ( 0 to 100%) INCREASING SPEED

  for (i=0;i<=255;i++) // rising speed in CW direction
  {  // set PWM pulse width from 0 to 255 in steps of 1.
    set_PWM( 1, 0,  i);// Right motor, CW and PWM = i
    analogWrite(IN3,i);// set PWM value i on IN3.
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  Serial.println("Right Motor CW Decreasing Speed...");// sent current state message to serial monitor.
  
  // Run Left Motor in Clockwise (CW) direction from 255 to 0 PWM value ( 100% to 0%) DECREASING SPEED
  for (i=255;i>=0;i--) // falling speed in CW direction
  {  // set PWM pulse width from 255 to 0 in steps of 1.
    set_PWM( 1, 0,  i);// Right motor, CW and PWM = i
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  

//----------------------------------------------------------------------------------------------------------------------
  Serial.println("Right Motor CCW Increasing Speed...");// sent current state message to serial monitor.

  // Run Left Motor in Counter-Clockwise (CCW) direction from 0 to 255 PWM value ( 0 to 100%) INCREASING SPEED
  for (i=0;i<=255;i++) // rising speed in CCW direction
  {  // set PWM pulse width from 0 to 255 in steps of 1.
    set_PWM( 1, 1,  i);// Right motor, CCW and PWM = i
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  
   Serial.println("Right Motor CCW Decreasing Speed...");// sent current state message to serial monitor.
 
  // Run Left Motor in Counter-Clockwise (CCW) direction from 255 to 0 PWM value ( 100% to 0%) DECREASING SPEED
  for (i=255;i>=0;i--) // falling speed in CCW direction
  {  // set PWM pulse width from 255 to 0 in steps of 1.
    set_PWM( 1, 1,  i);// Right motor, CCW and PWM = i
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second  



  //---------------------------------------BOTH MOTORs TOGETHER -------------------------------------------------------------------------------
  Serial.println("Both Motors CW Increasing Speed...");// sent current state message to serial monitor.

  // Run Both Motors in Clockwise (CW) direction from 0 to 255 PWM value ( 0 to 100%) INCREASING SPEED

  for (i=0;i<=255;i++) // rising speed in CW direction
  {  // set PWM pulse width from 0 to 255 in steps of 1.
    set_PWM( 0, 0,  i);// Left motor, CW and PWM = i
    set_PWM( 1, 0,  i);// Right motor, CW and PWM = i
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  Serial.println("Both Motors CW Decreasing Speed...");// sent current state message to serial monitor.
  
  // Run Left Motor in Clockwise (CW) direction from 255 to 0 PWM value ( 100% to 0%) DECREASING SPEED
  for (i=255;i>=0;i--) // falling speed in CW direction
  {  // set PWM pulse width from 255 to 0 in steps of 1.
    set_PWM( 0, 0,  i);// Left motor, CW and PWM = i
    set_PWM( 1, 0,  i);// Right motor, CW and PWM = i
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  

//----------------------------------------------------------------------------------------------------------------------
  Serial.println("Both Motors CCW Increasing Speed...");// sent current state message to serial monitor.

  // Run Both Motors in Counter-Clockwise (CCW) direction from 0 to 255 PWM value ( 0 to 100%) INCREASING SPEED
  
  for (i=0;i<=255;i++) // rising speed in CCW direction
  {  // set PWM pulse width from 0 to 255 in steps of 1.
    set_PWM( 0, 1,  i);// Left motor, CCW and PWM = i
    set_PWM( 1, 1,  i);// Right motor, CCW and PWM = i
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  delay(1000);// wait here for 1 second
  
    Serial.println("Both Motors CCW Decreasing Speed...");// sent current state message to serial monitor.

  // Run Both Motors in Counter-Clockwise (CCW) direction from 255 to 0 PWM value ( 100% to 0%) DECREASING SPEED
  for (i=255;i>=0;i--) // falling speed in CCW direction
  {  // set PWM pulse width from 255 to 0 in steps of 1.
    set_PWM( 0, 1,  i);// Left motor, CCW and PWM = i
    set_PWM( 1, 1,  i);// Right motor, CCW and PWM = i
    delay(d_count);// wait for this many ms after each increment.     
  }// end of for loop. 
  
  Serial.println("Complete sequence done.");// sent current state message to serial monitor.

  delay(1000);// wait here for 1 second  





}// end of main

void set_PWM(int motor_no, int dir, int pwm_value)
{

  // ensure that PWM value is witin 0 to 255 else force it.
  if (pwm_value <0){pwm_value=0;}
  if (pwm_value >255){pwm_value=255;}
  
  // now based on motor and direction, allocate pwm_value to one channel and 0 to another.
  // To the non-selected motor, do nothing.
  if (motor_no ==0)  // it is left motor
  {
    if (dir == 0)    // it is clock wise
    {
      analogWrite(IN2,0);// set PWM value 0 on IN2. 
      analogWrite(IN1,pwm_value);// set value on IN1.      
    }
    else            // it is counter clock wise
    {
      analogWrite(IN1,0);// set PWM value 0 on IN1. 
      analogWrite(IN2,pwm_value);// set value on IN2. 
      
    }// end of inner if    
  }
  else  // it is right motor
  {
     if (dir ==0)    // it is clock wise
    {
      analogWrite(IN4,0);// set PWM value 0 on IN4. 
      analogWrite(IN3,pwm_value);// set value on IN3.      
    }
    else            // it is counter clock wise
    {
      analogWrite(IN3,0);// set PWM value 0 on IN3. 
      analogWrite(IN4,pwm_value);// set value on IN4. 
    }// end of inner if
   
  }// end of outer if
  
    

}// end of set_PWM


