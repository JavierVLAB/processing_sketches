PImage img;

void setup(){
  size(700,700,P3D);
  img = loadImage("../images2/flow-graphics-nZUQgW0FVnc-unsplash.jpg");
  img.resize(700,0);
}

void draw(){
  background(#f1f1f1);    
  fill(0);
  sphereDetail(3);
  float tiles = 100;
  float tileSize = width/tiles;
  float tilesY = img.height/tileSize;
  
  push();
  
  translate(width/2,height/2);
  rotateY(radians(frameCount));
  noStroke();
  for (int x = 0; x < tiles; x++){
    for (int y = 0; y < tilesY; y++){
      color c = img.get(int(x * tileSize), int(y * tileSize));
      float b = map(brightness(c),0,255,1,0);
      float z = map(b,0,1,-150,150);
      
      push();
      fill(c);
      translate(x * tileSize - width/2, y * tileSize-height/2, z);
      sphere(tileSize * b * 1.8);
      pop();
    }
  }
  pop();
  
}
