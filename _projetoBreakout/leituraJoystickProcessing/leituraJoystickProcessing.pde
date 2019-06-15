import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
int eixoX = 0;
int valorX;


void setup()
{
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  //arduino.Serial.begin(9600);
  
}

void draw()
{
  valorX = arduino.analogRead(eixoX);
  println(valorX);
  
}