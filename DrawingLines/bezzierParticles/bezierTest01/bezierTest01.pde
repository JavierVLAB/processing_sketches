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

  background(0, 0, 50);




  

  int step = 10;

    for (int j = 1; j < height/10; j++) {
     
    mouse.x = constrain(mouseX+j*10, 100, width-100);

    mouse.y = j*10 - constrain(40-abs(j*10 - mouseY), 0, 40); 

    float h = abs(j*10 - mouse.y);
    float hh = h;
    h/= 2;





    p[0].set( 20, j*10);
    p[1].set(mouse.x - hh, j*10);
    p[2].set(mouse.x, mouse.y);
    p[3].set(mouse.x + hh, j*10);
    p[4].set(width - 20, j*10);

    c[0].set(40, j*10);
    c[1].set(p[1].x - h, j*10);
    c[2].set(p[1].x + h, j*10);
    c[3].set(p[2].x - h, p[2].y);
    c[4].set(p[2].x + h, p[2].y);
    c[5].set(p[3].x - h, j*10);
    c[6].set(p[3].x + h, j*10);
    c[7].set(width - 40, j*10);


    strokeWeight(2);
    stroke(250, 250, 250);

    noFill();
    beginShape();
    vertex(p[0].x, p[0].y); // first point
    for (int i = 0; i < p.length - 1; i++) {
      bezierVertex(c[i*2].x, c[i*2].y, c[i*2+1].x, c[i*2+1].y, p[i+1].x, p[i+1].y);
    }
    endShape();
  }
  /*
  stroke(255, 0, 0);
   for (int i = 0; i < p.length; i++) {
   ellipse(p[i].x, p[i].y, 4, 4);
   }  
   
   stroke(0, 255, 0);
   for (int i = 0; i < c.length; i++) {
   ellipse(c[i].x, c[i].y, 4, 4);
   }
   */
}