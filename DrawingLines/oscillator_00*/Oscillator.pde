class Oscillator {
  float w; /* angular frequency */
  float A;   /* amplitude */
  float ph; /* phase */
  float d; /* damping constant */

  Oscillator() {
    A = 100;
    w = 0.1;
    d = 0.001;
    ph = PI/2;
  }

  Oscillator(float _A, float _w, float _d, float _ph) {
    A = _A;
    w = _w;
    d = _d;
    ph = _ph;
  }

  float position(float t) {
    /* position of the oscillator */
    float pos;

    //pos = A*sin(w*cos(d*t)*t + ph);
    pos = A*sin(w*t + ph)*exp(-d*t);
    return pos;
  }
}