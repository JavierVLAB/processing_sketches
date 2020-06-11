

void blogEstructura() {    
  substraction(myCapture);
  opencv.copy(buffer2);

  opencv.convert(GRAY);
  opencv.contrast(contrast_value);
  opencv.brightness(brightness_value); 
  opencv.blur( OpenCV.BLUR, blurVal );
  opencv.threshold(threshold);
  opencv.ROI(roiX , roiY, roiFinX, roiFinY);

  //image(myCapture,0+350,245+350);
  image(opencv.image(), 0+350, 0+350);
  //image( back, 320+350, 0+350 );  // display the image in memory on the right

   blobs = opencv.blobs( minBlobSize, 1000, 6, true );

  for( int i=0; i<blobs.length; i++ ) {

    Rectangle bounding_rect	= blobs[i].rectangle;
    float area = blobs[i].area;
    float circumference = blobs[i].length;
    Point centroid = blobs[i].centroid;
    Point[] points = blobs[i].points;
    pushMatrix();
    translate(400,400);
    // rectangle
    /*noFill();
    stroke( blobs[i].isHole ? 128 : 64 );
    rect( bounding_rect.x, bounding_rect.y, bounding_rect.width, bounding_rect.height );


    // centroid
    stroke(0,0,255);
    line( centroid.x-5, centroid.y, centroid.x+5, centroid.y );
    line( centroid.x, centroid.y-5, centroid.x, centroid.y+5 );
    noStroke();
    fill(0,0,255);
    text( area,centroid.x+5, centroid.y+5 );*/


    //    fill(255,0,255,64);
    //    stroke(255,0,255);
    //    if ( points.length>0 ) {
    //      beginShape();
    //      for( int j=0; j<points.length; j++ ) {
    //        vertex( points[j].x, points[j].y );
    //      }
    //      endShape(CLOSE);
    //    }

    //noStroke();
    //fill(255,0,255);
    //text( circumference, centroid.x+5, centroid.y+15 );
    
    popMatrix();
  }
}  



// Changes contrast/brigthness values
void mouseDragged() {
  contrast_value   = int(map(mouseX, 0, width, -128, 128));
  brightness_value = int(map(mouseY, 0, width, -128, 128));
  println("C:"+contrast_value+ " B: "+ brightness_value);
}



//background substraction
void substraction(PImage video)
{
  back.loadPixels();
  if(video.width != 0 && video.height != 0)
  {
    if (first)
    {
      saveBackground();
      first=false;
    }
    video.loadPixels(); // Make the pixels of video available
    // Difference between the current frame and the stored background
    int presenceSum = 0;
    for (int i = 0; i < numPixels2; i++) { // For each pixel in the video frame...
      // Fetch the current color in that location, and also the color
      // of the background in that spot
      color currColor = video.pixels[i];
      //color bkgdColor = backgroundPixels[i];
      color bkgdColor = back.pixels[i];
      // Extract the red, green, and blue components of the current pixel�s color
      int currR = (currColor >> 16) & 0xFF;
      int currG = (currColor >> 8) & 0xFF;
      int currB = currColor & 0xFF;
      // Extract the red, green, and blue components of the background pixel�s color
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
      //buffer.pixels[i] = color(diffR, diffG, diffB);
      // The following line does the same thing much faster, but is more technical
      buffer2.pixels[i] = 0xFF000000 | (diffR << 16) | (diffG << 8) | diffB;
    }
  }
}

void saveBackground()
{
  myCapture.loadPixels();
  //arraycopy(movie.pixels, backgroundPixels);
  arraycopy(myCapture.pixels, back.pixels);
  back.updatePixels();
}



