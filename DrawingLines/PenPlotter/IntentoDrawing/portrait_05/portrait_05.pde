import blobDetection.*;

BlobDetection theBlobDetection;
PImage imgs;


ArrayList<PVector> points = new ArrayList<PVector>();
boolean allpoints = false;
// curve tightness
float cmr_tightness;

// cmr-tightness to bezier-control-offset factor
float cmr_to_bezier;

void setup() {
  size(400, 600);
  noLoop();
  imgs= loadImage("portrait-faces-and-photography-german-woman-tanny.jpg");
  imgs.resize(400, 600);
  //imgs.filter(THRESHOLD, 0.2);
  //image(imgs,0,0);
  theBlobDetection = new BlobDetection(imgs.width, imgs.height);
  theBlobDetection.setPosDiscrimination(false);
  theBlobDetection.setThreshold(0.4f);
  theBlobDetection.computeBlobs(imgs.pixels);

  drawBlobsAndEdges(true, true);

  for (int i = points.size()-1; i >= 0; i--) { 
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out

    if (0.04 < random(1)) points.remove(i);
  }

  ellipseMode(CENTER);
  stroke(0);
  noFill();
  setTightness(0);
  allpoints = points.size()>=4;
}



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


void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges)
{
  noFill();
  Blob b;
  EdgeVertex eA, eB;
  //for (int n=0; n<theBlobDetection.getBlobNb(); n++)
  int n = 5;
  {
    b=theBlobDetection.getBlob(n);
    if (b!=null)
    {
      // Edges
      if (drawEdges)
      {
        strokeWeight(2);
        stroke(0, 255, 0);
        for (int m=0; m<b.getEdgeNb(); m++)
        {
          eA = b.getEdgeVertexA(m);
          eB = b.getEdgeVertexB(m);
          if (eA !=null && eB !=null)
          line(
            eA.x*width, eA.y*height, 
            eB.x*width, eB.y*height
            );
          points.add(new PVector(eA.x*width, eA.y*height));
        }
      }

      // Blobs
    }
  }
}
