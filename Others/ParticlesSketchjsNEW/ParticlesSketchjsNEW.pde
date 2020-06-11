
int MAX_PARTICLES = 280;
ArrayList<Particle> particulas;
color[] colores = { 
  #69d2e7, #A7DBD8, #E0E4CC, #F38630, #FA6900, #FF4E50, #F9D423
};

void setup() {
  size(1000, 700);
  //println(height);
  colorMode(HSB);
  particulas = new ArrayList<Particle>();
}

void draw() {
  background(255);

  for (int i = particulas.size()-1; i >= 0; i--) {
    Particle p = particulas.get(i);
    if (p.alive) {
      p.move();
      p.display();
    } else {
    }
  }
}


void mouseMoved() {
  int max = int(random(1, 4));
  for (int i = 0; i < max; i++) {
    Particle p = new Particle( mouseX, mouseY, int(random( 5, 40 )) );

    p.wander = random( 0.5, 2.0 );
    p.c = colores[int(random(colores.length))];
    p.drag = random( 0.9, 0.99 );

    float theta = random( TWO_PI );
    float force = random( 2, 8 );

    p.vel.x = sin( theta ) * force;
    p.vel.y = cos( theta ) * force;
    particulas.add(p);
  }
}