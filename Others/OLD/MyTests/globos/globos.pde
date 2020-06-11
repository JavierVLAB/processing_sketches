Circle[] losCircles = {};
float Vsubida = 0.3;
float vientox, vientoy;

void setup(){
 size(750,500);
 background(255);  
 smooth();
 drawCircles(); 
}

void draw(){
  background(255);
  for(int i=0; i < losCircles.length; i++){
    Circle esteputoCircle = losCircles[i];
    esteputoCircle.update();
  }
  
}

void drawCircles(){
 
  for(int i=0; i<5; i++){
  Circle esteCircle = new Circle();
  losCircles = (Circle[])append(losCircles,esteCircle); 
 }   
}

void mouseReleased(){
  drawCircles();
}


class Circle{
  float x, y;
  float radius;
  float Vx, Vy;

  Circle(){
    x = random(width);
    y = height - random(10);
    radius = random(100)+100;
    Vx = 0;
    Vy = -Vsubida;
  }
  
  void pintame(){
    noStroke();
    fill(0,0,200,50);
    ellipse(x,y,radius/2,radius/2);
  }

  void update(){
    Vx += (random(20)-10)/250;
    Vy += (random(20)-10)/250;
    x += Vx;
    y += Vy;
    if(x > (width+radius)){x = 0 - radius;};
    if(x < (0-radius)){x = width + radius;};
    if(y > (height+radius)){y = 0 - radius;};
    if(y < (0-radius)){y = height + radius;};
    pintame();
  }


}
