//Code

int ledPin = 13;

//setup

void setup()
{
  //initialize digital pin 
  pinMode(ledPin, OUTPUT);  // mode of pin on whom and what
}


//loop runs over and over again
void loop()
{
  digitalWrite(ledPin,HIGH); // set the led on
  delay(1000); //wait for 1 second
  digitalWrite(ledPin,LOW); // set led off
  delay(1000); //wait for 1 second and then it will turn on the led
}
