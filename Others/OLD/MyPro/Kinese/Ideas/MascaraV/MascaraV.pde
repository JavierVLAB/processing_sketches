import SimpleOpenNI.*;


SimpleOpenNI context;
float        zoomF =0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);

PGraphics pg;
PImage img;
PImage mascara;
boolean persona = false;

void setup()
{
  size(640,480);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  context = new SimpleOpenNI(this);
   frameRate(30);
  // disable mirror
  context.setMirror(false);

  // enable depthMap generation 
  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  
  
  context.enableRGB();
  
  mascara = loadImage("Guy_Fawkes.png");
  imageMode(CENTER);

 }
 
void draw(){
  context.update();
  
  background(0);
  
  img = context.rgbImage().get();
  image(img,width/2,height/2,img.width,img.height);
  if(persona){
    
    drawSkeleton();
    
  }
  

  
}

void drawSkeleton(){

  
  PVector jointPosPru = new PVector();
  PVector jointPosPru2 = new PVector();
  context.getJointPositionSkeleton(1,SimpleOpenNI.SKEL_HEAD,jointPosPru);
  context.getJointPositionSkeleton(1,SimpleOpenNI.SKEL_NECK,jointPosPru2);
  float abc = dist(jointPosPru2.x,jointPosPru2.y,jointPosPru2.z,jointPosPru.x,jointPosPru.y,jointPosPru.z);
  
  //fill(255);
  
  context.convertRealWorldToProjective(jointPosPru, jointPosPru);
  context.convertRealWorldToProjective(jointPosPru2, jointPosPru2);
  
  ellipse(jointPosPru.x,jointPosPru.y, 30,30);
  
  PVector vect = new PVector(jointPosPru.x - jointPosPru2.x,jointPosPru.y - jointPosPru2.y);
  
  
  pushMatrix();
  //rotate(a);
  translate(jointPosPru.x,jointPosPru.y);
  float largo = dist(jointPosPru2.x,jointPosPru2.y,jointPosPru.x,jointPosPru.y);
  float a = PVector.angleBetween(vect, new PVector(0,-1,0));
  rotate(a);
  image(mascara,0,0,mascara.width*largo*1.2/mascara.height,largo*1.2);
  popMatrix();
  
}

void onNewUser(int userId)
{
  println("onNewUser - userId: " + userId);
  println("  start pose detection");
  
  context.startPoseDetection("Psi",userId);
  persona = true;
}

void onLostUser(int userId)
{
  println("onLostUser - userId: " + userId);
  persona = false;
}

void onStartCalibration(int userId)
{
  println("onStartCalibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successfull)
{
  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);
  
  if (successfull) 
  { 
    println("  User calibrated !!!");
    context.startTrackingSkeleton(userId); 
  } 
  else 
  { 
    println("  Failed to calibrate user !!!");
    println("  Start pose detection");
    context.startPoseDetection("Psi",userId);
  }
}

void onStartPose(String pose,int userId)
{
  println("onStartdPose - userId: " + userId + ", pose: " + pose);
  println(" stop pose detection");
  
  context.stopPoseDetection(userId); 
  context.requestCalibrationSkeleton(userId, true);
 
}

void onEndPose(String pose,int userId)
{
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}

