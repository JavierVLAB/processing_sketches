class Particle {

  PVector r;
  PVector v;
  PVector a;

  Particle() {

    r = new PVector(random(width), random(height));
    v = new PVector(random(-5, 5), random(-5, 5));
    a = new PVector(0, 0);
  }

  void run() {
    update();
    display();
  }

  void display() {

    ellipse(r.x, r.y, 20, 20);
  }

  void update() {
    collision();
    r.add(v);
    v.add(a);
  }

  void collision() {
    if (r.x <= 0 || r.x >= width) {
      v.x *= -1;
    }
    if (r.y <= 0 || r.y >= height) {
      v.y *= -1;
    }
  }
}