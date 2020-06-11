//https://generativeartistry.com/


int step = 20;

void setup() {
  size(700, 700);
  init();
}

void init() {
  background(255);
 
  for (int x = 2*step; x < width-2*step; x += step) {
    for (int y = 2*step; y < height-2*step; y += step) {

      if (random(1)>=0.5) {
        line(x, y, x + step, y + step);
      } else {
        line(x+step, y, x, y + step);
      }
    }
  }
}

void draw() {
}



void keyPressed() {

  init();
}
