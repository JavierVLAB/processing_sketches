class ParticleSystem {
  ArrayList<Particle> particles;

  PShape particleShape;

  ParticleSystem(int n) {
    particles = new ArrayList<Particle>();
    particleShape = createShape(PShape.GROUP);

    for (int i = 0; i < n; i++) {
      Particle p = new Particle();
      particles.add(p);
      particleShape.addChild(p.getShape());
    }
  }

  void update() {
    for (Particle p : particles) {
      p.update();
    }
  }

  void setEmitter(float x, float y, float z) {
    for (Particle p : particles) {
      if (p.isDead()) {
        p.rebirth(x, y, z);
      }
    }
  }

  void display() {

    shape(particleShape);
  }
}


class Particle {

  PVector velocity;
  float lifespan = 255;
  
  PShape part;
  float partSize;
  
  PVector gravity = new PVector(0,-0.1,0);


  Particle() {
    partSize = random(10,60);
    part = createShape(QUAD);
    part.noStroke();
    part.texture(sprite);
    part.normal(0, 0, 1);
    part.vertex(-partSize/2, -partSize/2, 0, 0);
    part.vertex(+partSize/2, -partSize/2, sprite.width, 0);
    part.vertex(+partSize/2, +partSize/2, sprite.width, sprite.height);
    part.vertex(-partSize/2, +partSize/2, 0, sprite.height);
    part.end();
    
    rebirth(width/2,height/2,0);
    lifespan = random(255);
  }

  PShape getShape() {
    return part;
  }
  
  void rebirth(float x, float y, float z) {
    float a = random(TWO_PI);
    float speed = random(0.5,4);
    velocity = new PVector(cos(a), sin(a));
    velocity.mult(speed);
    lifespan = 255;   
    part.resetMatrix();
    part.translate(x, y, z); 
  }
  
  boolean isDead() {
    if (lifespan < 0) {
     return true;
    } else {
     return false;
    } 
  }
  

  public void update() {
    lifespan = lifespan - 1;
    velocity.add(gravity);
    
    part.tint(255,lifespan);
    part.translate(velocity.x, velocity.y, velocity.z);
  }
}
