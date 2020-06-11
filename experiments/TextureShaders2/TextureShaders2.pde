/* Texture Shaders by Gene Kogan https://genekogan.com/works/processing-shader-examples/
 
 These are shaders which modify the pixels of a source image. In the example sketch, the source images are three image files.
 
 Click the left and right buttons to scroll through the different shaders, and click up and down to change the source images.
 
 Note: Please note that examples are read-only, therefore if you modify an example you must save it as a new project for the changes to apply).
 
 */
import java.util.Date;
PImage my_img;
String[] filenames;
PImage thumbnail_img;

String[] shaders = new String[] {"blur2.glsl"};

PShader shade;
PImage img1, img2, img3;

int idxSource = 0;
int idxShader = 0;

void setup()
{
  size(1200, 800, P2D);
  textSize(22);
  fill(0);
  /*
  String path = sketchPath("../images");
  filenames = listFileNames(path);

  printArray(filenames);
  my_img = load_my_image("../images/" + filenames[int(random(1, filenames.length))]);
  */
  my_img = load_my_image("osman-rana-_qAIlj1oCNA-unsplash.jpg");
  setupShader();
}

void draw()
{
  setShaderParameters();
  // turn on shader and display source
  shader(shade);
  image(my_img, 0, 0);
  // turn off shader before displaying filename
  resetShader();
}


void setupShader()
{
  shade = loadShader(shaders[idxShader]);
}

void setShaderParameters()
{
  shade.set("sigma", 10.0);
  //shade.set("blurSize", (int) map(mouseY, 0, height, 0, 300.0));
  shade.set("texOffset", 0.0, 1.0);
  //shade.set("imouse", mouseX, mouseY);
  shade.set("num1",mouseX*0.00001);
  shade.set("blurSize",mouseY/20);
}


void keyPressed() {
  if      (keyCode==LEFT) {
    idxShader = (idxShader + shaders.length - 1) % shaders.length;
    setupShader();
  } else if (keyCode==RIGHT) {
    idxShader = (idxShader + 1) % shaders.length;
    setupShader();
  } else if (keyCode==UP) {
    idxSource = (idxSource + 2) % 3;
  } else if (keyCode==DOWN) {
    idxSource = (idxSource + 1) % 4;
  }
  
  //PImage pre_img = load_my_image("../images/" + filenames[int(random(1, filenames.length))]);
  //PGraphics pg = createGraphics(pre_img.width, pre_img.height);


  //my_img = draw_Abstract_from_image(pre_img,pg);
  //my_img = pre_img;
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

PImage load_my_image(String image_path) {

  PImage img = loadImage(image_path);
  int w = img.width;
  int h = img.height;
  int scaleH;
  int scaleW;

  if (w > h) {
    scaleH = img.height*width/img.width;
    scaleW = width;
  } else {
    scaleW = img.width*height/img.height;
    scaleH = height;
  }
  img.resize(scaleW, scaleH);
  thumbnail_img = img.copy();
  thumbnail_img.resize(scaleW/5, scaleH/5);

  return img;
}


PImage draw_Abstract_from_image(PImage img, PGraphics pg) {

  pg.beginDraw();
  pg.background(0);
  img.loadPixels();
  pg.strokeWeight(0.1);
  pg.noStroke();

  for (int i = 0; i < 100000; i++) {
    int x = int(random(img.width));
    int y = int(random(img.height));
    int loc = y * img.width + x;
    float r = red(img.pixels[loc]);
    float g = green(img.pixels[loc]);
    float b = blue(img.pixels[loc]);
    color c = color(r, g, b, 200);
    int w = int(random(5, 20));
    int h = int(random(5, 20));
    pg.fill(0, 80);
    pg.rect(x+1, y+1, w, h);
    pg.fill(c);
    pg.rect(x, y, w, h);
  }
  pg.endDraw();
  return pg;
}
