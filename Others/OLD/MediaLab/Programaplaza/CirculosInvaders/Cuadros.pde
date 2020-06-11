class Cuadros {
  float x;
  float y;
  float vx;
  float vy;
  int r;
  int c;
  int h;
  boolean dead;
  int a;

  Cuadros(float x_, float y_, float vx_, float vy_, int aaa, int ccc) {
    //h = int(random(255));
    c = ccc;
    //c = color(255,255,255);
    //r = (int) random(253);
    x = x_;
    y = y_;
    vx = vx_;
    vy = vy_;
    r = aaa;
  }

  void update() {

    if (x < 0 || x > width) {
      //vx *= -1;
      dead = true;
    }

    if (y < 0 || y > height) {
      //vy *= -1;
      dead = true;
    }
    x += vx;
    y += vy;
  }

  void draw() {
    noFill();
    stroke(colores[c]);
    ellipse(x, y, r, r);
  }

  void explota() {
    if (r > 2) {
      int r2 = int(r/2);
      if(vx >= 0){
      puntos.add(new Cuadros(x+r2, y, vx, vy, r2, c));
      puntos.add(new Cuadros(x-r2, y, -vx, vy, r2, c));
      } else {
        puntos.add(new Cuadros(x-r2, y, vx, vy, r2, c));
      puntos.add(new Cuadros(x+r2, y, -vx, vy, r2, c));
      }
    }
  }
}


