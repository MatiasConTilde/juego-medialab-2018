class Bomb {
  PVector pos;
  float size;

  Bomb(PVector _pos) {
    pos = _pos.copy();
    size = 5;
  }
  
  void update() {
    pos.y += 0.5;
  }
  
  boolean explode() {
    return pos.y >= height - size;
  }

  void display() {
    noStroke();
    fill(255, 0, 0);

    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(size);
    popMatrix();
    
    stroke(255, 0, 0);
    strokeWeight(1);
    line(pos.x, pos.y, pos.z, pos.x, height, pos.z);
  }
}