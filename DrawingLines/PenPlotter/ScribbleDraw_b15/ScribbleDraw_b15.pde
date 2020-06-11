/**
 
 ScribbleDraw v. 0.1
 
 A program to create highly non-optimal TSP-type paths that resemble photographs,
 for efficient plotting via pen plotter.
 
 Copyright (C) 2017 by Windell H. Oskay, www.evilmadscientist.com
 
 - Based in part on StippleGen.
 - Inspired by: http://www.thevelop.nl/blog/2016-12-25/ThreadTone/
 - Inspired by: https://github.com/rspt/processing-mycelium.git
 
 
 
 *******************************************************************************
 
 Requires ControlP5 library:
 http://www.sojamo.de/libraries/controlP5/
 
 You can install this library by selecting Sketch > Import Library... > Add Library
 and searching for ControlP5.
 
 */


/*  
 * 
 * This is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * http://creativecommons.org/licenses/LGPL/2.1/
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */


// You need the controlP5 library from http://www.sojamo.de/libraries/controlP5/
import controlP5.*;    


import processing.pdf.*;

import javax.swing.UIManager; 
import javax.swing.JFileChooser; 


public class IntPVector
{
  // Adapted from PVector in the Processing core.
  // A limited subset-- providing variable access but
  // no additional manipulation functions.

  /** The x component of the vector. */
  public int x; 

  /** The y component of the vector. */
  public int y; 

  /**
   * Constructor for an empty vector: x and y are set to 0. 
   */
  public IntPVector() {
  } 


  /**
   * Constructor for a 2D vector. 
   * 
   * @param  x the x coordinate. 
   * @param  y the y coordinate. 
   */
  public IntPVector(int x, int y) { 
    this.x = x; 
    this.y = y;
  } 

  /**
   * Set x and  coordinates. 
   * 
   * @param x the x coordinate. 
   * @param y the y coordinate. 
   */
  public void set(int x, int y) { 
    this.x = x; 
    this.y = y;
  } 

  /**
   * Set the x, y coordinates using an int[] array as the source. 
   * @param source array to copy from 
   */
  public void set(int[] source) { 
    x = source[0]; 
    y = source[1];
  } 

  /**
   * Get a copy of this vector. 
   */
  public IntPVector get() { 
    return new IntPVector(x, y);
  } 


  public int[] get(int[] target) { 
    if (target == null) { 
      return new int[] { x, y };
    } 
    target[0] = x; 
    target[1] = y;     
    return target;
  }
}




// Feel free to play with these default settings:

int maxendpoints = 72;   // Number of directions to check around each tour position
// Values up to (say) 360 give slightly improved search resolution.

float penWidthForCircles = 0.5; // pen width, for purposes of drawing filled circles

float segmentLength = 25.0; //2;
float BlurFactor = 4.0;
float OpacityFactor = 30;

// Display window and GUI area sizes:
int mainwidth; 
int mainheight;
int borderWidth;
int ctrlheight;
int TextColumnStart;

float lowBorderX;
float hiBorderX;
float lowBorderY;
float hiBorderY;

boolean ReInitiallizeArray; 
boolean pausemode;
boolean fileLoaded;
int SaveNow;
String savePath;
String[] FileOutput; 

float FOMbestLast;

String StatusDisplay = "Initializing, please wait. :)";
float millisLastFrame = 0;
float frameTime = 0;

String ErrorDisplay = "";
float ErrorTime;
Boolean ErrorDisp = false;

IntPVector LastPoint;
int Generation; 
int failcount;


boolean showBG;
int curveLines;
boolean showEngine; 
boolean invertImg;


// ControlP5 GUI library variables setup
Textlabel  ProgName; 
Button  CurveControl, ImgOnOff, InvertOnOff;
Button PauseButton, RenderOnOff, LoadButton;
ControlP5 cp5; 

PImage img, imgload, imgblur; 
PGraphics offScreenCanvas;

IntPVector[] endpoints; // (x,y) location of each point

IntPVector[] tour; // (x,y) location of each point


int[] fromPoints; //starting point of each line segment
int[] toPoints; //ending point of each line segment

int[] particleRoute;


