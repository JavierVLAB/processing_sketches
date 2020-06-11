ParticleSystem system;
float angle = 0;

boolean co = true;

void setup() {
  size(600, 600, P3D);
  system = new ParticleSystem();
  for (int i = 0; i < 10; i++) {
    system.addParticle();
  }
  smooth();

  system.run();
}

void draw() {
  //background(51);

  lights();
  background( co ? 0 : 255);
  float cameraY = height/2.0;
  float fov = 1.0;
  //float fov = mouseX/float(width) * PI/2;
  float cameraZ = cameraY / tan(fov / 2.0);
  float aspect = float(width)/float(height);
  if (mousePressed) {
    aspect = aspect / 2.0;
  }
  perspective(fov, aspect, cameraZ/10.0, cameraZ*10.0);

  //fill(51,10);
  //rect(0,0,width,height);

  //println(fov);

  //system.addParticle();

  //println(frameRate);

  fill(255);
  translate(width/2, height/2-100, -100);
  rotateX(-PI/6);
  rotateY(angle);
  angle += 0.005;
  //rotateY(PI/3 + mouseY/float(height) * PI);
  //rotateZ(mouseX/float(width) * PI);
  system.run();


  stroke(255, 0, 0);
  line(0, 0, 0, 50, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 50, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 50);


  saveFrame("img/frame-####.png");
  println(frameCount);
  if(frameCount > 600) exit();
}

void keyPressed() {
  co = !co;
}
