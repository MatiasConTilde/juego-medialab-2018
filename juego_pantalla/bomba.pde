class Bomba {
  float x;
  float y;
  float z;
  float radio;
  
  
  Bomba() {
    x = random(0, width);
    y = random(0, height);
    z = 500;
    radio = width/8;
  }
  
  void pintar(){
    pushMatrix();
    translate(x, y, z);
    noStroke();
    sphere(radio);
    popMatrix();
  }
  
  void mover(){
    z = z-1;
  }
  
  boolean llegadoSuelo() {
    if (z < 0) {
      return true;
    } else {
      return false;
    }
  }
}