ArrayList<Linea> lineas;
ArrayList<Destello> people;
int W;
int H = 600;

Linea laLinea = new Linea();

void setup() {
  W = 600;
  //H = 600;
  size(600,600);
  frameRate(25);
  colorMode(HSB);
  lineas = new ArrayList<Linea>();
  
  lineas.add(new Linea());
  people = new ArrayList<Destello>();
}


void draw() {
  background(255);
  //fill(0, 20);
  //rect(0, 0, W, H);

  if (random(100)<=1) {
    lineas.add(new Linea());
  }

  //println(lineas.size()-1);
  for (int i = lineas.size()-1; i >= 0; i--) {
    Linea l = lineas.get(i);
    l.display();
    
    if(l.dir == 0){
     if(mouseX-2 <l.coord && mouseX+2 >l.coord){
       people.add(new Destello(int(mouseX), int(mouseY), l.c));
     } 
    } else {
      if(mouseY-2 <l.coord && mouseY+2 >l.coord){
       people.add(new Destello(int(mouseX), int(mouseY), l.c));
     }
    }
    
    if (l.dead) {
      lineas.remove(i);
    }
  }
  
  for (int i = people.size()-1; i >= 0; i--) {
    Destello p = people.get(i);
    p.display();
    if (p.dead) {
      people.remove(i);
    }
  }
  
}

void poligono(float x, float y, float radius, int npoints) {

  if (npoints == 2) {
    ellipse(x, y, radius, radius);
  } 
  else {
    polygon(x, y, radius, npoints);
  }
}

void polygon(float x, float y, float radius, int npoints) {

  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}