int[] lineValues; // Store position values along line (x)

int counter = 1;
int largo = 100;

void LoadImageAndScale() {

  int tempx = 0;
  int tempy = 0;

  img = createImage(mainwidth, mainheight, RGB);
  imgblur = createImage(mainwidth, mainheight, RGB);
  offScreenCanvas = createGraphics(mainwidth, mainheight);


  img.loadPixels();

  if (invertImg)
    for (int i = 0; i < img.pixels.length; i++) {
      img.pixels[i] = color(0);
    } else
    for (int i = 0; i < img.pixels.length; i++) {
      img.pixels[i] = color(255);
    }

  img.updatePixels();

  if ( fileLoaded == false) {
    // Load a demo image, at least until we have a "real" image to work with.
    // Image source, for all included images:  http://commons.wikimedia.org/


    String loadPath;

    if (floor(random(6)) == 0)
    {
      loadPath = "Carson.jpg"; // Load demo image
    } else if (floor(random(5)) == 0)
    { 
      loadPath = "grace.jpg"; // Load demo image
    } else if (floor(random(4)) == 0)
    { 
      loadPath = "cat-gray.jpg"; // Load demo image
    } else if (floor(random(3)) == 0)
    { 
      loadPath = "Woolf.jpg"; // Load demo image
    } else if (floor(random(2)) == 0)
    { 
      loadPath = "Aldrin.jpg"; // Load demo image
    } else
    {
      loadPath = "Twain.jpg"; // Load demo image
    }
    imgload = loadImage(loadPath); // Load demo image
  }

  if ((imgload.width > mainwidth) || (imgload.height > mainheight)) {

    if (((float) imgload.width / (float)imgload.height) > ((float) mainwidth / (float) mainheight))
    { 
      imgload.resize(mainwidth, 0);
    } else
    { 
      imgload.resize(0, mainheight);
    }
  } 

  if  (imgload.height < (mainheight - 2) ) { 
    tempy = (int) (( mainheight - imgload.height ) / 2) ;
  }
  if (imgload.width < (mainwidth - 2)) {
    tempx = (int) (( mainwidth - imgload.width ) / 2) ;
  }

  img.copy(imgload, 0, 0, imgload.width, imgload.height, tempx, tempy, imgload.width, imgload.height);
  // For background image!

  // Optional gamma correction for background image.  
  img.loadPixels();

  float tempFloat;  
  float GammaValue = 0.5;  // Normally in the range 0.25 - 4.0

  for (int i = 0; i < img.pixels.length; i++) {
    tempFloat = brightness(img.pixels[i])/255;  
    img.pixels[i] = color(floor(255 * pow(tempFloat, GammaValue)));
  } 
  img.updatePixels();




  imgblur.copy(img, 0, 0, img.width, img.height, 0, 0, img.width, img.height);
  // This is a duplicate of the background image, that we will apply a blur to,
  // to reduce "high frequency" noise artifacts.

  imgblur.filter(BLUR, 1);  // Low-level blur filter to elminate pixel-to-pixel noise artifacts.
  imgblur.loadPixels();



  // Initialize the offScreenCanvas
  offScreenCanvas.beginDraw();
  offScreenCanvas.image(imgblur, 0, 0);
  offScreenCanvas.endDraw();
}



void MainArraysetup() { 
  // Main particle array initialization (to be called whenever necessary):

  LoadImageAndScale();

  endpoints = new IntPVector[maxendpoints];

  tour = new IntPVector[1]; // Begin with length-1 array.

  fromPoints = new int[0];  // Begin with empty array.
  toPoints = new int[0];  // Begin with empty array.

  // Pick initial starting point: Find darkest spot in a random scatter.

  float bestBright = 1.0;
  float bestX = 0.0;
  float bestY = 0.0;

  int  i = 0;
  while (i < 1000) // Find the darkest of 1000 sampled points
  {
    float fx = lowBorderX +  random(hiBorderX - lowBorderX);
    float fy = lowBorderY +  random(hiBorderY - lowBorderY);
    float p = brightness(imgblur.pixels[ floor(fy)*imgblur.width + floor(fx) ])/255; 

    if (invertImg)
      p =  1 - p;

    if (p < bestBright)
    {
      bestBright = p;
      bestX = fx;
      bestY = fy;
    }
    i++;
  }

  IntPVector firstPoint = new IntPVector(round(bestX), round(bestY));

  tour[0] = firstPoint; 
  LastPoint  = firstPoint;


  generateEndpoints(segmentLength);

  failcount = 0;
  Generation = 0; 
  millisLastFrame = millis();
  FOMbestLast = 1000000;
} 

