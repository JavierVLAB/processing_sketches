import fisica.*;

FWorld gameworld;
FBox obstacle;
float diametropelota = 20;//random(30, 60);
FBox[] players = {};
int numplayers = 4;



void setup() {
 size(320,480); 
 smooth();

 
 definegameworld();
 
 setplayers();
 
 for(int i = 0; i<4; i++) {
    
    FCircle b = new FCircle(diametropelota);
    b.setPosition(random(0+diametropelota, width-diametropelota), random(0+diametropelota,height-diametropelota));
    b.setVelocity(random(200)-100, random(0));
    b.setRestitution(1);
    b.setDamping(0.0);
    b.setNoStroke();
    b.setFill(200, 30, 90);
    gameworld.add(b);
  }
 
 
}

void draw(){
  background(255,100);
  
  gameworld.draw();
  gameworld.step(); 
 
  takeplayers();
 
}

void definegameworld(){
  // the world, the gravity and the edge are defined
  Fisica.init(this);
 
  gameworld = new FWorld();
  gameworld.setGravity(0, 0);
  int bordesaliente= 3; // 6 is the value for not see the border
  gameworld.setEdges(-bordesaliente,-2*diametropelota,width+bordesaliente, height+bordesaliente);
  
  // now we set de goal, that consist in 3 obstacles, 2 for be like a egde, 
  // and for make de goal active
  
  int obstacleLarge = int((width- 3.5*diametropelota)/2);
  
  FBox obs1 = new FBox(obstacleLarge,3*diametropelota);
    obs1.setPosition(obstacleLarge/2,-diametropelota);
    obs1.setStatic(true);
    obs1.setRestitution(1);
    obs1.setDamping(0.00);
    obs1.setNoStroke();
    obs1.setFill(0);
    gameworld.add(obs1);
    
    FCircle obs12 = new FCircle(diametropelota);
    obs12.setPosition(obstacleLarge,0);
    obs12.setStatic(true);
    obs12.setRestitution(1);
    obs12.setDamping(0.0);
    obs12.setNoStroke();
    obs12.setFill(0);
    gameworld.add(obs12);
    
    FBox obs2 = new FBox(obstacleLarge,3*diametropelota);
    obs2.setPosition(width-obstacleLarge/2,-diametropelota);
    obs2.setStatic(true);
    obs2.setRestitution(1);
    obs2.setDamping(0.00);
    obs2.setNoStroke();
    obs2.setFill(0);
    gameworld.add(obs2);
    
    FCircle obs22 = new FCircle(diametropelota);
    obs22.setPosition(width-obstacleLarge,0);
    obs22.setStatic(true);
    obs22.setRestitution(1);
    obs22.setDamping(0.0);
    obs22.setNoStroke();
    obs22.setFill(0);
    gameworld.add(obs22);
    
    obstacle = new FBox(4*diametropelota,diametropelota);
    obstacle.setPosition(width/2,-1.5*diametropelota);
    obstacle.setStatic(true);
    obstacle.setRestitution(1);
    obstacle.setDamping(0.00);
    obstacle.setNoStroke();
    obstacle.setFill(0);
    gameworld.add(obstacle);

}


void setplayers(){
 
  for(int i = 0; i < numplayers; i++){
     FBox player = new FBox(2*diametropelota,diametropelota/2);
     player.setPosition(random(width),random(height));
     player.setRotation(i*PI/4);
     player.setStatic(true);
     player.setRestitution(1);
     player.setDamping(0.0);
     player.setNoStroke();
     player.setFill(0);
     players = (FBox[])append(players,player);
     gameworld.add(players[i]);
  }
  
}

void takeplayers(){
  
 for(int i = 0; i < numplayers; i++){
   if(dist(mouseX,mouseY,players[i].getX(),players[i].getY()) < diametropelota){
     players[i].setPosition(mouseX, mouseY);  
   } 
 }
  
}
