
class Particle {
  float x, y;
  float vx, vy;
  int baseRadius = 2;
  int radius = 2;
  int maxRadius = 50;
  int threshold = 150;
  int hue;
  color c;

  Particle() {
    x = random(width);
    y = random(height);
    //println(y);
    hue = int(random(120, 170));
    vx = 0;
    vy = -random(1, 10)/5;
    c = color(hue,200,150, 140);
  }

  void update() {
    float d = dist(x, y, mouseX, mouseY);
    //println(d);
    if (d < threshold) {
      radius = int(baseRadius + (( threshold - d) / threshold) * maxRadius);
      radius = radius > maxRadius ? maxRadius : radius;
    } else {
      radius = 2;
    }
    vx += (random(100) - 50) /100;
    vy -= random(1, 20) / 10000;
    x += vx;
    y += vy;

    if (x < -maxRadius || x > width + maxRadius || y < -maxRadius) {
      x = random(width);
      y = random(height + maxRadius, height*2);
      vx = 0;
      vy = -random(1, 10)/5;
    }
  }

  void render() {
    noStroke();
    fill(c);
    ellipse(x,y,radius,radius);
  }
}

