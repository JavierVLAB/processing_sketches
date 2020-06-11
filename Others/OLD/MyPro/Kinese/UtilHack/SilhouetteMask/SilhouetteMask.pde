// Kinect Basic Example by Amnon Owed (15/09/12)

// import library
import SimpleOpenNI.*;
// declare SimpleOpenNI object
SimpleOpenNI context;

// PImage to hold incoming imagery
PImage cam;
PImage img;
PGraphics pg;

void setup() {
  // same as Kinect dimensions
  size(640, 480);
  // initialize SimpleOpenNI object
  context = new SimpleOpenNI(this);
  if (!context.enableScene()) {
    // if context.enableScene() returns false
    // then the Kinect is not working correctly
    // make sure the green light is blinking
    println("Kinect not connected!");
    exit();
  } else {
    // mirror the image to be more intuitive
    context.setMirror(true);
    context.enableRGB();
    context.alternativeViewPointDepthToImage();
  }
  
  img = createImage(640, 480, RGB);
  for(int i = 0; i < img.pixels.length; i++) {
    float a = map(i, 0, img.pixels.length, 255, 0);
    img.pixels[i] = color(255); 
  }
}

void draw() {
  // update the SimpleOpenNI object
  background(255,0,0);
  context.update();
  // put the image into a PImage
  cam = context.sceneImage().get();
  //img = context.rgbImage().get();
  // display the image
  img.mask(cam);
  image(img, 0, 0);
  //println(frameRate);
}
