
class Nave {
  float x, y;
  float v;
  int c;
  ArrayList<Bala>  balas;

  Nave() {
    x = random(width);

    println(y);
    v = 2;

    c = int(random(n));
    //println("si");

    balas = new ArrayList<Bala>();
    balas.add(new Bala(x, c));
  }

  void display() {
    x += v;
    if (x < 0 || x > width) {
      v *= -1;
    }
    fill(colores[c]);
    noStroke();
    rect(x, height-5, 10, 10);

    for (int i = balas.size()-1; i >= 0; i--) {
      Bala b = balas.get(i);
      b.display();
      if (b.dead) {
        balas.remove(i);
      }
    }
  }

  void disparo() {
    balas.add(new Bala(x,c));
    v *= -1;
  }
}

