float a = 0.005;

void render() {
  //stroke(0,50);
  noFill();
  background(255);
  for (int j = 0; j< 200; j+=5) {
    beginShape();
    for (int i = 0; i< 10; i++) {
      curveVertex(80*i-30, height/2 +200*noise(i/2, j*a)-200+j*1);
      //curveVertex(20+40*i, height/2 +random(-150,150));
    }
    endShape();
  }
}
