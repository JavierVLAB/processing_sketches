

/// System

class ParticleSystem { 
  PShape group;
  ArrayList<Particle> particles = new ArrayList<Particle>();


  void addParticle() {
    particles.add(new Particle());
  }

  void run () {
    for (Particle p : particles) {
      p.run();
    }

    group = createShape(GROUP);

    intercepBezzier();

    shape(group);
  }

  void intercepBezzier() {


    for (int lineH = 5; lineH < height; lineH += 15) {
      ArrayList<PVector> interceptions = new ArrayList<PVector>();
      for (Particle p : particles) {
        if (abs(p.pos.y - lineH) <= 60) {
          interceptions.add(new PVector(p.pos.x, 60 - abs(lineH - p.pos.y), p.L));
        }
      }

      drawBezzier(lineH, interceptions);
    }
  }

  void drawBezzier(float y, ArrayList<PVector> interceps) {
    PShape s;
    s = createShape();
    s.beginShape();
    //s.noFill();
    s.fill(co ? 0 : 255);
    s.strokeWeight(1.5);
    s.stroke(!co ? 0 : 255);
    //pushMatrix();
    //rotate(0.1);
    s.translate(-width/2, 0,-height/2);
    //translate(-width/2, 0,-height/2);
    //ellipse(0,y,10,10);

    //curvecurveVertex(-20, height + 20);
    s.curveVertex(0, 0, y);
    s.curveVertex(0, 0, y);
    for (int i = 0; i <= width; i += 15) {
      float y_test = gauss(i, interceps);
      if (y_test > 0.0000000000001) {
        s.curveVertex(i, -y_test, y);
        stroke(255,0,0);
        //point(i, -y_test, y);
      }
    }
    s.curveVertex(width, 0, y);
    s.curveVertex(width, 0, y);

    //curvecurveVertex(width + 20, height + 20);
    s.endShape();
    //popMatrix();
    //shape(s);

    group.addChild(s);
  }

  float gauss(float x, ArrayList<PVector> points) {
    float result = 0.0;
    for (PVector p : points) {
      result += p.z * p.y * exp(-pow(x - p.x, 2) / 500);
    }
    return result;
  }

  void display() {
    shape(group);
  }
}
