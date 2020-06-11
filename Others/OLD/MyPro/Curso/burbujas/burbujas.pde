PS rojas;
PS verdes;
PS azules;

void setup() {
  size(800, 600); 
  
  colorMode(HSB);
  
  rojas = new PS(20, 0);
  verdes = new PS(20, 130);
  azules = new PS(40, 140);
  //frameRate(1);


}

void draw() {
  background(255);
  azules.dibujaNet();
  azules.dibuja();
  rojas.dibujaNet();
  rojas.dibuja();
  //saveFrame("image-####.gif");
}

