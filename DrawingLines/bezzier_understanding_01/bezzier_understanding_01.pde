ArrayList<PVector> points;
PGraphics pg;
float time = 0.0;
int n = 0;

void setup() {
  size(700, 700);
  pg = createGraphics(700,700);
  
  pg.beginDraw();
  pg.smooth();
  pg.background(0);
  pg.endDraw();
  
    init();
}

void init() {

  points = new ArrayList<PVector>();

  for (int i = 0; i < 10; i++) {
    //points.add(new PVector(random(pg.width*1.5), random(pg.height*1.5)));
    float ang = random(360);
    float xc = pg.width/2 + 400*sin(ang);
    float yc = pg.height/2 + 400*cos(ang);
    points.add(new PVector(xc,yc));
  }
}

void draw() {
  //background(255);

  pg.beginDraw();
  pg.strokeWeight(1);
  //pg.translate(-pg.width*0.325,-pg.height*0.325);
  pg.stroke(255, 2);
  //pg.fill(0, 20);
  time = time < 1.0 ? time + 0.0010 : 0;

  PVector B = new PVector(0, 0);

  getDrawPoint(points);
  pg.endDraw();
  image(pg,0,0,width,height);//,width,height);
}

void keyPressed() {
  if (key == ' ') {
    init();
    //background(0);
    //points.add(new PVector(mouseX, mouseY));
    n = points.size() - 1;
    time = 0;
  }
  if (key=='s') {
    pg.endDraw();
    pg.save("test.jpg");
    exit();
  }
}

float binomial(int i, int n, float x) {

  if (n == 0)
    return 1.0;

  if (i == 0)
    return (1 + x) * binomial (i, n-1, x);
  if (i > 0 && i < n)
    return (1 + x) * binomial (i, n-1, x) + x * binomial (i-1, n-1, x);
  if (i == n)
    return x * binomial (i-1, n-1, x);

  return 0.0;
}

void drawBetweenPoints(PVector p1, PVector p2) {

  //ellipse(p1.x, p1.y, 6, 6);
  //ellipse(p2.x, p2.y, 6, 6);
  pg.line(p1.x, p1.y, p2.x, p2.y);
}

ArrayList<PVector> getDrawPoint(ArrayList<PVector> ps) {

  ArrayList<PVector> fs = new ArrayList<PVector>();
  int psize = ps.size();
  if ( psize > 1) {
    for (int i = 0; i < psize - 1; i++) {
      PVector f = new PVector(0, 0);
      PVector p1 = ps.get(i);
      PVector p2 = ps.get(i+1);
      if (psize < n) {
        drawBetweenPoints(p1, p2);
      }
      f.x = p1.x + time * (p2.x - p1.x);
      f.y = p1.y + time * (p2.y - p1.y);
      fs.add(f);
    }
    return getDrawPoint(fs);
  } else {
    if (ps.size() == 1) {
      //fill(255,0,0,255);
      //ellipse(ps.get(0).x, ps.get(0).y, 1, 1);
    }
    return fs;
  }
}
