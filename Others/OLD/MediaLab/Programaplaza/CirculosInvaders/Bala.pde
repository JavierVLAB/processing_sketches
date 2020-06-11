class Bala {
  int x, y;
  int v;
  int cc;
  boolean dead;

  Bala(float x_, int ccc) {
    x = int(x_);
    //c = c_;
    y = height;
    dead = false;
    v = 4;
    cc = ccc;
    //println(y);
  }

  void display() {
    y -= v;
    if (y<0) {
      dead = true;
    }
    fill(colores[cc]);
    noStroke();
    ellipse(x, y, 4, 8);
  }
}