void generateEndpoints(float radius)
{
  //Arrange points in circle:

  //float radius = segmentLength;
  int i;
  float angle = 0;
  float spacing = TWO_PI / (maxendpoints + 1);


  i = 0;
  while (angle < TWO_PI)
  {
    IntPVector p1 = new IntPVector(round(radius * cos(angle)), 
      round(radius * sin(angle)));

    if (i < maxendpoints)
    {
      endpoints[i] = p1;  
      i++;
    }
    angle += spacing;
  }
}


void setup()
{


  borderWidth = 6;

  mainwidth = 800;
  mainheight = 600;
  ctrlheight = 110;

  //  size(mainwidth, mainheight + ctrlheight, JAVA2D);
  // xWidth: 800
  // yWidth: 600 + 110 = 710


  size(800, 710);


  lowBorderX =  borderWidth; //mainwidth*0.01; 
  hiBorderX = mainwidth - borderWidth; //mainwidth*0.98;
  lowBorderY = borderWidth; // mainheight*0.01;
  hiBorderY = mainheight - borderWidth;  //mainheight*0.98;

  MainArraysetup();   // Main particle array setup

  frameRate(24);
  
  smooth();
  noStroke();
  fill(153); // Background fill color, for control section
  background(255);
  textFont(createFont("SansSerif", 10));


  cp5 = new ControlP5(this);

  int leftcolumwidth = 225;

  int GUItop = mainheight + 15;
  int GUI2ndRow = 4;   // Spacing for firt row after group heading
  int GuiRowSpacing = 14;  // Spacing for subsequent rows
  int GUIFudge = mainheight + 19;  // I wish that we didn't need ONE MORE of these stupid spacings.
  int loadButtonHeight;

  ControlGroup l3 = cp5.addGroup("Primary controls (Changing will restart)", 10, GUItop, 225);

  cp5.addSlider("Segment_Length", 3, 300, 2, 10, GUI2ndRow, 140, 10).setGroup(l3); 
  cp5.getController("Segment_Length").setValue(segmentLength);
  cp5.getController("Segment_Length").setCaptionLabel("Segment Length");
  cp5.getController("Segment_Length").setDecimalPrecision(1);

  cp5.addSlider("Opacity_Factor", 0, 100, 5, 10, GUI2ndRow + GuiRowSpacing, 140, 10).setGroup(l3);  
  cp5.getController("Opacity_Factor").setValue(OpacityFactor); 
  cp5.getController("Opacity_Factor").setCaptionLabel("Opacity Factor");
  cp5.getController("Opacity_Factor").setDecimalPrecision(0);

  cp5.addSlider("Spacing_factor", .5, 10, 0, 10, GUI2ndRow + 2*GuiRowSpacing, 140, 10).setGroup(l3); 
  cp5.getController("Spacing_factor").setValue(BlurFactor);
  cp5.getController("Spacing_factor").setCaptionLabel("Spacing Factor");
  cp5.getController("Spacing_factor").setDecimalPrecision(1);

  InvertOnOff = cp5.addButton("INVERT_IMG");
  InvertOnOff.setValue(10);
  InvertOnOff.setPosition( 10, GUI2ndRow + 3*GuiRowSpacing);
  InvertOnOff.setSize(190, 10);
  InvertOnOff.setGroup(l3); 
  InvertOnOff.setCaptionLabel("Black Lines, White Background");


  loadButtonHeight = GUIFudge + int(round(4*GuiRowSpacing));

  LoadButton = cp5.addButton("LOAD_FILE");
  LoadButton.setPosition( 10, loadButtonHeight);
  LoadButton.setSize(175, 10);
  LoadButton.setCaptionLabel("LOAD IMAGE FILE (.PNG, .JPG, or .GIF)");


  cp5.addButton("QUIT")
    .setPosition(205, loadButtonHeight)
    .setSize(30, 10); 

  cp5.addButton("SAVE_FILE")
    .setPosition( 25, loadButtonHeight + GuiRowSpacing)
    .setSize(160, 10);

  cp5.getController("SAVE_FILE").setCaptionLabel("Save File (.PDF format)");

  ControlGroup l5 = cp5.addGroup("Display Options - Updated on next segment", leftcolumwidth+50, GUItop, 225);

  //CurveControl = cp5.addButton("CHANGE_CURVATURE", 10, 10, GUI2ndRow, 190, 10);

  CurveControl = cp5.addButton("CHANGE_CURVATURE");
  CurveControl.setValue(10);
  CurveControl.setPosition( 10, GUI2ndRow);
  CurveControl.setSize(190, 10);
  CurveControl.setGroup(l5);
  CurveControl.setCaptionLabel("Paths: Straight Lines");

  //ImgOnOff = cp5.addButton("IMG_ON_OFF", 10, 10, GUI2ndRow + GuiRowSpacing, 190, 10);

  ImgOnOff = cp5.addButton("IMG_ON_OFF");
  ImgOnOff.setValue(10);
  ImgOnOff.setPosition( 10, GUI2ndRow + GuiRowSpacing);
  ImgOnOff.setSize(190, 10);
  ImgOnOff.setGroup(l5);
  ImgOnOff.setCaptionLabel("Image Background >> Hide");

  //RenderOnOff = cp5.addButton("SHOW_ENGINE", 10, 10, GUI2ndRow + 2*GuiRowSpacing, 190, 10);

  RenderOnOff = cp5.addButton("SHOW_ENGINE");
  //RenderOnOff.setValue(10);
  RenderOnOff.setPosition( 10, GUI2ndRow + 2*GuiRowSpacing);
  RenderOnOff.setSize(190, 10);
  RenderOnOff.setGroup(l5);
  RenderOnOff.setCaptionLabel("Rendering Engine >> Hide");

  //PauseButton = cp5.addButton("Pause", 10, 10, GUI2ndRow + 3*GuiRowSpacing, 190, 10);


  PauseButton = cp5.addButton("Pause");
  PauseButton.setPosition( 10, GUI2ndRow + 3*GuiRowSpacing);
  PauseButton.setSize(190, 10);
  PauseButton.setGroup(l5);
  PauseButton.setCaptionLabel("Pause");


  TextColumnStart =  2 * leftcolumwidth + 100;

  ReInitiallizeArray = false;
  pausemode = false;
  showBG  = false;
  invertImg  = false;
  curveLines = 2;
  showEngine = false;
  fileLoaded = false;
  SaveNow = 0;
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    //println("User selected " + selection.getAbsolutePath());

    String loadPath = selection.getAbsolutePath();

    // If a file was selected, print path to file 
    println("Loaded file: " + loadPath); 


    String[] p = splitTokens(loadPath, ".");
    boolean fileOK = false;

    if ( p[p.length - 1].equals("GIF"))
      fileOK = true;
    if ( p[p.length - 1].equals("gif"))
      fileOK = true;      
    if ( p[p.length - 1].equals("JPG"))
      fileOK = true;
    if ( p[p.length - 1].equals("jpg"))
      fileOK = true;   
    if ( p[p.length - 1].equals("TGA"))
      fileOK = true;
    if ( p[p.length - 1].equals("tga"))
      fileOK = true;   
    if ( p[p.length - 1].equals("PNG"))
      fileOK = true;
    if ( p[p.length - 1].equals("png"))
      fileOK = true;   

    println("File OK: " + fileOK); 

    if (fileOK) {
      imgload = loadImage(loadPath); 
      fileLoaded = true;
      // MainArraysetup();
      ReInitiallizeArray = true;
    } else {
      // Can't load file
      ErrorDisplay = "ERROR: BAD FILE TYPE";
      ErrorTime = millis();
      ErrorDisp = true;
    }
  }
}


