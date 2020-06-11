ArrayList<Puntos> puntos;

int N = 30;

void setup() {
  size(600, 600);
  rectMode(CENTER);
  ellipseMode(CENTER);
  colorMode(HSB);
  puntos = new ArrayList<Puntos>();  
  puntos.add(new Puntos());
}

void draw() {
  background(0);
  if (1 > int(random(30)))
    puntos.add(new Puntos());
  //println(puntos.size()-1);
  for (int i = puntos.size()-1; i >= 0; i--) {
    Puntos p = puntos.get(i);
    p.update();
    p.draw();
    if (p.dead) {
      puntos.remove(i);
    }
  }
}

class Puntos {
  float x;
  float y;
  float vx;
  float vy;
  int r;
  color c;
  int h;
  boolean dead;
  int a;
  int t;

  Puntos() {
    h = int(random(255));
    c = color(h, 255, 255);
    //c = color(255,255,255);
    //r = (int) random(253);
    r = 10;
    a = int(random(4));
          t = int(random(1,5))*2;
    //a = 2;
    if (a == 0) {
      x =  random(width);
      y = 0;
      vx = 0; 
      vy = t;

    }

    if (a == 1) {
      x =  random(width);
      y = height;
      vx = 0; 
      vy = -t;
    }

    if (a == 2) {
      y =  random(height);
      x = 0;
      vx = t; 
      vy = 0;
    }

    if (a == 3) {
      y =  random(height);
      x = width;
      vx = -t; 
      vy = 0;
    }
  }

  void update() {

    if (x < -255 || x > width+255) {
      //vx *= -1;
      dead = true;
    }

    if (y < -255 || y > height+255) {
      //vy *= -1;
      dead = true;
    }
    x += vx;
    y += vy;
  }

  void draw() {
    noStroke();
    //fill(c);
    //ellipse(x, y, 10, 10);
    int m, n, o, p;
    m=t; 
    n=2; 
    o=4; 
    p=10;
    if (a == 0) {


      for (int i = 0; i<255; i++) {
        fill(c, 255-i);
        rect(x, y-i, m, n);
      }
      fill(255, 200);
      rect(x, y, m, n*4);
      fill(c, 100);
      //ellipse(x, y, m*3, n*4);
    }

    if (a == 1) {
      for (int i = 0; i<255; i++) {
        fill(c, 255-i);
        rect(x, y+i, m, n);
      }
    }

    if (a == 2) {
      for (int i = 0; i<255; i++) {
        fill(c, 255-i);
        rect(x-i, y, n, m);
      }
    }

    if (a == 3) {
      for (int i = 0; i<255; i++) {
        fill(c, 255-i);
        rect(x+i, y, n, m);
      }
    }
  }
}

