class PS {
  Pelota[] balls;
  int N = 40;
  int H;

  PS(int n, int hue) {
    N = n;
    balls = new Pelota[N];
    H = hue;
    for (int i = 0; i < N; i++) {
      balls[i] = new Pelota(hue);
    }
  }

  void dibuja() {
    for (int i = 0; i < N; i++) {
      balls[i].move();
      balls[i].draw();
    }
  }

  void dibujaNet() {
 
    for (int i = 0; i < N; i++) {
      for (int j = i+1; j < N; j++) {
        if (dist(balls[i].x, balls[i].y, balls[j].x, balls[j].y) < 80) {
          stroke(H,100,100,balls[i].trans);
          line(balls[i].x, balls[i].y, balls[j].x, balls[j].y);
        }
      }
    }
  }
}

