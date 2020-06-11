//Pencil class//A simple pencil class, guided by some fake physics//////////////
////////////////////////////////////////////////////////////////////////////////
//They live on a tridimensional world but they are projected onto our canvas,///
//this way we can play with more parameters and nice stuff, keeping the nicer///
//full anti-aliased rendering of Java2D/////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
 
 
class Pencil {
    float
    z,               //z of the pencil
    c_rad=.1,        //this coeficient adjusts size of pencils
    h,               //hue of pencil
    d,               //diameter of pencil
    rF=.01,          //coeficient to adjust rotation forces
    gF=5e-4;         //coeficient to adjust gravity forces
    PVector
    o,               //center of the space
    l,               //location
    s,               //speed
    a;               //acceleration
    int
    maxRad,          //maximum distance to center allowed
    minRad,          //minimum distribution radius
    pHue;            //pencil hue
     
 
    //CONSTRUCTOR
    Pencil(PVector o,int refHue,int minRad,int maxRad){
      this.o=o;
      this.maxRad=maxRad;
      this.minRad=minRad;
      reset(o);
      pHue= floor(random(refHue,refHue+C_R));
    }
     
    //METHODS
    void reset(PVector o){
      float alfa=random(TWO_PI);
      //at the beginning, we distribute randomly the pencils over a sphere of minimum radius
      l=new PVector(o.x+(minRad*cos(alfa)),o.y+(minRad*sin(alfa)),o.z+(minRad*random(-1,1)));
      //random initial speed and null acceleration
      s=new PVector(random(-1,1),random(-1,1),random(-1,1));
      a=new PVector(0,0,0);
      //initial diameter (diameter will be mapped to z)
      d=l.z*c_rad;
    }
   
    void display(){
      float k=norm(PVector.dist(l,o),maxRad,0);
      //basically, here we map brightness to z to get smooth transitions and simulate some volume,
      //and we map alfa to distance to center, to get a richer ambient and a smooth
      //transition in the border
      fill(pHue,CM_R*.75,CM_R-l.z,k*(CM_R/2));
      ellipse(l.x,l.y,d,d); 
    }
   
    void update(ArrayList<Pencil> pencils){
      //we oppose here two forces: one of rotation (r) and one of attraction to center (g)
      a.add(PVector.mult(r(pencils),rF));
      a.add(PVector.mult(g(),gF));
      s.add(a);
      a.mult(0);
      l.add(s); 
      d=l.z*c_rad; //update diameter and
      //if we go beyond the border, start again
      checkBorderToAbyssOfDeathAndReincarnation();
    }
     
    PVector getL() {return l;}
     
    void checkBorderToAbyssOfDeathAndReincarnation(){
      if(PVector.dist(l,o)>=maxRad) reset(o);
    }
   
    PVector g(){
      //pretty straight-forward: attract particles to center
      PVector force=PVector.sub(o,l);
      force.normalize();
      return force;
    }
   
    PVector r(ArrayList<Pencil> pencils){
       PVector totalForce=new PVector(0,0);
       for (Pencil current:pencils){
         //cross product has to do with rotations and it's an important part
         //of electromagnetic field ecuations;
         //here these rotations depend on the position of particles surrounding
         PVector force=s.cross(PVector.add(current.getL(),l));
         totalForce.add(force);
       }
       totalForce.normalize();
       return totalForce;
    }
  }