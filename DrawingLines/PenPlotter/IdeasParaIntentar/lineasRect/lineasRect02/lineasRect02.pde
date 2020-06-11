int counter = 1;
void setup() {
  size(600, 600);
  //rectMode(CENTER);
  
}


void draw() {
  rotate(counter*0.01);
  translate(width/2,height/2);
  rect(0-width, counter, width*2, height);
  
  
  counter += 10;
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
  rect(0-lx, y, lx*2, ly);

  for (int i = 1; i < ly/e; i++) {
    line(x-lx, y+e*i, x+lx, y+e*i);
  }
}


void keyPressed() {

  drawRect();
}
