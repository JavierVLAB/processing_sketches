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
  imgs.filter(THRESHOLD, 0.1);
  //image(imgs,0,0);
  imgs.loadPixels();
  
  for (int n = 1; n < 250; n += 1) {
    int p = int(random(imgs.pixels.length));
    float x = p % imgs.width;   
    float y = (p-x)/imgs.width;

    float r = brightness(imgs.pixels[p]);
    //println(r);
    if (r < random(255)) {
      //point(x,y);
      points.add(new PVector(x, y));
    } else {
      n--;
    }
  }

  ellipseMode(CENTER);
  stroke(0);
  noFill();
  setTightness(0);
}

boolean allpoints = true;

void setTightness(float v) {
  curveTightness(v);
  cmr_tightness = v;
  cmr_to_bezier = -6/(v-1);
}

void draw() {

  background(255);
  curveTightness(cmr_tightness);

  // Draw the catmull-rom curve.
  stroke(0,100);  

  beginShape();

  for (PVector p : points) {
    //ellipse(p.x, p.y, 5, 5);
    curveVertex(p.x, p.y);
  }

  endShape();
}

// add a new point when we click on the sketch.
void mouseClicked() {
  points.add(new PVector(mouseX, mouseY));
  allpoints = true;
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
