x = [30,30];
y = [30,30];

Stars estrellas; 
Star  est;
ArrayList<PVector> planetas;


void setup(){
  size(192, 157); 
  background(0); 
  frameRate(25);
  strokeWeight(1);
  estrellas = new Stars(35); // numeros de estrellas
  planetas = new ArrayList<PVector>();
}

void draw(){
  //background(0,20);
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  planetas = planetTrack();
  //println(planetas);
  estrellas.update();
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
    r = 2;
    vel = new PVector(random(-2, 2), random(-2, 2));
    ac = new PVector(0,0,0);
    posN = n; time = 0; dead = 125+(int) random(0,125);
  }
  
  void dibujame(){
    stroke(c,100);
    fill(c,100);
    ellipse((int) pos.x,(int) pos.y,r,r);
  }
  void update(){
    vel.add(ac);
    vel.limit(2);
    
    pos.add(vel);
    
    if ((pos.x > width-r) || (pos.x < r)) {
      vel.x *= -1;
    }
    if ((pos.y > height-r) || (pos.y < r)) {
      vel.y *= -1;
    }
    //time++;
    if(time >= dead){
      time = 0;
      vel.set(random(-2,2),random(-2,2),0);
      pos.set(random(5, width-5), random(5, height-5),0);
      colorMode(HSB,100,100,100);
      c = color(random(100), random(30,50), random(94,100));
      colorMode(RGB,255,255,255);
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
 
 ArrayList<PVector> puntos = new ArrayList<PVector>();
 
 tracking.getBlobs(function(blobs) {
        
     for(int i = 0; i < blobs.length; i++ ){
            x[i] = blobs[i].x;
            y[i] = blobs[i].y;
            stroke(255); 
            line(x[i]+2,y[i],x[i]-2,y[i]);
            line(x[i],y[i]+2,x[i],y[i]-2);
            puntos.add(new PVector(x[i],y[i],0));
        }
    });
 
 
 return puntos;
}





