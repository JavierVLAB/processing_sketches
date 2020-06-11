int Nt = 50;
PerlinParticle[] particulas;

void setup(){
	size(600,600,OPENGL);
	hint(DISABLE_DEPTH_TEST);
	
	particulas = new PerlinParticle[Nt];

	for(int i = 0; i < Nt; i++){
		particulas[i] = new PerlinParticle(width/2, i*10+10,i/10000.0);
	}

}

void draw(){
	background(0,1);

	for(int i = 0; i < Nt; i++){
		particulas[i].update();
		particulas[i].display();
	}
	//delay(1000);

}

class PerlinParticle{
	int x,y;
	float id;
	float speed;
	float step; 

	PerlinParticle(int x_, int y_, float id_){
		x = x_;
		y = y_;
		id = id_;
		speed = random(2.0,6.0);

	}

	void update(){
		id += 0.0001;
		step = noise(id)*360;
		y += (int) (sin(radians(step))*speed);
		x += (int) (cos(radians(step))*speed);

	}

	void display(){
		fill(255);
		ellipse(x,y,5,5);
	}

}