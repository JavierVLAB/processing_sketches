import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;

import oscP5.*;
import netP5.*;

Robot robot;
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(100, 100);

  try { 
    robot = new Robot();
  } 
  catch (AWTException e) {
    e.printStackTrace();
    print("Try again!");
      exit();
  } 

  oscP5 = new OscP5(this, 5001);
  myRemoteLocation = new NetAddress("127.0.0.1", 5005);
}

void draw() {
}


void oscEvent(OscMessage theOscMessage) {

  String message;
  message = theOscMessage.get(0).stringValue();
  //println(message);

  switch(message) {
  case "PLAY": 
    robot.keyPress(KeyEvent.VK_A);
    robot.keyRelease(KeyEvent.VK_A);
    println("1Space!");
    break;
  case "PAUSE": 
    robot.keyPress(KeyEvent.VK_P);
    robot.keyRelease(KeyEvent.VK_P);
    println("2Space!");
    break;
  case "STOP":        
    robot.keyPress(KeyEvent.VK_S);
    robot.keyRelease(KeyEvent.VK_S);
    println("3Space!");
    break;
  }
}

void keyPressed() {
  //Detect space key presses (to show that it works)    
  if (key == 'G') {
    println("1Space!");
  }

  if (key == 'P') {
    println("2Space!");
  }

  if (key == 'S') {
    println("3Space!");
  }
}