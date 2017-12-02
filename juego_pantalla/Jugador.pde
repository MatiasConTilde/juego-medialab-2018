class Jugador {
  int x, y, z;
  int size;
  Jugador(int x_, int y_, int z_) {
    x = x_;
    y = y_;
    z = z_;
    size=width/4;
  }
  void pintar() {
    size=width/4;
    stroke(175);
    pushMatrix();
    translate(x, y, z+size/2);
    box(size);
    popMatrix();
  }
  void mover(int x_, int y_, int z_) {
    x = x_;
    y = y_;
    z = z_;
  }

  boolean choque(Bomba b) {
    float dist = dist(x, y, z, b.x, b.y, b.z);
    if (dist < size + b.radio) {
      return true;
    } else {
      return false;
    }
  }
}