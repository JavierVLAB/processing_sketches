void initKinect(){
  
  context = new SimpleOpenNI(this);
   
  // disable mirror
  context.setMirror(false);

  // enable depthMap generation 
  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  
  //_____Parte de manos______////
  // enable hands + gesture generation
  //context.enableGesture();
  //context.enableHands();
  
  // add focus gestures  / here i do have some problems on the mac, i only recognize raiseHand ? Maybe cpu performance ?
  //context.addGesture("Wave");
  //context.addGesture("Click");
  //context.addGesture("RaiseHand");
  
  // set how smooth the hand capturing should be
  //context.setSmoothingHands(.5);
  
  
  
}


// -----------------------------------------------------------------
// SimpleOpenNI user events

void onNewUser(int userId)
{
  //println("onNewUser - userId: " + userId);
  //println("  start pose detection");
  
  context.startPoseDetection("Psi",userId);
}

void onLostUser(int userId)
{
  //println("onLostUser - userId: " + userId);
}

void onStartCalibration(int userId)
{
  //println("onStartCalibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successfull)
{
  //println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);
  
  if (successfull) 
  { 
    //println("  User calibrated !!!");
    context.startTrackingSkeleton(userId); 
  } 
  else 
  { 
    //println("  Failed to calibrate user !!!");
    //println("  Start pose detection");
    context.startPoseDetection("Psi",userId);
  }
}

void onStartPose(String pose,int userId)
{
  //println("onStartdPose - userId: " + userId + ", pose: " + pose);
  //println(" stop pose detection");
  
  context.stopPoseDetection(userId); 
  context.requestCalibrationSkeleton(userId, true);
 
}

void onEndPose(String pose,int userId)
{
  //println("onEndPose - userId: " + userId + ", pose: " + pose);
}






void onCreateHands(int handId,PVector pos,float time)
{
  println("onCreateHands - handId: " + handId + ", pos: " + pos + ", time:" + time);
 
  handsTrackFlag = true;
  handVec = pos;
  
  handVecList.clear();
  handVecList.add(pos);
}

void onUpdateHands(int handId,PVector pos,float time)
{
  //println("onUpdateHandsCb - handId: " + handId + ", pos: " + pos + ", time:" + time);
  handVec = pos;
  
  handVecList.add(0,pos);
  if(handVecList.size() >= handVecListSize)
  { // remove the last point 
    handVecList.remove(handVecList.size()-1); 
  }
}

void onDestroyHands(int handId,float time)
{
  println("onDestroyHandsCb - handId: " + handId + ", time:" + time);
  
  handsTrackFlag = false;
  context.addGesture(lastGesture);
}

// -----------------------------------------------------------------
// gesture events

void onRecognizeGesture(String strGesture, PVector idPosition, PVector endPosition)
{
  println("onRecognizeGesture - strGesture: " + strGesture + ", idPosition: " + idPosition + ", endPosition:" + endPosition);
  
  lastGesture = strGesture;
  context.removeGesture(strGesture); 
  context.startTrackingHands(endPosition);
  
}

void onProgressGesture(String strGesture, PVector position,float progress)
{
  //println("onProgressGesture - strGesture: " + strGesture + ", position: " + position + ", progress:" + progress);
}

// -----------------------------------------------------------------
