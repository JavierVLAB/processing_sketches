/************************************************
 *
 * KINECT to STL
 * An open source Processing sketch to grab a 
 * 3D image from the Kinect camera into a 
 * 3D-printable STL file.
 *
 * Code based on Daniel Shiffman's kinect p5 library,
 * Marius Watz's ModelBuilder p5 library,
 * Andreas Schlegel's controlP5 library and
 * Jonathan Feinberg's peasyCam library.
 *
 * Data grabbed from the kinect as in Shiffman's 
 * PointCloud example distributed with the library.
 *
 * This code is provided with a GNU GPL 3.0 License,
 * see full details here:
 * http://www.gnu.org/copyleft/gpl.html
 *
 * Ultra-lab Team - 2012
 * http://www.ultra-lab.net
 *
 **********************/


import org.openkinect.*;
import org.openkinect.processing.*;
import unlekker.util.*;
import unlekker.modelbuilder.*;
import controlP5.*;
import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

// GUI objects
ControlP5 controlP5;
boolean viewModel;

// Camera objects
PeasyCam cam;
PGraphics3D pg;
PMatrix3D currCameraMatrix;
int minDepth;

// ModelBuilder object
UGeometry model;

// Resolution: pixels between points
// MIN: 1
// MAX: 10
int SKIP = 4;

/***********************
* Kinect Library objects
*/
Kinect kinect;
int w = 640;  // Size of kinect image
int h = 480;

// We'll use a lookup table so that we don't have 
// to repeat the math over and over
float[] depthLookUp = new float[2048];




/***********************
* void setup()
*
********/

void setup() {
  size(800, 600, P3D);

  // Camera objects setup
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(250);
  cam.setMaximumDistance(1000);
  cam.setSuppressRollRotationMode();
  pg = (PGraphics3D) g;

  // GUI objects setup
  controlP5 = new ControlP5(this);
  controlP5.addSlider("minDepth", 0, 2000, 1000, 30, height-50, width-100, 20);
  controlP5.addToggle("viewModel", false, 30, height-100, 40, 20).setMode(ControlP5.SWITCH);
  controlP5.addBang("build", 100, height-100, 20, 20).setTriggerEvent(Bang.RELEASE);
  controlP5.addBang("STL", 150, height-100, 20, 20).setTriggerEvent(Bang.RELEASE);
  controlP5.addBang("reset", 200, height-100, 20, 20).setTriggerEvent(Bang.RELEASE);  
  controlP5.addSlider("SKIP", 1, 10, 4, 200, 20, 400, 20);
 
  // Kinect setup
  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(true);
  kinect.processDepthImage(false);

  // Lookup table for all possible depth values (0 - 2047)
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
  minDepth = 1000;
}





/***********************
* void draw()
*
********/

void draw() {
  background(120, 120, 125);
  hint(ENABLE_DEPTH_TEST);

  // Two VIEW MODES: 
  // viewModel == true -> shows the STL object
  // viewModel == false -> shows the Kinect point grid
 
  // KINECT 
  if (!viewModel) {
    // Get the raw depth as array of integers
    int[] depth = kinect.getRawDepth();

    int skip = SKIP;

    for (int x=0; x<w; x+=skip) {
      for (int y=0; y<h; y+=skip) {
        int offset = x+y*w;

        // Convert kinect data to world xyz coordinate
        PVector v = new PVector();
        int rawDepth = depth[offset];
        if (rawDepth < minDepth) {
          v = depthToWorld(x, y, rawDepth);
        }
        else {
          v = depthToWorld(x, y, minDepth);
        }

        stroke(255);
        pushMatrix();
        // Scale up by 200
        float factor = 200;
        translate(v.x*factor, v.y*factor, factor-v.z*factor);
        // Draw a point
        point(0, 0);
        popMatrix();
      }
    }
  }
  
  // STL
  else {
    if (model == null) build();
    lights();
    fill(255);
    model.draw(this);
  }

  // GUI
  gui();
}






/**********************************
* void build()
* Creates de 3D model from the 
* kinect's data
********/

void build() {
  cam.reset();
  model = new UGeometry();
  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();
  int maximo = 0;
  int skip = SKIP;
  for (int x=0; x<w-skip; x+=skip) {
    fill(255);
    model.beginShape(QUAD_STRIP);
    for (int y=0; y<h; y+=skip) {
      int offset = x+y*w;
      int offset2 = (x+skip)+y*w;

      // Convert kinect data to world xyz coordinate
      int rawDepth = depth[offset];
      int rawDepth2 = depth[offset2];
      if (rawDepth > maximo) maximo = rawDepth;


      int dx = min(abs(x), abs(x-w));
      int dy = min(abs(y), abs(y-h));
      int dh = 4;
      if (dx < dh*skip) {
        float f = (float)dx / (dh*skip);
        rawDepth = minDepth + floor(f*(float)rawDepth);
        rawDepth2 = minDepth + floor(f*(float)rawDepth2);
      }
      if (dy < dh*skip) {
        float f = (float)dy / (dh*skip);
        rawDepth = minDepth + floor(f*(float)rawDepth);
        rawDepth2 = minDepth + floor(f*(float)rawDepth2);
      }

      rawDepth = min(minDepth, rawDepth);
      rawDepth2 = min(minDepth, rawDepth2);

      PVector v = depthToWorld(x, y, rawDepth);
      PVector v2 = depthToWorld(x+skip, y, rawDepth2);
      float factor = 400.;

      model.vertex(v2.x*factor, v2.y*factor, factor-v2.z*factor);
      model.vertex(v.x*factor, v.y*factor, factor-v.z*factor);
    }
    model.endShape();
  }
}


/**********************************
* void reset()
* Resets the model's data buffer
********/
void reset() {
  model = null;
  viewModel = false;
}


/**********************************
* void STL()
* exports the 3D model to a STL file
********/

void STL() {
  if (model == null) build();
  model.writeSTL(this, "kinect-"+frameCount+".stl");
}





/**********************************
* void gui()
* 2D overlay in the 3D world
********/

void gui() {
  currCameraMatrix = new PMatrix3D(pg.camera);
  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();
  controlP5.draw();
  pg.camera = currCameraMatrix;
}





/**********************************
* void mouseDragged()
* some camera operations
********/

void mouseDragged() {
  boolean overControls = controlP5.window(this).isMouseOver();
  cam.setActive(!overControls);
}






/**********************************
* void rawDepthToMeters() [shiffman]
* These function comes from: 
* http://graphics.stanford.edu/~mdfisher/Kinect.html
********/

float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}






/**********************************
* void depthToWorld() [shiffman]
* These function comes from: 
* http://graphics.stanford.edu/~mdfisher/Kinect.html
********/

PVector depthToWorld(int x, int y, int depthValue) {

  final double fx_d = 1.0 / 5.9421434211923247e+02;
  final double fy_d = 1.0 / 5.9104053696870778e+02;
  final double cx_d = 3.3930780975300314e+02;
  final double cy_d = 2.4273913761751615e+02;

  PVector result = new PVector();
  double depth =  depthLookUp[depthValue];//rawDepthToMeters(depthValue);
  result.x = (float)((x - cx_d) * depth * fx_d);
  result.y = (float)((y - cy_d) * depth * fy_d);
  result.z = (float)(depth);
  return result;
}






/**********************************
* void stop()
* 
********/

void stop() {
  kinect.quit();
  super.stop();
}
