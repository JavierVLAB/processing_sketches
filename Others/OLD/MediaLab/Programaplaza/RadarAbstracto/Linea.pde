class Linea {
  int coord;
  int v;
  color c;
  int dir;
  boolean dead;

  Linea() {
    dir = int(random(2));
    v = int(random(1,5));
    coord = 0;
    c = color(random(255), random(150,250), 255);
    dead = false;
  }

  void display() {
    coord += v;
    stroke(c);
    if(dir == 0){
    line(coord, 0, coord, W);}
    else{
      line(0, coord, W, coord);
    }
    
    if(coord > W){
      dead = true;
    }
    
  }
}