void LOAD_FILE() {  
  println(":::LOAD JPG, GIF or PNG FILE:::");
  selectInput("Select a file to process:", "fileSelected");  // Opens file chooser
} //End Load File


void SAVE_FILE() {  
  SAVE_SVG();
}

void SavefileSelected(File selection) {
  if (selection == null) {
    // If a file was not selected
    println("No output file was selected...");
    ErrorDisplay = "ERROR: NO FILE NAME CHOSEN.";
    ErrorTime = millis();
    ErrorDisp = true;
  } else { 

    savePath = selection.getAbsolutePath();
    String[] p = splitTokens(savePath, ".");
    boolean fileOK = false;

    if ( p[p.length - 1].equals("PDF"))
      fileOK = true;
    if ( p[p.length - 1].equals("pdf"))
      fileOK = true;      

    if (fileOK == false)
      savePath = savePath + ".pdf";


    // If a file was selected, print path to folder 
    println("Save file: " + savePath);
    SaveNow = 1; 

    ErrorDisplay = "SAVING FILE...";
    ErrorTime = millis();
    ErrorDisp = true;
  }
}


void SAVE_SVG() {  

  if (pausemode != true) {
    Pause();
    ErrorDisplay = "Error: PAUSE before saving.";
    ErrorTime = millis();
    ErrorDisp = true;
  } else {

    selectOutput("Output .pdf file name:", "SavefileSelected");
  }
}


