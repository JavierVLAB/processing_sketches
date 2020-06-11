import codeanticode.syphon.*;


SyphonServer server;

Stars estrellas; 
Star  est;
int tam = 4;
ArrayList<PVector> planetas;


void setup(){
  size(800,600,OPENGL);//192*tam, 157*tam); 
  background(0); 
  frameRate(60);
  strokeWeight(1);
  estrellas = new Stars(50); // numeros de estrellas
  planetas = new ArrayList<PVector>();
  
  server = new SyphonServer(this, "Processing Syphon");
  
}

void draw(){
  //background(0,20);
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  planetas = planetTrack();
  //println(planetas);
  estrellas.update();
  
  server.sendImage(get());
  
}

class Star{
  PVector pos, vel, ac;
  int r;
  color c;
  int posN, time, dead;
  
  Star(int n){
    pos = new PVector(random(5, width-5), random(5, height-5));
    colorMode(HSB,100,100,100);
    c = color(random(100), random(30,50), random(90,100));
    colorMode(RGB,255,255,255);
    r = 6;
    vel = new PVector(random(-3, 3), random(-3, 3));
    ac = new PVector(0,0,0);
    posN = n; time = 0; dead = 500+(int) random(0,1250);
  }
  
  void dibujame(){
    stroke(c,100);
    fill(c,255);
    ellipse((int) pos.x,(int) pos.y,r,r);
  }
  void update(){
    vel.add(ac);
    vel.limit(4);
    
    pos.add(vel);
    
    if ((pos.x > width-r) || (pos.x < r)) {
      vel.x *= -1;
    }
    if ((pos.y > height-r) || (pos.y < r)) {
      vel.y *= -1;
    }
    time++;
    if(time >= dead){
      time = 0;
      vel.set(random(-2,2),random(-2,2),0);
      pos.set(random(5, width-5), random(5, height-5),0);
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
       PVector ace = new PVector(0,0,0); 
       for(PVector p : planetas){
         float d = dist(s.pos.x, s.pos.y, p.x, p.y);
         float g = 0.1;
         ace.add(g*(-s.pos.x+p.x)/d,g*(-s.pos.y+p.y)/d,0);
       }
       s.ac = ace.get(); 
       s.update();
       s.dibujame();
     } 
  }  
}

ArrayList<PVector> planetTrack(){
 
 int numblob = 3;
 ArrayList<PVector> puntos;
 
 puntos = new ArrayList<PVector>();
 for(int i=0; i<0; i++){
   puntos.add(new PVector(60*i+30,60*i+30,0));
   //fill(255);
   //ellipse(60*i+30,60*i+30,1,1);
   stroke(255);
   line(60*i+30+1,60*i+30,60*i+30-1,60*i+30);
   line(60*i+30,60*i+30+1,60*i+30,60*i+30-1);
 }
 puntos.add(new PVector(mouseX,mouseY,0));
 line(mouseX+2,mouseY,mouseX-2,mouseY);
 line(mouseX,mouseY+2,mouseX,mouseY-2);
 return puntos;
}

