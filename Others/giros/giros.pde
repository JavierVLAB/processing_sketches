float t = 0;

void setup() {
  size(800, 800);
  rectMode(CENTER);
  background(255);
  ellipse(0, 0, 10, 12);
  strokeWeight(2);
  //fill(255,0,0);
  noStroke();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  for (int i = 50; i > 0; i--) {
    if (i % 2 == 0) {
      fill(255);
    } else {
      fill(0);
    }
    rotate(radians(sin(t)*i/5));
    rect(0, 0, 20*i, 20*i);
    //ellipse(0,0,50*i,20*i);
  }


  t += 0.03;
}
