import blobDetection.*;

BlobDetection theBlobDetection;
PGraphics img;
PImage img2;
float[] hist = new float[100];
float umbral = 0.3;

// ==================================================
// setup()
//  http://www.v3ga.net/processing/BlobDetection/index-page-documentation.html
// ==================================================
void setup()
{
  frameRate(2);
        img = createGraphics(640,480);
        img.beginDraw();
        img.background(255);
        img.noStroke();
        img.fill(0);
        for (int i=0;i<20;i++){
          float r = random(50);
          img.ellipse(random(img.width), random(img.height), r,r);
        }
        img.endDraw();
        
        img2 = loadImage("two.jpg");
        img2.loadPixels();
  
	theBlobDetection = new BlobDetection(img2.width, img2.height);
	theBlobDetection.setPosDiscrimination(false);
	theBlobDetection.setThreshold(umbral);
	theBlobDetection.computeBlobs(img2.pixels);

	// Size of applet
	size(img2.width, img2.height);

        println(theBlobDetection.getBlobNb());
}

// ==================================================
// draw()
// ==================================================
void draw()
{
img2.loadPixels();  
  theBlobDetection.setThreshold(umbral);
	theBlobDetection.computeBlobs(img2.pixels);

  
	image(img2,0,0,width,height);
	drawBlobsAndEdges(true,true);

for(int i=0; i<hist.length;i++)
hist[i] = 0;



Blob bb;
float area;
float puesto;
  for (int n=0 ; n<theBlobDetection.getBlobNb() ; n++)
	{ bb = theBlobDetection.getBlob(n);
          area = bb.w * bb.h * 100;
          //println(area);
          puesto =  map(area,0,4,0,hist.length);
          if(puesto < hist.length)
          hist[(int) puesto]++;

  }
  
  for(int i=1; i<hist.length;i++){
    noStroke();
    fill(0,255,255,200);
    rect(100+i*6, 20, 4, hist[i]*8);
    
  }
    fill(255,0,0,100);
    rect(100 + hist.length*6,20,2,100);

}

// ==================================================
// drawBlobsAndEdges()
// ==================================================
void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges)
{
	noFill();
	Blob b;
	EdgeVertex eA,eB;
	for (int n=0 ; n<theBlobDetection.getBlobNb() ; n++)
	{
		b=theBlobDetection.getBlob(n);
		if (b!=null)
		{
			// Edges
			if (drawEdges)
			{
				strokeWeight(2);
				stroke(0,255,0);
				for (int m=0;m<b.getEdgeNb();m++)
				{
					eA = b.getEdgeVertexA(m);
					eB = b.getEdgeVertexB(m);
					if (eA !=null && eB !=null)
						line(
							eA.x*width, eA.y*height, 
							eB.x*width, eB.y*height
							);
				}
			}

			// Blobs
			if (drawBlobs)
			{
				strokeWeight(1);
				stroke(255,0,0);
				rect(
					b.xMin*width,b.yMin*height,
					b.w*width,b.h*height
					);
			}

		}

      }
}





//void keyPressed() { // Press a key to save the data
//  int flot = theBlobDetection.getBlobNb();
//  String[] lines = new String[flot];
//  for (int i = 0; i < flot; i++) {
//    lines[i] =  theBlobDetection.getBlob(i).w + "\t" +  theBlobDetection.getBlob(i).h + "\t \t" + theBlobDetection.getBlob(i).h*theBlobDetection.getBlob(i).w;
//  }
//  saveStrings("lines.txt", lines);
//  exit(); // Stop the program
//}


void keyPressed(){
 
 if(key == CODED) { 
    // pts
    if (keyCode == UP) { 
      if (umbral < 1){
        umbral += 0.05;
        println(umbral);
      } 
    } 
    else if (keyCode == DOWN) { 
      if (umbral > 0){
        umbral -= 0.05;
        println(umbral);
      }
    } 
  } 
  
}
