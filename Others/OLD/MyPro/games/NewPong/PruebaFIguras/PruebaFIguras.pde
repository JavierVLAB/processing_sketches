import processing.opengl.*;




PGraphics dibpelota;


void setup(){
  size(300,300,OPENGL);
  smooth();
  dibpelota = createGraphics(80, 80,OPENGL);
  
  

  
}


void draw(){
  background(0);
  
 
  dibpelota.beginDraw();
  dibpelota.background(0,0);
  dibpelota.translate(40,40,0);
  dibpelota.sphere(20);
  dibpelota.endDraw();
  
   int centX = 100;
   int centY = 100;
   int tamano = 20;
   
   
  noStroke();
  fill(100);
  ellipse(centX,centY,tamano,tamano);
  fill(0,20);
  ellipse(centX,centY,tamano*0.8,tamano*0.8);
  fill(255,20);
  ellipse(centX,centY-tamano*0.5/2,tamano*0.8,tamano*0.4);
  ellipse(centX,centY-tamano*0.3,tamano*0.4,tamano*0.2);
 
  image(dibpelota,0,0);
 
}
