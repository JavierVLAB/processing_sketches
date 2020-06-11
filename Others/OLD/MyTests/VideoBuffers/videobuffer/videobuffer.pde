import processing.video.*;

VideoBuffer vb;
Movie myMovie;
Capture myCapture;
void setup()
{
  size(800,800, P3D);
  myCapture = new Capture(this, 160, 120);
  vb = new VideoBuffer(30, 160, 120);
  //
}

void captureEvent(Capture myCapture) {
  myCapture.read();
  vb.addFrame( myCapture );
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
  VideoBuffer( int frames, int width, int height )
  {
    buffer = new PImage[frames];
    for(int i = 0; i < frames; i++)
    {
	this.buffer[i] = new PImage(width, height);
    }
    this.inputFrame = frames - 1;
    this.outputFrame = 0;
    this.frameWidth = width;
    this.frameHeight = height;
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
