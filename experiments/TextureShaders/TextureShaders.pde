/* Texture Shaders by Gene Kogan https://genekogan.com/works/processing-shader-examples/

  These are shaders which modify the pixels of a source image. In the example sketch, the source images are three image files.

  Click the left and right buttons to scroll through the different shaders, and click up and down to change the source images.

  Note: Please note that examples are read-only, therefore if you modify an example you must save it as a new project for the changes to apply).

*/

PImage my_img;
String[] filenames;
PImage thumbnail_img;

String[] shaders = new String[] {"blur.glsl"};

PShader shade;
PImage img1, img2, img3;

int idxSource = 0;
int idxShader = 0;

void setup() 
{
  size(1200,800, P2D);
  textSize(22);
  fill(0);

  String path = sketchPath("../images");
  filenames = listFileNames(path);
  printArray(filenames);
  my_img = load_my_image("../images/" + filenames[int(random(filenames.length))]);  

  // load sources
  img1 = loadImage("hummingbird.jpg");
  img2 = loadImage("fruit-stand.jpg");
  //img3 = loadImage("paris.jpg");
  img3 = loadImage("../images/" + "osman-rana-_qAIlj1oCNA-unsplash.jpg");

  setupShader();
  
}

void draw() 
{
  
  setShaderParameters();

  // turn on shader and display source
  shader(shade);
  if      (idxSource == 0)  image(img1, 0, 0, width, height);
  else if (idxSource == 1)  image(img2, 0, 0, width, height);
  else if (idxSource == 2)  image(img3, 0, 0, width, height);

  // turn off shader before displaying filename
  resetShader();
  text(shaders[idxShader], 5, 20);
  
}


void setupShader() 
{
  shade = loadShader(shaders[idxShader]);
  
}

void setShaderParameters() 
{

  // blur
{
    shade.set("sigma", map(mouseX, 0, width, 0, 30.0));
    shade.set("blurSize", (int) map(mouseY, 0, height, 0, 160.0));
    shade.set("texOffset", 1.0, 1.0);
  } 
}


void keyPressed() {
  if      (keyCode==LEFT) {
    idxShader = (idxShader + shaders.length - 1) % shaders.length;
    setupShader();
  }    
  else if (keyCode==RIGHT) {
    idxShader = (idxShader + 1) % shaders.length;
    setupShader();
  }
  else if (keyCode==UP) {
    idxSource = (idxSource + 2) % 3;
  }
  else if (keyCode==DOWN) {
    idxSource = (idxSource + 1) % 4;
  }
  
    PImage pre_img = load_my_image("../images/" + filenames[int(random(filenames.length))]);
    PGraphics pg = createGraphics(pre_img.width,pre_img.height);
    
    
    my_img = draw_Abstract_from_image(pre_img,pg);
  
  
}
