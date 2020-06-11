class Destello {
  int x, y;
  int r;
  int form;
  boolean dead;
  color c;
  
  Destello(int x_, int y_, color c_){
    x = x_;
    y = y_;
    form = int(random(2,6));
    r = 0;
    dead = false;
    c = c_;
  }
  
  void display(){
    r++;
    noFill();
    stroke(c,255-r);
    poligono(x,y,r,form);
    
    if(r > 255){
      dead = true; 
    }
  }
  
}

