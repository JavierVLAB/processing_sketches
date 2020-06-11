ParticleSystem system;

void setup() {
  size(1000, 600);
  system = new ParticleSystem();
  for (int i = 0; i < 20; i++) {
    system.addParticle();
  }
  smooth();
}

void draw() {
  //background(51);
  background(0);
  //fill(51,10);
  //rect(0,0,width,height);


  //system.addParticle();
  system.run();
  println(frameRate);
}





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



/// System

class ParticleSystem { 

  ArrayList<Particle> particles = new ArrayList<Particle>();


  void addParticle() {
    particles.add(new Particle());
  }

  void run () {
    for (Particle p : particles) {
      p.run();
    }

    intercepBezzier();
  }

  void intercepBezzier() {


    for (int lineH = 5; lineH < height; lineH += 10) {
      ArrayList<PVector> interceptions = new ArrayList<PVector>();
      for (Particle p : particles) {
        if (abs(p.pos.y - lineH) <= 40) {
          interceptions.add(new PVector(p.pos.x, 40 - abs(lineH - p.pos.y), p.L));
        }
      }

      drawBezzier(lineH, interceptions);
    }
  }

  void drawBezzier(float y, ArrayList<PVector> interceps) {

    //noFill();
    fill(0);
    strokeWeight(1.5);
    stroke(255);
    pushMatrix();
    rotate(0.1);
    translate(100, -100);
    //ellipse(0,y,10,10);
    beginShape();
    //curveVertex(-20, height + 20);
    curveVertex(-1, y);
    curveVertex(0, y);
    //for (int i = 0; i <= width; i += 5) {
    //  curveVertex(i, y - gauss(i, interceps));
    //}

    for (int i = 0; i <= width; i += 5) {
      float y_test = gauss(i, interceps);
      if (y_test > 0.2) {
        curveVertex(i, y - y_test);
      }
    }


    curveVertex(width, y);
    curveVertex(width+1, y);
    curveVertex(-2, y);

    //curveVertex(width + 20, height + 20);
    endShape(CLOSE);
    popMatrix();
  }

  float gauss(float x, ArrayList<PVector> points) {
    float result = 0.0;
    for (PVector p : points) {
      result += p.z * p.y * exp(-pow(x - p.x, 2) / 500);
    }
    return result;
  }
}
