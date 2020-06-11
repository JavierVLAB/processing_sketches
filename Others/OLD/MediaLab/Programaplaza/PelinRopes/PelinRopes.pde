/*
* 
* Perlin noise based visualization. The R, G and B channels are a little out of synch
* providing a colourful ever-changing display
* 
*/ 


float fTimer = 0;
float fDelta = 0.002;
byte bWidth = 96;
byte bHeight = 78;
PImage pImg = createImage(bWidth, bHeight, RGB);


void setup() {
  size(192, 157); 
  frameRate(250);
  background(0); 
}


void draw () {

   pImg.loadPixels();
  
   for (int y=0; y<bHeight; y++){    
    for (int x=0; x<bWidth;x++){
      
      float fx = x*0.0085;
      float fy = y*0.0085; 
      float dy = fy+fTimer*noise(4+fTimer);
      float dt = noise(8+fTimer)*0.05;
      
      int r = dampen(noise(fx, dy, 0.74+fTimer),     0.025);      
      int g = dampen(noise(fx, dy, 0.74+fTimer-dt),  0.025);
      int b = dampen(noise(fx, dy, 0.74+fTimer-dt*2),0.03);      

      pImg.pixels[y*bWidth+x] = color(r,g,b); 

    }
  }
  
  pImg.updatePixels();
  image(pImg, 0, 0, bWidth*2, bHeight*2);
  
  fTimer += fDelta;
  
}


int dampen (float fNoiseValue, float fLimit) {
  
  float fScaledRange = fNoiseValue*2-1;
  
  if (fScaledRange<-fLimit || fScaledRange>fLimit) 
    return 0;
  
  if (fScaledRange>0){ 
    float a =  255.0-255.0*fScaledRange/fLimit;
    return (int) a;}    
  else {
   float b = 255+255*fScaledRange/fLimit;
   return (int) b;}   

}






