boolean show = true; 
int N = 10;
int mode = 0;
void setup() {

  size(300, 600);
  stroke(0);
  strokeWeight(1);
  rectMode(CENTER);
}


void draw() {

  if (show) {
    background(255);
    render(40, N);
    show = false;
  }
}

void render(float space, int n) {
  float step = width - 2*space;
  step /= n;
  for (float x = space+step/2; x < width - space; x+=step) {
    for (float y = space+step/2; y < height - space; y+=step) {
      drawing(x, y, step, mode, y*y/200000);
    }
  }
}


void drawing(float x, float y, float L, int m, float ang) {

  switch(m) {
  case 0:
    pushMatrix();
    translate(x, y);
    rotate(random(ang));
    rect(0, 0, L-10, L-10);
    popMatrix();
    break;
  }
}


void keyPressed() {
  show = !show;

  if (key == CODED) {
    if (keyCode == UP) {
      N++;
    }
    if (keyCode == DOWN) {

      N = N > 0 ? N-1 : 0;
    }
    if (keyCode == LEFT) {
      mode++;
    }
    if (keyCode == RIGHT) {

      mode--;
    }
    mode = mode % 7;
    mode = abs(mode);
    println(mode);
  }
}
