import SimpleOpenNI.*;


SimpleOpenNI context;
float        zoomF =0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);

PGraphics pg;
PImage img;
boolean persona = false;

void setup()
{
  size(700,500);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  context = new SimpleOpenNI(this);
   
  // disable mirror
  context.setMirror(false);

  // enable depthMap generation 
  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  
  
  context.enableRGB();
  pg = createGraphics(640,480);
 }
 
void draw(){
  context.update();
  
  background(0);
  

 
  
  int[] depthMap = context.depthMap();
  
     image(context.rgbImage(),0,0);
  if(persona){
    //println("llllllll");
    drawSkeleton();
    //image(img,0,0);
  }
  

  
}

void drawSkeleton(){

  //pg.beginDraw();
  //pg.background(0,0,0,0);
  
  PVector jointPosPru = new PVector();
  PVector jointPosPru2 = new PVector();
  context.getJointPositionSkeleton(1,SimpleOpenNI.SKEL_HEAD,jointPosPru);
  context.getJointPositionSkeleton(1,SimpleOpenNI.SKEL_NECK,jointPosPru2);
  float abc = dist(jointPosPru2.x,jointPosPru2.y,jointPosPru2.z,jointPosPru.x,jointPosPru.y,jointPosPru.z);
  
  fill(255);
  //pg.translate(jointPosPru.x,jointPosPru.y,jointPosPru.z);
  //pg.sphere(abc/2);
  
  
  //pg.endDraw();
  
  img = (PImage) pg;
  context.convertRealWorldToProjective(jointPosPru, jointPosPru);
  ellipse(jointPosPru.x,jointPosPru.y, 30,30);
  //println("siiiiii");

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

