int _num = 300;
Circle[] _circleArr = {};
color ccc = color(255,255,255);
int time = 1;
  
    
void setup(){
  size(displayWidth, displayHeight);
  //frameRate(120);
  background(0);
  smooth();
  strokeWeight(1);
  fill(150,50);
  drawCircles();
}

void draw(){
  //background(255);
  if(time >= 5){
  noStroke();
  fill(0,10);
  rect(0,0,width,height);
  time = 0;}
  for(int i=0;i<_circleArr.length;i++){
    Circle thisCirc = _circleArr[i];
    thisCirc.updateMe();
    //thisCirc.drawMe();
  }
  
  time++;
  
}

void mouseReleased(){
  
  //drawCircles();
  //println(_circleArr.length);
  colorMode(HSB,100,100,100);
      ccc = color(random(100), random(30,50), random(94,100));
      colorMode(RGB,255,255,255);
}

void drawCircles(){
  /*for(int i=0; i < _num; i++){
    float x = random(width);
    float y = random(height);
    float radius = random(100) + 10;
    noStroke();
    ellipse(x,y,radius*2,radius*2);
    stroke(0,150);
    ellipse(x,y,10,10);
  }*/
  for(int i=0; i < _num; i++){
   Circle thisCirc = new Circle();
   //thisCirc.drawMe(); 
   _circleArr = (Circle[])append(_circleArr,thisCirc);
  }
}

class Circle{
  float x,y;
  float radius;
  color linecol,fillcol;
  float alph;
  float xmove, ymove;
  
  Circle(){
    
    x = random(width);
    y = random(height);
    radius = random(50);
    linecol = color(random(255),random(255),random(255));
    fillcol = color(random(255),random(255),random(255));
    alph = random(100);
    xmove = random(2)-1;
    ymove = random(2)-1;
  }
  
  void drawMe(){
    //noStroke();
    //fill(fillcol,alph);
    stroke(255);
    ellipse(x,y,radius*2,radius*2);
    stroke(linecol, 150);
    noFill();
    ellipse(x, y, 10, 10); 
  }
  
  void updateMe(){
    x += xmove;
    y += ymove;
    if(x > (width+radius)){x = 0 - radius;};
    if(x < (0-radius)){x = width + radius;};
    if(y > (height+radius)){y = 0 - radius;};
    if(y < (0-radius)){y = height + radius;};
    
    
    for(int i=0; i<_circleArr.length;i++){
     Circle otherCirc = _circleArr[i];
     if(otherCirc != this){
       float dis = dist( x, y, otherCirc.x, otherCirc.y);
       float overlap = dis-radius-otherCirc.radius;
       if(overlap < 0){
         float midx,midy;
         midx = (x+otherCirc.x)/2;
         midy = (y+otherCirc.y)/2;
         stroke(ccc,10);
         //fill(255, 25);//noFill();
         
         //ellipse(midx,midy,2,2);
         overlap *= -1;
         line(x,y,otherCirc.x,otherCirc.y);
       }
     } 
    }
    
    /*if(touching){
      if(alph > 0){alph--; //xmove = -xmove; ymove = -ymove;}
    }
    }else{
      if(alph < 255){alph += 1;}
    }*/
    
    //drawMe();
  }
  
}


  
