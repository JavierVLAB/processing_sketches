//import processing.pdf.*;
ArrayList<Particle> particles = new ArrayList<Particle>();

boolean pause = false;


void setup() {
   fullScreen();
  //size(1240, 874);  // imprimeA4
  //size(600, 600);
  for (int i = 0; i < 40; i++) {
    particles.add(new Particle());
    background(0);
    smooth();
  }
  
  //beginRecord(PDF, "everything.pdf");
  
}

void draw() {
  //background(255);

  if (!pause) {
    for (Particle p : particles) {
      p.run();
      if (p.isDead()) {
        p.init();
      }
    }
  }


}

void keyPressed() {
  if (key == 'p' || key == 'P') {
    pause = !pause;
  }

  if (key == 's' || key == 'S') {
    //save("myImg.png");
    save("myImg.tiff");
    //endRecord();
    //exit();
  }
}
