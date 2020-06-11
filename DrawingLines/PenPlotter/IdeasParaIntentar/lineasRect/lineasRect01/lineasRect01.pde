void setup() {
  size(600, 600);
  //rectMode(CENTER);
}


void draw() {
    drawRect();
}

void drawRect() {
  float x = random(width);
  float y = random(height);
  float ang = random(2*PI);
  float lx = random(1500, 2500);
  float ly = random(40, 160);
  float e = random(5, 20);
  stroke(0);
  rotate(ang);
  rect(x-lx, y, lx*2, ly);

  for (int i = 1; i < ly/e; i++) {
    line(x-lx, y+e*i, x+lx, y+e*i);
  }
}


void keyPressed() {

  drawRect();
}
