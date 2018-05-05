class Bomb {
  PVector pos;
  float size;
  
  boolean hit;
  boolean remove;
  
  float burst;
  
  Bomb(PVector _pos) {
    pos = _pos.copy();
    size = 5;
    hit = false;
    remove = false;
  }
  
  void update() {
    pos.y += 0.8;
  }
  
  boolean explode() {
    return pos.y >= height - size;
  }

  void display() {
    noStroke();
    fill(255, 0, 0);

    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(min(size + burst, size + 20));
    popMatrix();
    
    if(hit){
      burst += 0.2;
      if(burst>22){
        remove= true;
      }
      pos.y -= 0.8;
    }
    
    stroke(255, 0, 0);
    strokeWeight(1);
    line(pos.x, pos.y, pos.z, pos.x, height, pos.z);
  }

  

}