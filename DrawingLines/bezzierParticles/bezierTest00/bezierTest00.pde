PVector mouse;
PVector[] p = new PVector[5];
PVector[] c = new PVector[8];

void setup() {
  size(1000, 500);
  mouse = new PVector(0, 0);
  for (int i = 0; i < p.length; i++) {
    p[i] = new PVector(0, 0);
  }
  for (int i = 0; i < c.length; i++) {
    c[i] = new PVector(0, 0);
  }
}

void draw() {
  stroke(0);
  background(255);
  mouse.x = constrain(mouseX, 100, width-100);
  mouse.y = mouseY;

  int h = abs(height/2 - mouseY);
  int hh = h;
  h/= 2;
  p[0].set( 20, height/2);
  p[1].set(mouse.x - hh, height/2);
  p[2].set(mouse.x, mouse.y);
  p[3].set(mouse.x + hh, height/2);
  p[4].set(width - 20, height/2);

  c[0].set(40, height/2);
  c[1].set(p[1].x - h, height/2);
  c[2].set(p[1].x + h, height/2);
  c[3].set(p[2].x - h, p[2].y);
  c[4].set(p[2].x + h, p[2].y);
  c[5].set(p[3].x - h, height/2);
  c[6].set(p[3].x + h, height/2);
  c[7].set(width - 40, height/2);



  for (int j = 0; j < 10; j++) {
    pushMatrix();

    translate((j*2-10)*(mouseX-width/2), (j*20 - 100));
    noFill();
    beginShape();
    vertex(p[0].x, p[0].y); // first point
    for (int i = 0; i < p.length - 1; i++) {
      bezierVertex(c[i*2].x, c[i*2].y, c[i*2+1].x, c[i*2+1].y, p[i+1].x, p[i+1].y);
    }
    endShape();

    stroke(100);

    popMatrix();
  }
  /*
  pushMatrix();
   
   translate(0,30);
   
   
   beginShape();
   curveVertex(p[0].x,p[0].y);
   for(int i = 0; i < p.length; i++){
   curveVertex(p[i].x,p[i].y);
   }
   curveVertex(p[4].x,p[4].y);
   endShape();
   popMatrix();
   
   */
  stroke(255, 0, 0);
  for (int i = 0; i < p.length; i++) {
    ellipse(p[i].x, p[i].y, 4, 4);
  }  

  stroke(0, 255, 0);
  for (int i = 0; i < c.length; i++) {
    ellipse(c[i].x, c[i].y, 4, 4);
  }
}