void QUIT() { 
  exit();
}


void CHANGE_CURVATURE() {  
  curveLines += 1;

  if (curveLines > 2)
    curveLines = 0;

  if (curveLines == 0) 
    CurveControl.setCaptionLabel("Paths: Straight Lines");
  if (curveLines == 1) 
    CurveControl.setCaptionLabel("Paths: Round corners");
  if (curveLines == 2) 
    CurveControl.setCaptionLabel("Paths: Curvy");
} 


void SHOW_ENGINE() {  
  if (showEngine) {
    showEngine  = false;
    RenderOnOff.setCaptionLabel("Rendering Engine >> Hide");
  } else {
    showEngine  = true;
    RenderOnOff.setCaptionLabel("Rendering Engine >> Show");
  }
}  


void IMG_ON_OFF() {  
  if (showBG) {
    showBG  = false;
    ImgOnOff.setCaptionLabel("Image Background >> Hide");
  } else {
    showBG  = true;
    ImgOnOff.setCaptionLabel("Image Background >> Show");
  }
} 


void INVERT_IMG() {  
  if (invertImg) {
    invertImg  = false;
    InvertOnOff.setCaptionLabel("Black lines, White Background");
  } else {
    invertImg  = true;
    InvertOnOff.setCaptionLabel("White lines, Black Background");
  }

  ReInitiallizeArray = true;
  pausemode =  false;
} 



void Pause() { 
  // Main particle array setup (to be repeated if necessary):

  if  (pausemode)
  {
    pausemode = false;
    println("Resuming.");
    PauseButton.setCaptionLabel("Pause");
  } else
  {
    pausemode = true;
    println("Paused. Press PAUSE again to resume.");
    PauseButton.setCaptionLabel("Paused (Click to resume)");
  }
} 


