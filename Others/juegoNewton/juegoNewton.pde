int posX;
int posY;
PImage fondo;
PImage manzana;
PImage newton1;
PImage newton2;

void setup(){
  size(400,400);  
  posX = 0;
  posY = 0;
  fondo = loadImage("fondo.png");
  manzana = loadImage("manzana.png");
  newton1 = loadImage("newton1.png");
  newton2 = loadImage("newton2.png");
}

void draw(){
  background(255);
  image(fondo,0,0);
  
  if(abs(posX - mouseX) < 45 && posY > height - 90){
    image(newton2,mouseX,height-150);
  } else {
    image(newton1,mouseX,height-150);
  }
    
  //rect(mouseX, height - 45, 45, 45);

  image(manzana,posX,posY);
  
  if(posY < height){
    posY = posY + 2;
  } else {
    posY = 0;
    posX = int(random(width));
  }
}
