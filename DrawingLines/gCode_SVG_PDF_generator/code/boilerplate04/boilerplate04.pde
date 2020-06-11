void render() {


  noFill();

  for (int y = 40; y < height - 40; y+=4) {
    beginShape();
    for (int x = 20; x < width - 20; x+=2) {

      if (dist(x, y, width/2, height/2) < 200) {
        curveVertex(x, y+noise(x*0.008, y*0.01)*60-30);
      }
    }
    endShape();
  }
}
