Circle[] pelota= {};
//Circle[] superpelota = new Circle();

int bolas = 20;
void setup() {  
   size(320,480); 
  frameRate(60); 
  
   smooth();  
   noStroke();  
   //fill(255);  
   //rectMode(CENTER);     //This sets all rectangles to draw from the center point  
   for(int i=0; i < bolas; i++){
   Circle thisCirc = new Circle();
   pelota = (Circle[])append(pelota,thisCirc);
  }
};  
  
void draw() {  
   background(0,0,0);  
   //rect(mouseX, mouseY, 150, 150);  
   for(int i=0; i < bolas; i++){
   pelota[i].updateMe();
   pelota[i].drawMe();}
   
};

class Circle{
  float x,y,vx,vy;
  float radius;
  color linecol,fillcol;
  float alph;
  float xmove, ymove;
  float masa;
  
  Circle(){
    
    x = random(width);
    y = random(height);
    
    radius = 5;
    masa = radius*radius;
    linecol = color(0,0,0);
    fillcol = color(random(155)+100,random(155)+100,random(155)+100);
    alph = 255;
    xmove = random(5)+1;
    ymove = random(4)+1;
  }
  
  
  void drawMe(){
    noStroke();
    fill(fillcol,alph);
    ellipse(x,y,radius*2,radius*2);

  }
  
  void updateMe(){
    x += xmove;
    y += ymove;
    if(x > (width)){xmove = -xmove;};
    if(x < (0)){xmove = - xmove;};
    if(y > (height)){ymove = -ymove;};
    if(y < (0)){ymove = -ymove;};   
  }
  
  
  
};



