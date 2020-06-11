import processing.video.*;

VideoBuffer vb;
Movie myMovie;
Capture myCapture;
int numPixels;
int[] backgroundPixels;
PImage img;
void setup()
{
  size(800,800, P3D);
  myCapture = new Capture(this, 300, 200);
  vb = new VideoBuffer(30, 300, 200);
  img = createImage(300,200,ARGB);
  numPixels = 300 * 200;
  
  backgroundPixels = new int[numPixels];
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
  
  resta();
  image(img, 250, 400);
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

void resta() {
  if (myCapture.available()) {
    myCapture.read(); // Read a new video frame
    myCapture.loadPixels(); // Make the pixels of video available
    // Difference between the current frame and the stored background
    img.loadPixels();
    int presenceSum = 0;
    for (int i = 0; i < numPixels; i++) { // For each pixel in the video frame...
      // Fetch the current color in that location, and also the color
      // of the background in that spot
      color currColor = myCapture.pixels[i];
      color bkgdColor = backgroundPixels[i];
      // Extract the red, green, and blue components of the current pixel’s color
      int currR = (currColor >> 16) & 0xFF;
      int currG = (currColor >> 8) & 0xFF;
      int currB = currColor & 0xFF;
      // Extract the red, green, and blue components of the background pixel’s color
      int bkgdR = (bkgdColor >> 16) & 0xFF;
      int bkgdG = (bkgdColor >> 8) & 0xFF;
      int bkgdB = bkgdColor & 0xFF;
      // Compute the difference of the red, green, and blue values
      int diffR = abs(currR - bkgdR);
      int diffG = abs(currG - bkgdG);
      int diffB = abs(currB - bkgdB);
      // Add these differences to the running tally
      presenceSum += diffR + diffG + diffB;
      // Render the difference image to the screen
      //pixels[i] = color(diffR, diffG, diffB);
      // The following line does the same thing much faster, but is more technical
      if(int(diffR) > 14 && int(diffR) > 14 && int(diffB) > 14){
        img.pixels[i] = 0xFF000000 | (currR << 16) | (currG << 8) | currB;

      }
      else{
      img.pixels[i] = 0xFF000000 | (0x00 << 16) | (0x00 << 8) | 0x00;}
    }
    //myCapture.updatePixels();
    img.updatePixels(); // Notify that the pixels[] array has changed
    //println(presenceSum); // Print out the total amount of movement
  }
}


void keyPressed() {
  myCapture.loadPixels();
  arraycopy(myCapture.pixels, backgroundPixels);
}
