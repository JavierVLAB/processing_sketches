package processing.test.chispas;

import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import android.view.MotionEvent; 
import android.view.KeyEvent; 
import android.graphics.Bitmap; 
import java.io.*; 
import java.util.*; 

public class Chispas extends PApplet {

// Particles, by Daniel Shiffman.

ParticleSystem ps;
PImage sprite;  

public void setup() {
 
  //orientation(LANDSCAPE);
  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(1000);

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
 // hint(DISABLE_DEPTH_MASK);
} 

public void draw () {
  background(0);
  ps.update();
  ps.display();
  
  ps.setEmitter(mouseX,mouseY);
  
  fill(255);
  textSize(16);
  //text("Frame rate: " + int(frameRate), 10, 20);
  
}


class Particle {

  PVector velocity;
  float lifespan = 255;
  
  PShape part;
  float partSize;
  
  PVector gravity = new PVector(0,0.1f);


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
    
    rebirth(width/2,height/2);
    lifespan = random(255);
  }

  public PShape getShape() {
    return part;
  }
  
  public void rebirth(float x, float y) {
    float a = random(TWO_PI);
    float speed = random(0.5f,4);
    velocity = new PVector(cos(a), sin(a));
    velocity.mult(speed);
    lifespan = 255;   
    part.resetMatrix();
    part.translate(x, y); 
  }
  
  public boolean isDead() {
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

  public void update() {
    for (Particle p : particles) {
      p.update();
    }
  }

  public void setEmitter(float x, float y) {
    for (Particle p : particles) {
      if (p.isDead()) {
        p.rebirth(x, y);
      }
    }
  }

  public void display() {

    shape(particleShape);
  }
}


  public int sketchWidth() { return 400; }
  public int sketchHeight() { return 400; }
  public String sketchRenderer() { return P2D; }
}
