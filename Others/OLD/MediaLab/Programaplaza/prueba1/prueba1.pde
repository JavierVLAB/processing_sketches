
Stars estrellas; 
Star  est;
ArrayList<PVector> planetas;


void setup(){
  size(192, 157); 
  background(0); 
  frameRate(25);
  strokeWeight(1);
  estrellas = new Stars(25); // numeros de estrellas
}

void draw(){
  //background(0,20);
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  estrellas.update();
}

class Star{
  PVector pos, vel, ac;
  int r;
  color c;
  int posN;
  
  Star(int n){
    pos = new PVector(random(5, width-5), random(5, height-5));
    colorMode(HSB,100,100,100);
    c = color(random(100), random(30,50), random(90,100));
    colorMode(RGB,255,255,255);
    r = 3;
    vel = new PVector(random(-2, 2), random(-2, 2));
    ac = new PVector(0,0,0);
    posN = n;
  }
  
  void dibujame(){
    stroke(c,100);
    fill(c,100);
    ellipse((int) pos.x,(int) pos.y,r,r);
  }
  void update(){
    if(mouseX > width || mouseX < 0 || mouseY > height || mouseY < 0){
      ac.set(0,0,0);}
      else{
        float d = dist(pos.x, pos.y, mouseX, mouseY);
        float g = 0.1;
        ac.set(g*(-pos.x+mouseX)/d,g*(-pos.y+mouseY)/d,0); }
    vel.add(ac);
    vel.limit(2);
    
    pos.add(vel);
    
    if ((pos.x > width-r) || (pos.x < r)) {
      vel.x *= -1;
    }
    if ((pos.y > height-r) || (pos.y < r)) {
      vel.y *= -1;
    }
    
  }
  
}

class Stars{
  int nT;
  ArrayList<Star> stars; 
  
  Stars(int N){
    stars = new ArrayList<Star>();
    for(int i = 0; i < N; i++){
      stars.add(new Star(i));
    }
    
    nT = stars.size();
  }
  
  void update(){
     for(Star s : stars){
       //s.ace = 
       s.update();
       s.dibujame();
     } 
  }
  
  
  
}

ArrayList<PVector> planetTrack(){
 
 int numblob = 3;
 ArrayList<PVector> puntos;
 
 puntos = new ArrayList<PVector>();
 for(int i=0; i<3; i++){
   puntos.add(new PVector(30*i,30*i,0));
 }
 return puntos;
}

