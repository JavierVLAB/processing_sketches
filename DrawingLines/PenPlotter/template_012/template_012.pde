float a = 0.005;

void render() {
  //stroke(0,50);
  int r = 160;
  noFill();
  background(255);
  for (int j = 0; j< 200; j+=5) {
    beginShape();
    for (int i = 0; i< 500; i++) {
      float x = i + 50;
      float y = height/2 +200*noise(0.0051*i, j*a)-200+j*1+80;
      float d = dist(x, y, width/2, height/2);
      if (d <= r) {
        curveVertex(x, y);
        //curveVertex(20+40*i, height/2 +random(-150,150));

      }
    }

    endShape();
  }
  ellipse(width/2, height/2, r*2, r*2);
}
