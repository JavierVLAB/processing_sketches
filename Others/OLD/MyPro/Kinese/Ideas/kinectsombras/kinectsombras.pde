
// Kinect Basic Example by Amnon Owed (15/09/12)
// import library
import SimpleOpenNI.*;
// declare SimpleOpenNI object
import hypermedia.video.*;  
import java.awt.Point;    
import processing.video.*;
PGraphics pg;
OpenCV opencv;               
PImage img;
Movie myMovie;
PImage Trans1;
PImage pre;


VideoBuffer vb;
int ww;
int hh;
int scale;
int W, H;
int y0;

SimpleOpenNI context;
// PImage to hold incoming imagery
PImage cam;
void setup() {
  // same as Kinect dimensions
  size(displayWidth, displayHeight);
  ww = 640;
  hh = 480;
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
  }
  

  pg = createGraphics(ww,hh);
  vb = new VideoBuffer(40, ww, hh);
  Trans1 = createImage(160,120,ARGB);
  Trans1.loadPixels();
  for (int i = 0; i < Trans1.pixels.length; i++) {
    Trans1.pixels[i] = color(255,255,255,0); 
  }
  Trans1.updatePixels();
  
  
}
void draw() {
  // update the SimpleOpenNI object
   background(0);
  context.update();
  // put the image into a PImage
  cam = context.sceneImage().get();
  // display the image
  //image(cam, 0, 0);
  cam.blend(Trans1, 0, 0, ww, hh, 0, 0, ww, hh, ADD);
  
  vb.addFrame(cam);
  
  /*tint(255,0,0);
  image(vb.getFrame(0), 0, 0);
  noTint();
  tint(0,255,0);
  image(vb.getFrame(1), 0, 0);
  noTint();
  tint(0,0,255);
  image(vb.getFrame(2), 0, 0);
  noTint();
  tint(255,0,255);
  image(vb.getFrame(3), 0, 0);
  noTint();
  tint(255,255,255);
  image(vb.getFrame(4), 0, 0);
  noTint();*/
  blend(vb.getFrame(3), 0, 0, ww, hh, 0, 0, ww, hh, ADD);
  noTint();
  tint(0,0,255);
  blend(vb.getFrame(2), 0, 0, ww, hh, 0, 0, ww, hh, ADD);
  noTint();
  tint(255,0,0);
  blend(vb.getFrame(1), 0, 0, ww, hh, 0, 0, ww, hh, ADD);
  noTint();
  blend(vb.getFrame(0), 0, 0, ww, hh, 0, 0, ww, hh, ADD);
  
}

class VideoBuffer
{
  PImage[] buffer;
  
  int inputFrame = 0;
  int outputFrame = 0;
  int frameWidth = 0;
  int frameHeight = 0;
  int[] numFra = new int[5];
  
  /*
    parameters:

    frames - the number of frames in the buffer (fps * duration)
    width - the width of the video
    height - the height of the video
  */

VideoBuffer( int frames, int abwidth, int abheight )
  {
    buffer = new PImage[frames];
    for(int i = 0; i < frames; i++)
    {
	this.buffer[i] = new PImage(abwidth, abheight);
    }
    this.inputFrame = frames - 1;
    this.outputFrame = 0;
    this.frameWidth = abwidth;
    this.frameHeight = abheight;
    float abc = (frames / 5);
    
    for(int j = 0; j < 5; j++){
      numFra[j] = int(j*abc+abc-1);
      println(j*abc);
    }
    
  }

  // return the current "playback" frame.  
  PImage getFrame(int fra)
  {
    return this.buffer[this.numFra[fra]];
  } 
  
  // Add a new frame to the buffer.
  void addFrame( PImage blaframe )
  {
    
    //System.arraycopy(frame.pixels, 0, this.buffer[this.inputFrame].pixels, 0, this.frameWidth * this.frameHeight);
    this.buffer[this.inputFrame] = blaframe;
    this.inputFrame++;
    this.outputFrame++;
    for(int j = 0; j < 5; j++){
      numFra[j]++;// = int(j*abc);
      
    }

    // wrap the values..    
    if(this.inputFrame >= this.buffer.length)
    {
	this.inputFrame = 0;
    }
    if(this.outputFrame >= this.buffer.length)
    {
	this.outputFrame = 0;
    }
    
    for(int j = 0; j < 5; j++){
      if(this.numFra[j] >= this.buffer.length)
    {
	this.numFra[j] = 0;
    }
      
    }
  }  
} 

void keyPressed() {
    if ( key==' ' ) opencv.remember();
}
