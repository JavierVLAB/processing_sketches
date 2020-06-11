class Pen { 
  PVector pos;
  PVector vel;
  PVector acc;
  PVector force;
  float A;
  float w;
  float t;

  Pen (PVector r) { 
    t = 0;
    pos = r.copy(); 
    //acc = new PVector(0,0);
    vel = new PVector(1, 0);
    set_frecuency(120);
  } 

  void update() { 
    t += 0.01;
    pos.add(vel);


    if (pos.x > 100 && pos.x < 500) {
      set_amplitud(10);
    } else {
      set_amplitud(0);
    }
    pos.add(0, A*cos(w*t));
  }

  void set_amplitud(float a) {
    A = a;
  }
  void set_frecuency(float f) {
    w = f;
  }

  void draw() {
    PVector p = pos.copy();
    update();
    line(p.x, p.y, pos.x, pos.y);
  }
}
