ArrayList<Particle> particles = new ArrayList<Particle>();

boolean pause = false;

void setup() {
  fullScreen();
  //size(600, 600);
  for (int i = 0; i < 30; i++) {
    particles.add(new Particle());
    background(255);
    smooth();
  }
}

void draw() {
  //background(255);

  if (!pause) {
    for (Particle p : particles) {
      p.run();
      if (p.isDead()) {
        p.init();
      }
    }
  }
}

void keyPressed(){
 if(key == 'p' || key == 'P'){
   pause = !pause; 
 }
}
