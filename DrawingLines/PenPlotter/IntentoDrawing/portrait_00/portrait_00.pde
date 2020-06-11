PImage[] imgs = new PImage[4];
float[] cs = {0.0,0.0,0.0,0.0}; 
int imgChange = 1;



void setup() {
  size(400, 600);
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

background(255);


  //image(img1, 0, 0);
  imgs[1].loadPixels();
  for (int y = 0; y < height; y += 3) {
    int prey = y;
    int prex = 0;
    boolean si = false;
    for (int x=0; x < width; x+=2) {
      if (imgs[1].pixels[x + (y * imgs[1].width)] == color(255, 255, 255) ) {
        if (si) {
          line(prex, prey, x, y);
          si = false;
        } else {
          prex = x;
        }
      } else {
        if (si) {
        } else {
          si = true;
          prex = x;
        }
      }
    }
  }

  imgs[2].loadPixels();
  for (int x = 0; x < width; x += 3) {
    int prex = x;
    int prey = 0;
    boolean si = false;
    for (int y=0; y < height; y+=2) {
      if (imgs[2].pixels[x + (y * imgs[2].width)] == color(255, 255, 255) ) {
        if (si) {
          line(prex, prey, x, y);
          si = false;
        } else {
          prey = y;
        }
      } else {
        if (si) {
        } else {
          si = true;
          prey = y;
        }
      }
    }
  }


  for (int y = 0; y < height; y += 3) {
    int prey = y;
    int prex = 0;
    boolean si = false;
    for (int x=0; x < width; x+=4) {
      if (imgs[1].pixels[x + (y * imgs[1].width)] == color(255, 255, 255) ) {
        if (si) {
          line(prex, prey, x, y);
          si = false;
        } else {
          prex = x;
        }
      } else {
        if (si) {
        } else {
          si = true;
          prex = x;
        }
      }
    }
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
      cs[imgChange] = constrain(cs[imgChange]+0.03,0.0,1.0);
    } else if (keyCode == DOWN) {
      imgs[imgChange] = imgs[0].copy();
      cs[imgChange] = constrain(cs[imgChange]-0.03,0.0,1.0);
    }
    imgs[imgChange].filter(THRESHOLD, cs[imgChange]);
    println(cs[imgChange]);
  }
}
