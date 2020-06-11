boolean show = true; 
int N = 10;
int mode = 0;
void setup() {

  size(500, 500);
  stroke(0);
  strokeWeight(3);
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
  for (float x = space; x < width - space; x+=step) {
    for (float y = space; y < height - space; y+=step) {
      drawing(x, y, step, mode);
    }
  }
}


void drawing(float x, float y, float L, int m) {

  switch(m) {
  case 0:
    noFill();
    stroke(0);
    if (random(1) < 0.5) {
      line(x, y, x+L, y+L);
    } else {
      line(x+L, y, x, y+L);
    }
    break;
  case 1:
    noFill();
    stroke(0);
    if (random(1) < 0.5) {
      arc(x, y, 2*L, 2*L, 0, PI/2);
    } else {
      arc(x+L, y, 2*L, 2*L, PI/2, PI);
    }
    break;
  case 2:
    noFill();
    stroke(0);
    if (random(1) < 0.5) {
      bezier(x, y, x, y+L/2, x+L, y+L/2, x+L, y+L);
    } else {
      bezier(x+L, y, x+L, y+L/2, x, y+L/2, x, y+L);
    }
    break;

  case 3:
    noStroke();
    fill(0);
    rect(x, y, L, L);
    fill(255);
    if (random(1) < 0.5) {

      arc(x, y, 2*L, 2*L, 0, PI/2);
    } else {
      arc(x+L, y, 2*L, 2*L, PI/2, PI);
    }
    break;

  case 4:
    noStroke();
    fill(0);
    rect(x, y, L, L);
    fill(255);
    if (random(1) < 0.5) {

      ellipse(x+L/2, y+L/2, L, L);
    } else {

      triangle(x+L/2, y, x, y+L, x+L, y+L);
    }
    break;
  case 5:
    noFill();
    stroke(0);
    line(x, y+random(L), x, y+random(L));
    break;
  case 6:
    noFill();
    stroke(0);
    line(x, y+random(L), x+L, y+random(L));
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
