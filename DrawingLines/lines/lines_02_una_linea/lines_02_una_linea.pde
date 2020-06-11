Particle p1;
Particle p2;
Particle p3;
Particle p4;


void setup() {
  size(700, 700);
  smooth();
  p1 = new Particle();
  p2 = new Particle();
  p4 = new Particle();
  p3 = new Particle();


  background(0);
  noFill();
}

void draw() {

  p1.update();
  p2.update();
  p3.update();
  p4.update();

  stroke(255, 20);
  line(p1.position.x, p1.position.y, p2.position.x, p2.position.y);
  
  stroke(0, 15);
  line(p3.position.x, p3.position.y, p4.position.x, p4.position.y);
  //ellipse(p1.position.x, p1.position.y, 10, 10);
  //ellipse(p2.position.x, p2.position.y, 10, 10);
}
