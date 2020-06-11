void render2() {
  translate(width*0.1, height*0.1);
  beginShape();
  for (int i = 0; i < 1000; i++) {
    curveVertex(random(0.8*width), random(0.8*height));
  }
  endShape();
}

void render() {
  background(255);
  noFill();
  for (int x = 30; x < width-130; x+=5) {
    beginShape();
    for (int y = 50; y < height-50; y+=5) {
      curveVertex(x+100*noise(x*0.003, y*0.01), y);
    }
    endShape();
  }
}
