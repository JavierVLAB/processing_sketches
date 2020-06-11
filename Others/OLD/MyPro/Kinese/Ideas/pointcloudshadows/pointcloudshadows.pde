import processing.opengl.*;

// Javier Villarroel VisionLab 4D collective
// This sketch was developed using the point cloud example from
// the Openkinect library of Daniel Shiffman 
//
//This sketch has been design for be used in a projection over 
//a pyramid by a monitor with a resolution of 1280 X 1024

import org.openkinect.*;
import org.openkinect.processing.*;

//import ddf.minim.*;
//import ddf.minim.signals.*;
VideoBuffer vb;

//Minim minim;
//AudioOutput out;
//AudioPlayer musica;

// Kinect Library object
Kinect kinect;

float a = 0;

// Size of kinect image
int w = 640;
int h = 480;

int centro = -50;
PGraphics pg;
PImage img;

// We'll use a lookup table so that we don't have to repeat the math over and over
float[] depthLookUp = new float[2048];

void setup() {
  size(800,600,P3D);
  frameRate(30);
  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(true);
  // We don't need the grayscale image in this example
  // so this makes it more efficient
  kinect.processDepthImage(false);

  // Lookup table for all possible depth values (0 - 2047)
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
  
  pg = createGraphics(400,300,P3D);
  vb = new VideoBuffer(41, 400, 300);
  imageMode(CENTER);
  //minim = new Minim(this);
  //musica = minim.loadFile("T_aereo.mp3", 2048);
  //musica.loop(); 
  
}

void draw() {

  background(0);
  
  translate(width/2,height/2);
  tint(255,0,0);
  image(vb.getFrame(0), 0, 0);
  noTint();
  translate(20,20);
  tint(0,255,0);
  image(vb.getFrame(1), 0, 0);
  noTint();
  translate(20,20);
  tint(0,0,255);
  image(vb.getFrame(2), 0, 0);
  noTint();
  translate(20,20);
  tint(255,255,0);
  image(vb.getFrame(3), 0, 0);
  noTint();
  translate(20,20);
  tint(255,255,255);
  image(vb.getFrame(4), 0, 0);
  noTint();
  
  fill(255);
  //textMode(SCREEN);
  //text("Kinect FR: " + (int)kinect.getDepthFPS() + "\nProcessing FR: " + (int)frameRate,10,16);

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();

  // We're just going to calculate and draw every 4th pixel (equivalent of 160x120)
  int skip = 3;

  // Translate and rotate
 
  pg.beginDraw();
  pg.background(0,0,0,0);
  
  pg.translate(pg.width/2,pg.height/2,centro);
  pg.rotateY(a);
  for(int x=0; x<w; x+=skip) {
    for(int y=0; y<h; y+=skip) {
      int offset = x+y*w;

      // Convert kinect data to world xyz coordinate
      int rawDepth = depth[offset];
      PVector v = depthToWorld(x,y,rawDepth);

      pg.stroke(255);
      pg.pushMatrix();
      // Scale up by 200
      float factor = 400;
      if(v.z < 2)
      pg.translate(v.x*factor,v.y*factor,factor-v.z*factor);
      // Draw a point
      pg.point(0,0);
      pg.popMatrix();
    }
  }

  // Rotate
  //a += 0.015f;
  pg.endDraw();
  
  img = (PImage) pg;
  
  int distCentro = height/2 - pg.height/2;
  
  
 
  
  
  
  
  vb.addFrame(pg);
  
}

// These functions come from: http://graphics.stanford.edu/~mdfisher/Kinect.html
float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

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

void keyPressed() {
 


  if (key == 'q') {
    exit();
  }


  if(key == CODED) { 
    // pts
    if (keyCode == UP) { 
      if (centro < 200){
        centro++;
      } 
    } 
    else if (keyCode == DOWN) { 
      if (centro > -200){
        centro--;
      }
    } 
  }
  
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


void stop() {
  //musica.close();
  
  //minim.stop();
  kinect.quit();
  super.stop();
}

