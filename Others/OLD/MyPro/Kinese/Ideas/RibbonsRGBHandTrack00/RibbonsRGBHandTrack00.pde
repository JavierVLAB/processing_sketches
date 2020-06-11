import SimpleOpenNI.*;
SimpleOpenNI kinect;

boolean TESTING = false;
int ribbonAmount = 1;
int ribbonParticleAmount = 20;
float randomness = .2;
RibbonManager ribbonManager;
boolean verRGB = true;

boolean handFlag = false;
PVector pos;
int W, H;
float scale;
int y0;
void setup()
{
  size(displayWidth, displayHeight);
  W = displayWidth;
  scale = 1.0 * displayWidth / 640;
  H = int( 480 * scale);
  y0 = displayHeight - H;
  frameRate(30);
  background(0);
  ribbonManager = new RibbonManager(ribbonAmount, ribbonParticleAmount, randomness, "rothko_01.jpg");    // field, rothko_01-02, absImp_01-03 picasso_01
  ribbonManager.setRadiusMax(12);                 // default = 8
  ribbonManager.setRadiusDivide(10);              // default = 10
  ribbonManager.setGravity(.07);                   // default = .03
  ribbonManager.setFriction(1.1);                  // default = 1.1
  ribbonManager.setMaxDistance(40);               // default = 40
  ribbonManager.setDrag(2.5);                      // default = 2
  ribbonManager.setDragFlare(.015);                 // default = .008
  
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  //enable depthMap generation
  kinect.enableDepth();
  kinect.enableRGB();
  // enable hands + gesture generation 1
  kinect.enableGesture();
  kinect.enableHands();
  kinect.addGesture("RaiseHand"); 
}                    
void draw()
{
  kinect.update();
  background(0);
  if(verRGB){
  image(kinect.rgbImage(), 0, y0, W, H);}
  //fill(0, 255);
  //rect(0, 0, width, height);
  
  if (handFlag == true) {
    ribbonManager.update(int(pos.x*scale), int(pos.y * scale + y0));
  } 
  //else {
    //
  //}

  
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

void keyPressed() {

  if (key == ' ') {
    verRGB = !verRGB;
  }
  
}

boolean sketchFullScreen() {
  return true;
}


