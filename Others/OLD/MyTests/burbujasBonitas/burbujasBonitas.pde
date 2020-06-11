int particleCount = 1400;
Particle[] particulas;

void setup() {
  size(1000, 800);
  //println(height);
  colorMode(HSB);
  particulas = new Particle[particleCount];
  for (int i = 0; i < particleCount; i++) {
    particulas[i] = new Particle();
  }
}

void draw() {
  background(0);
  for (int i = 0; i < particleCount; i++) {
    particulas[i].update();
    particulas[i].render();
  }
}

