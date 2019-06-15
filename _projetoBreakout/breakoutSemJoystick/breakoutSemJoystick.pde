//variáveis entrada
boolean esq, dir;

//score
int pontos;

//variaveis pad
float posX, posY, alt, larg;
color cor;

//variáveis bolinha
float bPosX, bPosY, bAlt, bLarg, bVelX, bVelY;
color bCor;

//variáveis blocos
float [] blPosX;
float [] blPosY;
boolean [] blVisivel;

float blAlt, blLarg;
color blCor;




void setup()//inicialização
{
  //tela
  size(800,600);
  background(0);
  //score
  pontos = 0;
  
  //pad
  cor = color(0,0,255);
  posX = width/2 - 50;
  posY = 570;
  alt = 20;
  larg = 100;
  //bolinha
  bCor = color(255,255,0);
  bPosX = width/2 - 5;
  bPosY = height/2 - 5;
  bAlt = 10;
  bLarg = 10;
  bVelX = bVelY = 3;
  //blocos
  blLarg = 80;
  blAlt = 30;
  blCor = color(255, 0, 0);
  
  //criar vetores
  blVisivel = new boolean[10];
  blPosX = new float[10];
  blPosY = new float[10];
  
  //preencher vetores de blocos 
  for(int i = 0; i < 10; i++)
  {
    blVisivel[i] = true;
    blPosY[i] = 50;
    blPosX[i] = i * blLarg;
  }
}

void draw()//atualização a cada frame
{
  //ENTRADA
  if(esq)
     posX -= 10; 
  else if(dir)
    posX += 10;
  
  //LÓGICA
  //atualizar bolinha
  bPosX += bVelX;
  bPosY += bVelY;
  
  //testa colisão com pad
  if(testaColisao(posX, posY, larg, alt, bPosX, bPosY, bLarg, bAlt))
    bVelY *= -1;
  
  //testa colisão com blocos
  for(int i = 0; i < blPosX.length; i++)
  {
    if(testaColisao(bPosX, bPosY, bLarg, bAlt, 
                    blPosX[i], blPosY[i], blLarg, blAlt) && blVisivel[i])
    {
      //inverter a direção em Y
      bVelY *= -1;
      //destruir o bloco
      blVisivel[i] = false;
      //incrementar score
      pontos += 100;
    
    }
  }
  //limite da bolinha na tela
  if(bPosX < 0 || bPosX > 790)//bateu do lado
    bVelX *= -1;
  if(bPosY > 590 || bPosY < 0)//bateu em cima ou em baixo
    bVelY *= -1;
  
  
  //limite do pad na tela
  if(posX < 0) 
    posX = 0;
  else if(posX > 700) 
    posX = 700;
  
  //VISUAL
  background(0);
  noStroke();
  
  //bolinha
  fill(bCor);
  rect(bPosX, bPosY,bLarg, bAlt);
  //pad
  fill(cor);
  rect(posX, posY, larg, alt);
  //blocos
  stroke(0);
  for(int i = 0; i < blPosX.length; i++)
  {
    
    if(blVisivel[i])
    {
      fill(blCor);
      rect(blPosX[i], blPosY[i], blLarg, blAlt);
    }
  }
  //score
  fill(255);
  textSize(20);
  text("score: " + pontos, 20, 30);
  
   
}

boolean testaColisao(float x1, float y1, float larg1, float alt1, 
                     float x2, float y2, float larg2, float alt2)
{
    boolean horizontal = false;
    boolean vertical = false;
    
    //colisao em x
    if(x1 < x2)//x1 mais a esq
      horizontal = abs(x2 - x1) < larg1;
    else 
      horizontal = abs(x1 - x2) < larg2;
      
    //colisao em y
    if(y1 < y2)
      vertical = abs(y2 - y1) < alt1;
    else
      vertical = abs(y1 - y2) < alt2;
    
    return horizontal && vertical; 
}

void keyPressed()
{
   if(key == CODED) 
   {
      if(keyCode == LEFT)
        esq = true;
      else if(keyCode == RIGHT)
        dir = true; 
   }
}

void keyReleased()
{
   if(key == CODED) 
   {
      if(keyCode == LEFT)
        esq = false;
      else if(keyCode == RIGHT)
        dir = false; 
   }
}