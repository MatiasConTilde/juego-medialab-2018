class Player {
  PVector pos;
  float size;

  Player() {
    pos = new PVector();
    size = 9;
  }
  
  void move(float x, float z) {
    pos.set(x, height - size / 2, z);
    ws.sendMessage(x + "," + z);
  }
  
  boolean explode(Bomb b) {
    return pos.dist(b.pos) < size + b.size;
  }

  void display() {
    noStroke();
    fill(0, 255, 0);
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(size);
    popMatrix();
  }
}