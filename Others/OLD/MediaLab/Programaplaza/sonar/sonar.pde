float ang = 0;
float  L;
int r=1;
boolean pinta = false;
int a, b;

void setup() {
  size(500, 500);
  //frameRate(10);
  L = dist(0, 0, width/2, height/2);
}

void draw() {
  //background(0);
  fill(0, 20);
  noStroke();
  rect(0, 0, width, height);
  strokeWeight(0.5);
  int Lx=20, Ly=20;
  stroke(0,100,0);
  while (Lx < width) {
    line(Lx, 0, Lx, height);
    Lx += 20;
  }
  while (Ly < height) {
    line(0,Ly, width, Ly);
    Ly += 20;
  }



  strokeWeight(4);
  stroke(0, 200, 0);
  line(width/2, height/2, width/2+ L*cos(ang*PI/180), height/2+ L*sin(ang*PI/180));  
  ang += 1.8;
  ang = ang % 360;

  noStroke();
  fill(255);
  ellipse(mouseX, mouseY, 3, 3);
  float abc = atan2(mouseY-height/2, mouseX-width/2)*180/PI;
  if (abc<0) {
    abc += 360;
  }
  println(ang + "  " + abc); 

  if (ang < abc + 2 && ang > abc - 2) {
    pinta = true; 
    a=mouseX;
    b=mouseY;
    r = 1;
  }
  if (pinta) {
    noFill();
    strokeWeight(2);
    stroke(255, 0, 0);
    ellipse(a, b, r, r);
    r++;
  }
}

