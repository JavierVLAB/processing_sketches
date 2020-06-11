PImage[] imgs = new PImage[4];
float[] cs = {0.0, 0.0, 0.0, 0.0}; 
int imgChange = 1;

float ang = 0;

void setup() {
  size(400, 600, P3D);
  imgs[0] = loadImage("portrait-faces-and-photography-german-woman-tanny.jpg");
  imgs[0].resize(400, 600);
  imgs[1] = imgs[0].copy();
  imgs[2] = imgs[0].copy();
  imgs[3] = imgs[0].copy();
  imgs[1].filter(THRESHOLD, cs[1]);
  imgs[2].filter(THRESHOLD, cs[2]);
  imgs[3].filter(THRESHOLD, cs[3]);
}






void draw() {
  ang += 0.005;
  background(255);

  float cameraY = height/2.0;
  float fov = 1.0;
  //float fov = mouseX/float(width) * PI/2;
  float cameraZ = cameraY / tan(fov / 2.0);
  float aspect = float(width)/float(height);
  if (mousePressed) {
    aspect = aspect / 2.0;
  }
  perspective(fov, aspect, cameraZ/10.0, cameraZ*10.0);

  translate(width/2, height/2, -600);
  rotateX(ang);
  rect(0, 0, 100, 100);
  //image(img1, 0, 0);
  imgs[1].loadPixels();
  for (int y = 0; y < height-10; y += 10) {
    beginShape();
    for (int x=2; x < width-2; x+=5) {
      int z = int(brightness(imgs[0].pixels[x + (y * imgs[0].width)]))/4;

      curveVertex(x, y, z);
    }
    endShape();
  }
}

void test(PImage img) {
  img.loadPixels();
  int x=0;
  int y=0;

  while (y < height && y >= 0) {
    color c = img.pixels[x + (y * img.width) ];
  }
}




void keyPressed() {
  if (key=='1') {
    imgChange = 1;
  }
  if (key=='2') {
    imgChange = 2;
  }
  if (key=='3') {
    imgChange = 3;
  }

  if (key == CODED) {
    if (keyCode == UP) {
      imgs[imgChange] = imgs[0].copy();
      cs[imgChange] = constrain(cs[imgChange]+0.03, 0.0, 1.0);
    } else if (keyCode == DOWN) {
      imgs[imgChange] = imgs[0].copy();
      cs[imgChange] = constrain(cs[imgChange]-0.03, 0.0, 1.0);
    }
    imgs[imgChange].filter(THRESHOLD, cs[imgChange]);
    println(cs[imgChange]);
  }
}
