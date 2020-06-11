PImage imgs;
float[] cs = {0.0, 0.0, 0.0, 0.0}; 
int imgChange = 1;

ArrayList<PVector> points = new ArrayList<PVector>();

// curve tightness
float cmr_tightness;

// cmr-tightness to bezier-control-offset factor
float cmr_to_bezier;

void setup() {
  size(400, 600);
  noLoop();
  imgs= loadImage("portrait-faces-and-photography-german-woman-tanny.jpg");
  imgs.resize(400, 600);
  imgs.filter(THRESHOLD, 0.2);
  //image(imgs,0,0);
  imgs.loadPixels();
  boolean par = true;
  for (int y = 0; y < imgs.height; y += random(8, 16)) {
    //int p = int(random(imgs.pixels.length));

    if (par) {
      for (int x = 0; x < imgs.width; x += random(8, 18)) {
        float r = brightness(imgs.pixels[x + y * imgs.width]);
        if (r < random(255)) {
          points.add(new PVector(x, y));
        }
      }
    } else {
      for (int x = imgs.width-1; x >= 0; x -= random(4, 8)) {
        float r = brightness(imgs.pixels[x + y * imgs.width]);
        if (r < random(255)) {
          points.add(new PVector(x, y));
        }
      }
    }
  }
  ellipseMode(CENTER);
  stroke(0);
  noFill();
  setTightness(0);
}

boolean allpoints = false;

void setTightness(float v) {
  curveTightness(v);
  cmr_tightness = v;
  cmr_to_bezier = -6/(v-1);
}

void draw() {
  background(255);
  curveTightness(cmr_tightness);

  // Draw the catmull-rom curve.
  stroke(0);  
  if (allpoints) { 
    beginShape();
  }
  for (PVector p : points) {
    //ellipse(p.x, p.y, 5, 5);
    if (allpoints) curveVertex(p.x, p.y);
  }
  if (allpoints) { 
    endShape();
  }

  // Then draw its bezier approximation.
  if (allpoints) {
    stroke(255, 0, 0, 50);

    beginShape();
    vertex(points.get(1).x, points.get(1).y);
    for (int i=1, last=points.size()-2; i<last; i++) {
      PVector pT = points.get(i-1);
      PVector p1 = points.get(i);
      PVector p2 = points.get(i+1);
      PVector p3 = points.get(i+2);

      // Every catmull rom point has a tangent
      // equal to dx(p-1,p+1)/dy(p-1,p+1), with
      // the curve tightness determining the
      // strength of the control point, i.e. how
      // far from the on-curve point it lies.

      float dx1 = (p2.x - pT.x)/cmr_to_bezier;
      float dy1 = (p2.y - pT.y)/cmr_to_bezier;

      float dx2 = (p3.x - p1.x)/cmr_to_bezier;
      float dy2 = (p3.y - p1.y)/cmr_to_bezier;

      bezierVertex(p1.x+dx1, p1.y+dy1, p2.x-dx2, p2.y-dy2, p2.x, p2.y);
    }
    endShape();
  }
}

// add a new point when we click on the sketch.
void mouseClicked() {
  points.add(new PVector(mouseX, mouseY));
  allpoints = points.size()>=4;
  redraw();
}

// let's see what happens when we change the tightness values
void keyPressed() {
  if (key=='w') { 
    setTightness(cmr_tightness+0.05);
  }
  if (key=='s') { 
    setTightness(cmr_tightness-0.05);
  }
  redraw();
}
