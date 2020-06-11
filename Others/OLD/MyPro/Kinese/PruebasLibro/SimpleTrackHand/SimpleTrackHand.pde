import SimpleOpenNI.*;
SimpleOpenNI kinect;
void setup() {
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
  // turn on user tracking
  kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  kinect.alternativeViewPointDepthToImage();
}
void draw() {
  kinect.update();
  PImage depth = kinect.depthImage();
  PImage imgrgb = kinect.rgbImage();
  image(imgrgb, 0, 0);
  // make a vector of ints to store the list of users
  IntVector userList = new IntVector();
  // write the list of detected users
  // into our vector
  kinect.getUsers(userList);
  // if we found any users
  if (userList.size() > 0) {
    // get the first user
    int userId = userList.get(0);
    // if we’re successfully calibrated
    if ( kinect.isTrackingSkeleton(userId)) {
      // make a vector to store the left hand
      PVector rightHand = new PVector();
      // put the position of the left hand into that vector
      float confidence = kinect.getJointPositionSkeleton(userId, 
      SimpleOpenNI.SKEL_LEFT_HAND, 
      rightHand);
      // convert the detected hand position
      // to "projective" coordinates
      // that will match the depth image
      PVector convertedRightHand = new PVector();
      kinect.convertRealWorldToProjective(rightHand, convertedRightHand);
      // and display it
      fill(255, 0, 0);
      float ellipseSize = map(convertedRightHand.z, 700, 2500, 50, 1);
      ellipse(convertedRightHand.x, convertedRightHand.y, 
      ellipseSize, ellipseSize);
    }
  }
}
// user-tracking callbacks!
void onNewUser(int userId) {
  println("start pose detection");
  kinect.startPoseDetection("Psi", userId);
}

void onEndCalibration(int userId, boolean successful) {
  if (successful) {
    println(" User calibrated !!!");
    kinect.startTrackingSkeleton(userId);
  } 
  else {
    println(" Failed to calibrate user !!!");
    kinect.startPoseDetection("Psi", userId);
  }
}

void onStartPose(String pose, int userId) {
  println("Started pose for user");
  kinect.stopPoseDetection(userId);
  kinect.requestCalibrationSkeleton(userId, true);
}

