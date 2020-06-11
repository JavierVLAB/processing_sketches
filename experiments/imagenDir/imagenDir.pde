import java.util.Date;
PImage my_img;
String[] filenames;
PImage thumbnail_img;

void setup() {
  size(1200,800);
  frameRate(1);
  //Listing all filenames in ../images
  String path = sketchPath("../images");
  filenames = listFileNames(path);
  printArray(filenames);
  my_img = load_my_image("../images/" + filenames[int(random(filenames.length))]);  
  
  image(my_img,0,0);
  //noLoop();
  strokeWeight(0.1);
}

// Nothing is drawn in this program and the draw() doesn't loop because
// of the noLoop() in setup()
void draw() {
  background(150);
  image(my_img,0,0);
  image(thumbnail_img,0,0);
}

// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

PImage load_my_image(String image_path){
  
  PImage img = loadImage(image_path);
  int w = img.width;
  int h = img.height;
  int scaleH;
  int scaleW;
  
  if(w > h){
    scaleH = img.height*width/img.width;
    scaleW = width;
  } else {
    scaleW = img.width*height/img.height;
    scaleH = height;
  }
  img.resize(scaleW, scaleH);
  thumbnail_img = img.copy();
  thumbnail_img.resize(scaleW/5,scaleH/5);
  
  return img;
  
}


PImage draw_Abstract_from_image(PImage img, PGraphics pg){

   pg.beginDraw();
   pg.background(0);
   img.loadPixels();
   pg.strokeWeight(0.1);
   pg.noStroke();
   for(int i = 0; i < 100000; i++){
     int x = int(random(img.width));
     int y = int(random(img.height));
     int loc = y * img.width + x;
     float r = red(img.pixels[loc]);
     float g = green(img.pixels[loc]);
     float b = blue(img.pixels[loc]);
     color c = color(r,g,b,200);
     int w = int(random(5,20));
     int h = int(random(5,20));
     pg.fill(0,80);
     pg.rect(x+1,y+1,w,h);
     pg.fill(c);
     pg.rect(x,y,w,h);  
     
   }
   pg.endDraw();
   return pg;
}


void keyPressed(){
    PImage pre_img = load_my_image("../images/" + filenames[int(random(filenames.length))]);
    PGraphics pg = createGraphics(pre_img.width,pre_img.height);
    
    
    my_img = draw_Abstract_from_image(pre_img,pg);
}
