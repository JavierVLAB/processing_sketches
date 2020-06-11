//***********************
//*Basado en una figura que puso https://www.facebook.com/alessandro.vicard
//*
//*
//***********************


void setup() {
  size(600, 600);
  drawOne();
  noLoop();
}

void drawOne() {
  int N = 10000;
  background(255);
  stroke(0, 50, 200, 50);
  fill(0, 50, 200, 20);

  for (int i = 0; i < N; i++) {
    int w = int(random(10, 30));
    int h = int(random(10, 30));
    int x = int(random(width));
    int y = int(random(height));
    rect(x, y, w, h);
  }

  stroke(255, 150);
  fill(255, 200);
  int L = 200;
  translate(width/2-L, height/2-L);
  for (int i = 0; i < N/3; i++) {
    float d = int(random(5, 10));
    int x = int(random(L*2));
    int y = int(random(L*2));
    if (dist(L, L, x, y) < L)
      ellipse(x, y, d, d);
  }
}
