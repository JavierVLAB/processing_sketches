void setup() {
  size(430, 300);
  frameRate(10);
}

void draw() {
  background(255);
  noFill();
  strokeWeight(10);
  stroke(0);
  rect(0, 0, width, height);

  if (random(1) < 0.1) {
    line(40, 120, 180, 120);
    line(width-100, 120, width-20, 120);
  } else {
    fill(0);
    arc(100,100, 60, 80, 0, PI+QUARTER_PI+QUARTER_PI, PIE);
    arc(width-100,100, 60, 80, 0, PI+QUARTER_PI+QUARTER_PI, PIE);
  }
}
