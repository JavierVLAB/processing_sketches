import SimpleOpenNI.*;

SimpleOpenNI kinect;

boolean handFlag = false;
PImage rgb;
PImage rgb2;
PImage circulo;

PVector  pos;

void setup() {
  size(640, 480);

  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  //enable depthMap generation
  kinect.enableDepth();
  kinect.enableRGB();
  // enable hands + gesture generation 1
  kinect.enableGesture();
  kinect.enableHands();
  kinect.addGesture("RaiseHand");
  PGraphics cir;
  
  cir = createGraphics(50,50);
  cir.beginDraw();
  cir.background(0);
  cir.fill(255);
  cir.ellipse(25,25,10,10);
  cir.endDraw(); 
 
  circulo = (PImage) cir; 
}

void draw() {
  background(255);
  kinect.update();
  
  
  

  
  if (handFlag == true) {
      //rgb = kinect.rgbImage().get();
  
  //rgb2.copy(rgb,(int) pos.x, (int) pos.y, (int) pos.x+50, (int) pos.y+50, 0, 0, 50,50);
  
  //rgb2.mask(circulo);
  //image(rgb2,pos.x,pos.y);
    ellipse(pos.x, pos.y, 30, 30);
    if(pos.x > 100 && pos.y < 200 && pos.y > 100 && pos.y < 200){
      fill(255,0,0);
      rect(100,100,100,100);
    }
  }
}

// -----------------------------------------------------------------
// hand events 5
void onCreateHands(int handId, PVector position, float time) {
  kinect.convertRealWorldToProjective(position, position);
  // handPositions.add(position);
  handFlag = true;
  pos = position;
}

void onUpdateHands(int handId, PVector position, float time) {
  kinect.convertRealWorldToProjective(position, position);
  //handPositions.add(position);
  pos = position;
}
void onDestroyHands(int handId, float time) {
  //handPositions.clear();
  kinect.addGesture("RaiseHand");
  handFlag = false;
}
// -----------------------------------------------------------------
// gesture events 6
void onRecognizeGesture(String strGesture, 
PVector idPosition, 
PVector endPosition)
{
  kinect.startTrackingHands(endPosition);
  kinect.removeGesture("RaiseHand");
}

