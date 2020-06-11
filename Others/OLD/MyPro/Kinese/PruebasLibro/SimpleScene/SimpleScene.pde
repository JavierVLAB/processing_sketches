import processing.opengl.*;
import SimpleOpenNI.*;
SimpleOpenNI kinect;
void setup() {
  size(640, 480, OPENGL);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  // turn on access to the scene
  kinect.enableScene();
}
void draw() {
  background(0);
  kinect.update();
  // draw the scene image
  image(kinect.sceneImage(), 0, 0);

  int[] sceneMap = kinect.sceneMap();
  for (int i =0; i < sceneMap.length; i++) {
    if (sceneMap[i] == 3) {
      // we are tracking at least 3 objects
      // and this pixel belongs to the third object:
      rgbImage[i];
    }
  }
}

