ArrayList<Cuadros> puntos;
ArrayList<Nave>    naves;
color[] colores = {
 color(255,255,125),
 color(255,255,100),
 color(255,100,255),
 color(100,255,255),
 color(100,100,255),
 color(100,255,100),
 color(255,100,100),
 color(255,125,255),
  color(100,255,160),
 color(255,100,160),
 color(160,125,255)};
 
int n = colores.length; 
 
Nave laNave = new Nave();

void setup() {
  size(600, 600);
  rectMode(CENTER);
  ellipseMode(CENTER);
  frameRate(30);
  //colorMode(HSB);
  
  
  puntos = new ArrayList<Cuadros>(); 
  naves = new ArrayList<Nave>();
  puntos.add(new Cuadros(random(width), 0, random(-4, 4), random(1, 3), 32, int(random(n))));
}

void draw() {
  background(0);
  laNave.display();
  if (keyPressed == true) {
    laNave.disparo();
  }

  explota();
  if (1 > int(random(60)))
    puntos.add(new Cuadros(random(width), 0, random(-4, 4), random(1, 3), 32,int(random(n))));
  //println(puntos.size()-1);
  for (int i = puntos.size()-1; i >= 0; i--) {
    Cuadros p = puntos.get(i);
    p.update();
    p.draw();
    if (p.dead) {
      puntos.remove(i);
    }
  }
}

void explota() {

  for (int i = puntos.size()-1; i >= 0; i--) {
    Cuadros p = puntos.get(i);
    for (int j = laNave.balas.size()-1; j >= 0; j--) {
      Bala b = laNave.balas.get(j);
      if (dist(p.x, p.y, b.x, b.y) <= p.r) {
        p.explota();
        p.dead = true;
        b.dead = true;
      }

      if (b.dead) {
        laNave.balas.remove(j);
      }
    }

    if (p.dead) {
      puntos.remove(i);
    }
  }
}

