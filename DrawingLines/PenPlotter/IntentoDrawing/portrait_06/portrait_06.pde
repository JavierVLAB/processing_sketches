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
  theBlobDetection.setThreshold(0.1f);
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
   drawBlobsAndEdges(true,true);
  
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
  for (int n=0; n<theBlobDetection.getBlobNb(); n++)

  {
    b=theBlobDetection.getBlob(n);
    if (b!=null)
    {
      // Edges
      if (drawEdges)
      {

        beginShape();
        for (int m=0; m<b.getEdgeNb(); m++)
        {
          eA = b.getEdgeVertexA(m);
          eB = b.getEdgeVertexB(m);
          if (eA !=null && eB !=null)
          curveVertex(
            eA.x*width, eA.y*height);
            
          
        }
        endShape();
      }

      // Blobs
    }
  }
}
