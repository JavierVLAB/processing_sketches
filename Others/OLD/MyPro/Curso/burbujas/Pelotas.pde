class Pelota {
  float x, y;
  float vx, vy;
  color c;
  int r;
  int trans;

  Pelota(int hue) {
    x = random(width);
    y = random(height);
    c = color(hue, 255, 220);
    vx = random(-2, 2);
    vy = random(-2, 2);
    r = int(random(30, 80));
    trans = 100;
  }

  void move() {
    x += vx;
    y += vy; 

    if (x < 0 || x > width) {
      vx *=-1;
    }
    if (y < 0 || y > height) {
      vy *=-1;
    }
  }

  void draw() {
    float dis = dist(x,y,width/2,height/2);
    int top = 250;    
    int botton = top - 100;
    if (dis > top){
      trans = 0;      
    } 
    if (dis < top && dis > botton) {
      trans = 100 - int(dis - botton); 
    }
    if (dis < botton) {
     trans = 100; 
    }
    
    noStroke();
    fill(c,trans);
    ellipse(x, y, r, r);
  }
}

