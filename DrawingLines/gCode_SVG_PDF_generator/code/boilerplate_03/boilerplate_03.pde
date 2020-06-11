void render2() {
  translate(width*0.1, height*0.1);
  beginShape();
  for (int i = 0; i < 1000; i++) {
    curveVertex(random(0.8*width), random(0.8*height));
  }
  endShape();
}

void render3() {
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

void render4() {
  background(255);
  int step = 20;
  for (int x = 2*step; x < width-2*step; x += step) {
    for (int y = 2*step; y < height-2*step; y += step) {

      if (random(1)>=0.5) {
        line(x, y, x + step, y + step);
      } else {
        line(x+step, y, x, y + step);
      }
    }
  }
} 

void render() {
  background(255);
  int step= 20;

  for (int y = 160; y < height - 20; y+=step) {
    beginShape();
    for (int x = 20; x < 900 - 20; x+=70) {
      float d = abs(x - 900/2); 
      float va = noise(y, x)*200*exp(-pow((900/2 - x)/100, 2));
      if (va < 20) {
        va = 0;
      }
      float yy = y-va*exp(-pow((400 - y)/20, 2));
      //var = 100.0-100.0*noise(x*0.01, y*0.01);
      //ellipse();

      curveVertex(map(x,0,900,0,width), yy);
    }
    endShape();
  }
}
