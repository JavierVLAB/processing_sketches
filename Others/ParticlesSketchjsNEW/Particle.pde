class Particle {
  PVector pos;
  PVector vel;
  float radius;
  color c;
  float theta;
  float drag;
  float wander = 0.15;
  boolean alive;

  Particle(float x_, float y_, int r) {
    radius = r;
    pos = new PVector(x_, y_);
    vel = new PVector(x_, y_);
    c = color(255, 255, 255);
    drag = 0.92;
    theta = random(TWO_PI);
    alive = true;
  }

  void move() {
    pos.add(vel);
    vel.mult(drag);

    theta = random(-0.5, 0.5) * wander;
    vel.x += sin(theta) * 0.1;
    vel.y += cos(theta) * 0.1;
    radius -= 0.8;
    alive = radius > 0.5 ? true: false;
  }

  void display() {
    noStroke();
    fill(c);
    ellipse(pos.x, pos.y, radius, radius);
  }
}