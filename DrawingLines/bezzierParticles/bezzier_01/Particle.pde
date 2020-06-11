//Particle
class Particle {
  PVector acc;
  PVector vel;
  PVector pos;
  float L;
  color c;

  Particle() {
    acc = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));
    vel = new PVector(random(-2, 2), random(-2, 2));
    pos = new PVector (random(width), random(height));
    L = random(1, 3);
    float r = random(1);
    if (r < 0.8) {
      c = color(255, 80);
    } else if (r < 0.95) {
      c = color(0);
    } else {
      //colorMode(HSB);
      c = color(255, 0, 0, 100);
      //colorMode(RGB);
    }
  }

  void run() {
    this.borders();
    this.update();

    //this.display();
  }

  void update() {
    //this.vel.add(this.acc);
    this.pos.add(this.vel);
  }

  void borders() {
    if (pos.x >= width) {
      vel.x *= -1;
    }
    if (pos.x <= 0) {
      vel.x *= -1;
    }
    if (pos.y >= height) {
      vel.y *= -1;
    }
    if (pos.y <= 0) {
      vel.y *= -1;
    }
  }

  void display() {
    noStroke();
    fill(127);
    //ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2);
  }
}
