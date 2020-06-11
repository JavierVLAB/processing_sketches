int L = 100;
float w = 1;


Oscillator os1 = new Oscillator(L, w, 0.0001, 0);
Oscillator os2 = new Oscillator(L, w+1, 0, PI/4);
Oscillator os3 = new Oscillator(L, w, 0.0, 0);
Oscillator os4 = new Oscillator(L, w+0.005, 0.00025, PI);

PVector p1 = new PVector(0, 0);
PVector p2 = new PVector(0, 0);
PVector q1 = new PVector(0, 0);
PVector q2 = new PVector(0, 0);
PVector q = new PVector(0, 0);
float t = 0;

void setup() {
  size(700, 700);
  smooth();
  background(255);
  strokeWeight(0.2);
  stroke(0, 100);
}

void draw() {
  noFill();
  pushMatrix();
  
  translate(width/2, height/2);
  rotate(radians(t*0.1));
  translate(50, 0);
  beginShape();
  for (int i= 0; i < 50; i++) {

    float x = os1.position(t)+os2.position(t);
    float y = os3.position(t)+os4.position(t);
    PVector p = new PVector(x, y);
    //line(p.x, p.y, q.x, q.y);
    //ellipse(p.x,p.y,10,10);
    vertex(x, y);
    q = p.copy();
    t+=0.025;
  }
  endShape();
  popMatrix();
  
  t-=0.025;
}