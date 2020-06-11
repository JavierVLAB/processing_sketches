import SimpleOpenNI.*;
SimpleOpenNI kinect;

boolean handFlag = false;

ParticleSystem ps;
PImage sprite;  

PVector  pos;
void setup() {
  size(640, 480, P2D);
  frameRate(30);
  orientation(LANDSCAPE);
  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(500);

  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  //enable depthMap generation
  kinect.enableDepth();
  kinect.enableRGB();
  // enable hands + gesture generation 1
  kinect.enableGesture();
  kinect.enableHands();
  kinect.addGesture("RaiseHand"); 
  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
} 

void draw () {
  background(0);

  kinect.update();
  image(kinect.rgbImage(), 0, 0);
  ps.update();
  ps.display();


  if (handFlag == true) {
    ps.setEmitter(pos.x, pos.y);
  } 
  else {
    ps.setEmitter(700, 700);
  }
}



class Particle {

  PVector velocity;
  float lifespan = 255;

  PShape part;
  float partSize;

  PVector gravity = new PVector(0, 0.1);


  Particle() {
    partSize = random(10, 60);
    part = createShape(QUAD);
    part.noStroke();
    part.texture(sprite);
    part.normal(0, 0, 1);
    part.vertex(-partSize/2, -partSize/2, 0, 0);
    part.vertex(+partSize/2, -partSize/2, sprite.width, 0);
    part.vertex(+partSize/2, +partSize/2, sprite.width, sprite.height);
    part.vertex(-partSize/2, +partSize/2, 0, sprite.height);
    //part.end();

    rebirth(700, 700);
    lifespan = random(255);
  }

  PShape getShape() {
    return part;
  }

  void rebirth(float x, float y) {
    float a = random(TWO_PI);
    float speed = random(0.5, 4);
    velocity = new PVector(cos(a), sin(a));
    velocity.mult(speed);
    lifespan = 255;   
    part.resetMatrix();
    part.translate(x, y);
  }

  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } 
    else {
      return false;
    }
  }


  public void update() {
    lifespan = lifespan - 1;
    velocity.add(gravity);

    part.tint(255, lifespan);
    part.translate(velocity.x, velocity.y);
  }
}

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

  void setEmitter(float x, float y) {
    for (Particle p : particles) {
      if (p.isDead()) {
        p.rebirth(x, y);
      }
    }
  }

  void display() {

    shape(particleShape);
  }
}

// -----------------------------------------------------------------
// hand events 5
void onCreateHands(int handId, PVector position, float time) {
  kinect.convertRealWorldToProjective(position, position);
  // handPositions.add(position);
  handFlag = true;
  pos = position;
}

void onUpdateHands(int handId, PVector position, float time) {
  kinect.convertRealWorldToProjective(position, position);
  //handPositions.add(position);
  pos = position;
}
void onDestroyHands(int handId, float time) {
  //handPositions.clear();
  kinect.addGesture("RaiseHand");
  handFlag = false;
}
// -----------------------------------------------------------------
// gesture events 6
void onRecognizeGesture(String strGesture, 
PVector idPosition, 
PVector endPosition)
{
  kinect.startTrackingHands(endPosition);
  kinect.removeGesture("RaiseHand");
}

