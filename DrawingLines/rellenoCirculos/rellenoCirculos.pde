//https://generativeartistry.com/


ArrayList<Circle> circles;

int L = 700;

boolean save = false;

void setup() {
  size(700, 700);
  circles = new ArrayList<Circle>();
  //circles.add(new Circle(random(width), random(height), 1));
  L = 200;
  //stroke(8);
  //frameRate(1);

}

void draw() {
  background(255);
  for (int j = 0; j<5000; j++) {
    newCircle();
  }
  
  stroke(0);
  
  strokeWeight(2);
  //noStroke();
  for (Circle c : circles) {

    ellipse(c.x, c.y, c.r*2, c.r*2);
  }
}


class Circle {
  float r;
  float x;
  float y;
  color c;

  Circle(float x_, float y_, float r_) {
    x = x_;
    y = y_;
    r = r_;

  }
}

boolean newCircle() {
  float x = random(width);
  float y = random(height);

  for (int l = L; l > 2; l--) {
    //ellipse(x,y,l,l);
    if ( borde(x, y, l) && collision(x, y, l) ) {
      Circle newC = new Circle(x, y, l);
      circles.add(newC);
      l = 0;
    }
  }

  return true;
}

boolean collision(float x, float y, float l) {

  for (int i = circles.size()-1; i >= 0; i--) {
    Circle c = circles.get(i);
    float d = dist(x, y, c.x, c.y);
    if (d <  c.r+l) {
      return false;
    }
  }

  return true;
}

boolean borde(float x, float y, float l) {
  int b = 30;
  if (x-l < b || x + l > width-b || y - l < b || y +l > height-b) {
    return false;
  } else {

    return true;
  }
}

void keyPressed() {
  setup();
}
