int joystick = 0;
 
//Atribuindo o pino analógico A0 a variável eixoX
int eixoX = A0;
 
void setup() {

  Serial.begin(9600);
}
 
void loop() {
  //Lê o valor do eixoX
  joystick = analogRead(eixoX);
 
  //imprime o valor do eixoX
  Serial.print("  X=");
  Serial.println(joystick);
 
  delay(200); 
}
