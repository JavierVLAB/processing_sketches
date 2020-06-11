class PS {

  ArrayList<Particle> ps;
  int N;

  PS(int _N) {    
    N = _N;
    ps = new ArrayList<Particle>();
    
    for(int i = 0; i < N; i++){
      ps.add(new Particle());
    }
    
    
  }

  void run() {
    for(Particle p: ps){
      p.run();      
    }
  }
  
  
  
  
  
}