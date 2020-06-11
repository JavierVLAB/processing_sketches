//Pencil class////////////////////////////////////////////////////
 
class Pencil {
  PVector
  p,s;            //position and speed
  int
  hu,sa,br,al,    //hue,saturation,brightness,alpha
  lT,lS,lR,       //total life, life going straight, life rotating
  c,              //counter
  am,             //amplitude
  sp,             //spin (sense of rotation)
  D=5;            //diameter range
  float
  sF,             //speed factor
  f=.03;          //noise factor (size of dripping)
  boolean
  alive=true,    
  rotating;
   
  void reset(){
    rotating=true;
    lS=int(random(1,4))*iso;               //'iso' here is quite arbitrary, although I believe to repeat values gives some invisible order to compositions
    lR=int(random(1,3))*iso;               //most important here is '*iso', cause this determines the angles will be allowed ones
    am=int(random(1,7));                   //am(plitude) will determine the amplitude of the rotations, multiplying the (c)ounter
    sp=random(1)<.5?-1:1;                  //sp(in) determines the sense of rotation setting the counter (c) to positive or negative
  }
   
  Pencil(int x,int y){
    p =new PVector(x,y);
    lT=floor(random(50,1000));
    c =floor(random(1,CR/iso+1))*iso%CR;   //reset counter to an allowed random angle  
    s =new PVector(cosins[c],sins[c]);
    sF=random(1,2);
    hu=random(1)<.5? 0:180;
    sa=floor(random(CR/2,CR));
    br=floor(random(CR/2,CR));
    al=CR*3/4;
    reset(); /*but*/ rotating=false;
  }
  
  void update(){
     if (!rotating){                       //if going straight
       p.add(s);                           //just add the speed
       if(--lS<=0) reset();
     }else{                                //if rotating
       c=(c+sp*am)%CR;                     //add the c(ounter) some amplitude and avoid maximum (CR) cause it throws an exception
       if(c<0) c+=CR;                      //avoid negative values
       s=new PVector(cosins[c],sins[c]);
       s.mult(sF);
       p.add(s);
       if(--lR<=0) rotating=false;
     }
     if(--lT<=0) alive=false;
  }
   
  void display(){
    fill(hu,sa,br,al);
    float d=D*(noise(p.x*f,p.y*f)+.15);
    ellipse(p.x,p.y,d,d);
  }
 
  boolean isAlive(){
    return alive;
  }
  
} 
