ParticleSystem ps;
int N = 100;
int radio;

void setup() {
  size(640, 360);
  colorMode(RGB, 255, 255, 255, 100);
  ps = new ParticleSystem(1, new PVector(width/2,height/2,0));
  for(int i = 0; i < N; i++){
    ps.addParticle(int(random(width-4*radio)+2*radio),int(random(height-4*radio)+2*radio));
  }
  smooth();
}

void draw() {
  background(255);
  ps.run();
  
}



class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float timer;
  
  // Another constructor (the one we are using here)
  Particle(PVector l) {
    acc = new PVector(0,0,0);
    vel = new PVector(random(-1,1),random(-1,1),0);
    loc = l.get();
    r = 10.0;
    timer = 100.0;
  }

  void run() {
    update();
    render();
  }

  // Method to update location
  void update() {
    vel.add(acc);
    
    if(loc.x < r || loc.x > (width - r)){
      vel.x = -1*vel.x;
    }
    if(loc.y < r || loc.y > (height - r)){
      vel.y = -1*vel.y;
    }
    loc.add(vel);
    
    //timer -= 1.0;
  }

  // Method to displa
  void render() {
    ellipseMode(CENTER);
    stroke(0,100);
    fill(200,100);
    ellipse(loc.x,loc.y,r,r);
    
  }
  
  // Is the particle still useful?
  boolean dead() {
    if (timer <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
  
   

}

// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {

  ArrayList particles;    // An arraylist for all the particles
  PVector origin;        // An origin point for where particles are born

  ParticleSystem(int num, PVector v) {
    particles = new ArrayList();              // Initialize the arraylist
    origin = v.get();                        // Store the origin point
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin));    // Add "num" amount of particles to the arraylist
    }
  }

  void run() {
    // Cycle through the ArrayList backwards b/c we are deleting
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = (Particle) particles.get(i);
      p.run();
      
      
      
      if (p.dead()) {
        particles.remove(i);
      }
    }
    
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = (Particle) particles.get(i);
      for (int j = i; j >= 0; j--) {
        Particle q = (Particle) particles.get(j);
        int dista = int(dist(q.loc.x,q.loc.y,p.loc.x,p.loc.y));
        if(50 > dista){
          stroke(dista);
          line(q.loc.x,q.loc.y,p.loc.x,p.loc.y);
        }
      }
    }
      
    
    
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }
  
    void addParticle(float x, float y) {
    particles.add(new Particle(new PVector(x,y)));
  }

  void addParticle(Particle p) {
    particles.add(p);
  }

  // A method to test if the particle system still has particles
  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }

}

