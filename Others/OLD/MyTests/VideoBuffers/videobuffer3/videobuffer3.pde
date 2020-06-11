import processing.video.*;

import hypermedia.video.*;
import java.awt.*;
import codeanticode.gsvideo.*;

VideoBuffer vb;
Movie myMovie;
Capture myCapture;
int numPixels2;

PImage imgp;
PGraphics elpg;
OpenCV opencv;
PImage buffer; 
PImage buffer2; //buffer for background substraction
PImage back;
Blob[] blobs = {}; 
boolean first = true;
   PImage fondo;

int contrast_value    = -49;
int brightness_value  = -8;
int threshold = 80;
int blurVal = 10;
int feedW = 300;  //size of cam's image width
int feedH = 200;  //size of cam's image height
int roiX=0 , roiY=20, roiFinX=feedW - roiX, roiFinY=feedH-roiY;
int numPixels;
int minBlobSize = 29;
int[] backgroundPixels;


PImage imgb;
boolean newFrame=false;


void setup()
{
  size(800,800, P3D);
  myCapture = new Capture(this, 300, 200);
  vb = new VideoBuffer(30, 300, 200);
  imgp = createImage(300,200,ARGB);
  numPixels2 = 300 * 200;
  
  backgroundPixels = new int[numPixels];

opencv = new OpenCV(this);
  opencv.allocate(feedW, feedH);
  buffer2 = (PImage)createImage(feedW, feedH, RGB);
  back = (PImage)createImage(feedW, feedH, RGB);
  numPixels = feedW * feedH;
  
  elpg = createGraphics(300,200,P2D);
  //
}

void captureEvent(Capture myCapture) {
  myCapture.read();
  vb.addFrame( myCapture );
  newFrame = true;
}

void movieEvent(Movie m)
{
  m.read();
  vb.addFrame( m );
  
  
}

void draw()
{
  image( vb.getFrame(), 100, 100 );
  image( myCapture, 300, 0 );

  //resta();
  image(elpg, 250, 400);
     
    //pts = blobs.length;
  
    fondo = (PImage) createImage(feedW,feedH,ARGB);
  
   blogEstructura();
  arraycopy(myCapture.pixels, fondo.pixels);
  fondo.updatePixels();
  fondo.resize(195,125);
  
}  

  
class VideoBuffer
{
  PImage[] buffer;
  
  int inputFrame = 0;
  int outputFrame = 0;
  int frameWidth = 0;
  int frameHeight = 0;
  
  /*
    parameters:

    frames - the number of frames in the buffer (fps * duration)
    width - the width of the video
    height - the height of the video
  */
  VideoBuffer( int frames, int widthbuf, int heightbuf )
  {
    buffer = new PImage[frames];
    for(int i = 0; i < frames; i++)
    {
	this.buffer[i] = new PImage(widthbuf, heightbuf);
    }
    this.inputFrame = frames - 1;
    this.outputFrame = 0;
    this.frameWidth = widthbuf;
    this.frameHeight = heightbuf;
  }

  // return the current "playback" frame.  
  PImage getFrame()
  {
    return this.buffer[this.outputFrame];
  } 
  
  // Add a new frame to the buffer.
  void addFrame( PImage frame )
  {
    // copy the new frame into the buffer.
    System.arraycopy(frame.pixels, 0, this.buffer[this.inputFrame].pixels, 0, this.frameWidth * this.frameHeight);
    
    // advance the input and output indexes
    this.inputFrame++;
    this.outputFrame++;

    // wrap the values..    
    if(this.inputFrame >= this.buffer.length)
    {
	this.inputFrame = 0;
    }
    if(this.outputFrame >= this.buffer.length)
    {
	this.outputFrame = 0;
    }
  }  
} 



void keyPressed() {
  myCapture.loadPixels();
  arraycopy(myCapture.pixels, backgroundPixels);
}

public void stop() {
  opencv.stop();
  super.stop();
}
