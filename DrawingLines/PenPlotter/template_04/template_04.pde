void render() {
  background(255);
  int R = 100;
  translate(width/2, height/2);
  beginShape();
  for (int i = 0; i  <  100; i++) {
    float t = 0.3;
    float x, y;
    float r = random(t);
    x = R*cos(i*0.4)*(1+r);
    y = R*sin(i*0.4)*(1+r);
    curveVertex(x, y);
  }
  endShape();
}
