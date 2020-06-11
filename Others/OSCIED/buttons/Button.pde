class Button {

  int w, h;
  int xc, yc;
  boolean active;
  String name;
  ;
  Button(int w_, int h_, int xc_, int yc_, String name_) {

    w = w_;
    h = h_;
    xc = xc_;
    yc = yc_;
    active = false;
    name = name_;
  }

  void update() {
    inside();
    display();
  }

  boolean inside() {
    if (mouseX > xc && mouseX < xc + w && mouseY > yc && mouseY < yc + h) {
      active = true;
      return true;
    } else {
      active = false;
      return false;
    }
  }

  void display() {
    rect(xc, yc, w, h);
  }
}