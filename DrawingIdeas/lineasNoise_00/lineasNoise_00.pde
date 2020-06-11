float x = 0;
float y = 0;
int L = 50;
void setup() {
  size(1200, 400);
  noiseSeed(10);
  background(255);
}

void draw() {
  //background(255);
  noFill();
  //stroke(0, 10);
  x += 0.2;
  y = noise(x*0.003, 0)*height;

  beginShape();
  stroke(255,0,0,4);
  for (int i = 0; i < 180; i++) {
    float dL = L + noise(i*0.03, x*0.003)*100;
    curveVertex(x + dL*cos(radians(i-90)), y + dL*sin(radians(i-90)));
  }
  endShape();
  //ellipse(x, noise(x*0.003,0)*height, 10, 10);
  //ellipse(x, noise(x*0.003,0.8)*height, 10, 10);

  beginShape();
  stroke(0,0,255,4);
  y = noise(x*0.003, 0,20)*height;

  for (int i = 0; i < 180; i++) {
    float dL = L + noise(i*0.03, x*0.003)*100;
    curveVertex(x + dL*cos(radians(i-90)), y + dL*sin(radians(i-90)));
  }
  endShape();
}