boolean overRect(int x, int y, int width, int height) 
{
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void Endpoints(int inValue) { 

  if (maxendpoints != (int) inValue) {
    println("Update:  Stipple Count -> " + inValue); 
    ReInitiallizeArray = true;
  }
}

void Segment_Length(float inValue) {
  if (segmentLength != inValue) {
    println("Update: Segment_Length -> "+inValue);  
    segmentLength = inValue; 

    ReInitiallizeArray = true;
  }
} 


void Spacing_factor(float inValue) {
  if (BlurFactor != inValue) {
    println("Update: BlurFactor -> "+inValue); 
    BlurFactor = inValue; 
    ReInitiallizeArray = true;
  }
} 


void Opacity_Factor(float inValue) {  
  if (OpacityFactor != inValue) {
    println("Update: OpacityFactor -> "+inValue); 
    OpacityFactor = inValue;
    ReInitiallizeArray = true;
  }
} 



void  DoBackgrounds() {
  if (showBG)
    image(img, 0, 0);    // Show original (cropped and scaled, but not blurred!) image in background

  else { 

    if (invertImg)
      background(0);
    else
      background(255);

    //rect(0, 0, mainwidth, mainheight);
  }
}


void CalculateLinePixels(IntPVector fromPoint, IntPVector toPoint, int imgWd, int imgHt)
{
  int temp;
  int pixelPosition;

  float slope;
  int offset;

  int xVal, yVal;

  // Calculate pixel locations in the line
  lineValues = new int[0];  // Begin with empty array.

  int fx =  fromPoint.x ;
  int fy =  fromPoint.y ;
  int tx =  toPoint.x ;
  int ty =  toPoint.y ;

  int xSteps = ceil(abs(tx - fx));
  int ySteps = ceil(abs(ty - fy));

  if (xSteps > ySteps)
  { // work in f(x) basis:
    // y = m * x + b
    // Slope m = dy/dx;
    // offset = fy;

    if (tx < fx)  // WOLOG, let tx >= fx:
    {
      temp = tx;
      tx = fx;
      fx = temp;
      temp = ty;
      ty = fy;
      fy = temp;
    }

    slope = float(ty - fy)/float(tx - fx);
    offset = fy; 

    for (int step = 0; step < xSteps; ++step) 
    {
      xVal = fx + step;
      yVal = round(slope * step) + offset;

      if ((xVal >= 0) && (xVal < imgWd))
        if ((yVal >= 0) && (yVal < imgHt))
        {
          pixelPosition = (yVal * imgWd) + xVal;
          lineValues = splice(lineValues, pixelPosition, 0);
        }
      //step += 2; // Skip faster along line
    }
  } else
  { // work in f(y) basis:
    // x = m * y + b
    // Slope m = dx/dy;
    // offset = fx;

    if (ty < fy)  // WOLOG, let ty >= fy:
    {
      temp = tx;
      tx = fx;
      fx = temp;
      temp = ty;
      ty = fy;
      fy = temp;
    }

    slope = float(tx - fx)/float(ty - fy);
    offset = fx; 

    for (int step = 0; step < ySteps; ++step) 
    {
      yVal = fy + step;
      xVal = round(slope * step) + offset;

      if ((xVal >= 0) && (xVal < imgWd))
        if ((yVal >= 0) && (yVal < imgHt)) {
          pixelPosition = (yVal * imgWd) + xVal;
          lineValues = splice(lineValues, pixelPosition, 0);
        }
      //step += 2; // Skip faster along line
    }
  }
}

void doPhysics()
{   // Try to find lines that work well.

  int i, j;
  float FOM, FOMbest;
  int BGLineIntegral, offscreenPxBrightness;
  //int BlurLineIntegral, blurPxBrightness;

  IntPVector[] endpointsLocal; 
  IntPVector toBest;
  BGLineIntegral = -1;  // "Background" line integral
  //BlurLineIntegral = -1;  // "Background" line integral

  FOMbest = -2147483648;
  toBest = LastPoint;  // Initialize to previous location
  endpointsLocal = new IntPVector[0];  // Begin with empty array.

  if (pausemode == false)
    StatusDisplay = "Calculating next line";
  offScreenCanvas.loadPixels();


  if (invertImg)
  {
    offscreenPxBrightness =  (offScreenCanvas.pixels[(LastPoint.y * imgblur.width) + LastPoint.x] & 0xFF);
  } else
  { 
    offscreenPxBrightness = 0xFF - (offScreenCanvas.pixels[(LastPoint.y * imgblur.width) + LastPoint.x] & 0xFF);
  }

  //Idea: Allow radius to vary with local darkness
  //float lTemp = offscreenPxBrightness / 255.0;
  //lTemp = lTemp * lTemp * lTemp;
  //lTemp = (segmentLength * lTemp) + random(segmentLength/10.0);
  //generateEndpoints(lTemp);
  //println("Seg Length: " + lTemp);


  // Create array of local coordinates surrounding the current position.
  for ( i = 0; i < endpoints.length; ++i) {

    int xTemp = LastPoint.x + endpoints[i].x;
    int yTemp = LastPoint.y + endpoints[i].y;

    // Force these new coordinates to be within bounds
    if (xTemp < lowBorderX)
      xTemp = ceil(lowBorderX);
    if (xTemp > hiBorderX)
      xTemp = floor(hiBorderX);
    if (yTemp < lowBorderY)
      yTemp = ceil(lowBorderY);
    if (yTemp > hiBorderY)
      yTemp = floor(hiBorderY);      

    IntPVector tempVector = 
      new IntPVector(xTemp, yTemp); 

    endpointsLocal  = (IntPVector[])  splice(endpointsLocal, tempVector, 0);
  }

  for ( i = 0; i < endpointsLocal.length; ++i) {

    int lx = abs(LastPoint.x - endpointsLocal[i].x);
    int ly = abs(LastPoint.y - endpointsLocal[i].y);

    if ((lx + ly) >= 2)
    {  //Check that length is AT LEAST 1.4 pixels, or reject this possible line.

      CalculateLinePixels(LastPoint, endpointsLocal[i], imgblur.width, imgblur.height);
      BGLineIntegral = 0;  // "Background" line integral
      //BlurLineIntegral = 0; // Line integral on original image

      int pointsSummed = 0;

      for ( j = 0; j < lineValues.length; ++j) {
        //// Total "darkness" along the line

        if (invertImg)
        {
          offscreenPxBrightness =  (offScreenCanvas.pixels[lineValues[j]] & 0xFF);
          //blurPxBrightness =  0xFF - (imgblur.pixels[lineValues[j]] & 0xFF);
        } else
        { 
          offscreenPxBrightness = 0xFF - (offScreenCanvas.pixels[lineValues[j]] & 0xFF);
          //blurPxBrightness = (imgblur.pixels[lineValues[j]] & 0xFF);
        }

        BGLineIntegral += offscreenPxBrightness;
        //BlurLineIntegral += blurPxBrightness;
        pointsSummed++;
      }

      // Figure of merit:  Normalized (average) darkness along line

      FOM = float(BGLineIntegral) / pointsSummed; 

      // Correction factor: deweight by brightness of original pixels there
      //FOM -= float(BlurLineIntegral) / (3 * pointsSummed); 



      if (FOM > FOMbest)
      {
        FOMbest = FOM;
        toBest = endpointsLocal[i];
      }
    }
  }

  if ((FOMbestLast < 500.0) & (FOMbest < FOMbestLast))
  {
    failcount += 1;

    if (failcount > 5)
    {
      println("Terminate after Segment #" + Generation );
      StatusDisplay = "Calculation complete";

      pausemode = true;
      println("Paused. Press PAUSE to resume.");
      PauseButton.setCaptionLabel("Paused (Click to resume)");
    }
  } else
  {

    failcount = 0;
    offScreenCanvas.beginDraw();

    // Draw "white" lines over plot to remove areas with remaining darkness
    if (invertImg)
    {
      offScreenCanvas.stroke(0, OpacityFactor * 2.55);
    } else
    {
      offScreenCanvas.stroke(255, OpacityFactor * 2.55);
    }
    offScreenCanvas.strokeWeight(BlurFactor);  
    offScreenCanvas.noFill();
    offScreenCanvas.strokeCap(SQUARE);

    offScreenCanvas.line(LastPoint.x, LastPoint.y, toBest.x, toBest.y);
    offScreenCanvas.endDraw();

    LastPoint = toBest; 
    tour  = (IntPVector[])  splice(tour, toBest, 0);

    Generation++;
  }

  FOMbestLast = FOMbest;

  frameTime = (millis() - millisLastFrame)/1000;
  millisLastFrame = millis();
}




void draw()
{

  int i = 0;
  if (ReInitiallizeArray) {

    MainArraysetup();
    ReInitiallizeArray = false;
    pausemode = false;
  } 

  if (pausemode == false)
  {
    for (int a = 0; a < largo; a++) {
      doPhysics();
    }

    //if (frameTime < 0.05)  // Do a second frame of calculation, if things are quick.
    //  doPhysics();
  }

  //http://www.thevelop.nl/blog/2016-12-25/ThreadTone/DoBackgrounds();

  if (invertImg) {
    stroke(255);
  } else {
    stroke(0,1);
  }

  if (showEngine)
  {
    image(offScreenCanvas, 0, 0);
  } else
  {

    strokeWeight(1);
    strokeCap(ROUND);
    noFill();

    // Draw pre-existing paths:

    if (tour.length > 1) {
      beginShape();

      if (curveLines == 0)  // Straight line segments
        for ( i = counter; (i + 1) < tour.length; ++i)
        {
          vertex(tour[i].x, tour[i].y);
        } 

      if (curveLines == 2)// Full curvy segments
        for ( i = counter; (i + 1) < tour.length; ++i)
        {
          curveVertex(tour[i].x, tour[i].y);
        } 

      if (curveLines == 1) // Curve corners
      {

        curveVertex(tour[0].x, tour[0].y);
        for ( i = counter; (i + 1) < tour.length; ++i)
        {
          int x0 = tour[i-1].x;
          int y0 = tour[i-1].y;
          int x1 = tour[i].x;
          int y1 = tour[i].y;

          // Add a midpoint so that only the corners between segments
          // get rounded
          curveVertex(float(x0 + x1) / 2.0, float(y0 + y1) / 2.0);
          curveVertex(x1, y1);
        }
      }
      endShape();
    }
    counter += 55;
    print(counter);
    print("   ");
    println(tour.length);
  }

  noStroke();
  fill(100);   // Background fill color
  rect(0, mainheight, mainwidth, height); // Control area fill

  // Underlay for hyperlink:
  if (overRect(TextColumnStart - 10, mainheight + 35, 205, 20) )
  {
    fill(150); 
    rect(TextColumnStart - 10, mainheight + 35, 205, 20);
  }

  fill(255);   // Text color

  text("HayStack Portrait     (v. 1.0)", TextColumnStart, mainheight + 15);
  text("by Evil Mad Scientist Laboratories", TextColumnStart, mainheight + 30);
  //text("www.evilmadscientist.com/go/stipple2", TextColumnStart, mainheight + 50);

  text("Segments drawn: " + Generation, TextColumnStart, mainheight + 85); 


  text("Figure of merit: " + round(10 * FOMbestLast), TextColumnStart, mainheight + 100);


  if (ErrorDisp)
  {
    fill(255, 0, 0);   // Text color
    text(ErrorDisplay, TextColumnStart, mainheight + 70);
    if ((millis() - ErrorTime) > 8000)
      ErrorDisp = false;
  } else
    text("Status: " + StatusDisplay, TextColumnStart, mainheight + 70);


  if (SaveNow > 0) {
    StatusDisplay = "Saving PDF File";
    SaveNow = 0;

    beginRecord(PDF, savePath); 

    //background(255);
    stroke(0);
    strokeWeight(1);
    strokeCap(ROUND);
    noFill();

    // Draw paths:

    if (tour.length > 1) {
      beginShape();

      if (curveLines == 0)
        for ( i = 0; (i + 1) < tour.length; ++i)
        {
          vertex(tour[i].x, tour[i].y);
        } 

      if (curveLines == 2)
        for ( i = 0; (i + 1) < tour.length; ++i)
        {
          curveVertex(tour[i].x, tour[i].y);
        } 

      if (curveLines == 1)
      {

        curveVertex(tour[0].x, tour[0].y);
        for ( i = 1; (i + 1) < tour.length; ++i)
        {
          int x0 = tour[i-1].x;
          int y0 = tour[i-1].y;
          int x1 = tour[i].x;
          int y1 = tour[i].y;

          // Add a midpoint so that only the corners between segments
          // get rounded
          curveVertex(float(x0 + x1) / 2.0, float(y0 + y1) / 2.0);
          curveVertex(x1, y1);
        }
      }
      endShape();
    }


    endRecord();
    StatusDisplay = "Save complete";

    ErrorTime = millis();
    ErrorDisp = true;
  }

} 


// TODO: Add link to documentation page, once it exists.
//void mousePressed() {
//  if (overRect(TextColumnStart - 15, mainheight + 35, 205, 20) )
//    link("http://www.evilmadscientist.com/go/stipple2");
//} 
