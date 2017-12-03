class Player {
  PVector pos;
  float size;
  boolean hit;
  int hit_timer;
  int lifes;
  
  Player() {
    pos = new PVector();
    size = 15;
    lifes = 3;
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
    if(hit & hit_timer<40){
      if(random(1)<0.5){
        box(size);
      }
      hit_timer++;
    } else {
      box(size);
      hit=false;
    }
    popMatrix();
  }

void hit()         {
  hit = true;
  hit_timer = 0;
}

}