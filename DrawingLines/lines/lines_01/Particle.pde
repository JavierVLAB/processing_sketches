// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Simple Particle System

// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float L;
  float angle;
  color c;
  float da;

  Particle() {
    init();
  }

  void init() {
    acceleration = new PVector(random(-0.01, 0.01), random(-0.01, 0.01));
    velocity = new PVector(random(-1, 1), random(-1, 1));
    position = new PVector(random(width), random(height));
    lifespan = 255.0;
    L = random(10, 70);
    float r = random(1);
    
    if (r < 0.8) {
      c = color(255, 80);
    } else if (r < 0.95) {
      c = color(0);
    } else {
        //colorMode(HSB);
      c = color(255,0,0,100);
      //colorMode(RGB);
    }
    
    //c = color(0, 80);
    //c = color(random(100, 255), random(100, 255), random(100, 255));
    da = random(0.01, 0.05);
  }


  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    angle += da;
    velocity.add(acceleration);
    position.add(velocity);
    //lifespan -= 2.0;
  }

  // Method to display
  void display() {
    PVector p = new PVector(0, 0);
    p.x = L*cos(angle)+position.x;
    p.y = L*sin(angle)+position.y;
    stroke(c, 100);
    //ellipse(position.x, position.y, 12, 12);
    line(position.x, position.y, p.x, p.y);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (position.y < 0.0 || position.y > height || position.x > width || position.x < 0) {
      return true;
    } else {
      return false;
    }
  }
}