class Bomb {
  PVector pos;
  float size;
  
  boolean exploded;
  
  float burst;
  
  Bomb(PVector _pos) {
    pos = _pos.copy();
    size = 5;
  }
  
  void update() {
    pos.y += 0.8;
  }
  
  boolean explode() {
    burst = 0;
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
    line(pos.x, pos.y, pos.z, pos.x, heightpos.z);
  }
}