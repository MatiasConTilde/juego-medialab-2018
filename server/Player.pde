class Player {
  PVector pos;
  float size;
  boolean hit;
  int hit_timer;
  int lives;

  Player() {
    init();
  }

  void init() {
    pos = new PVector();
    size = 0.1;
    lives = 5;
  }

  void move(float x, float y) {
    pos.set(x, y);
    sendPacket("player", x, y);
  }

  boolean explode(Bomb b) {
    return dist(pos.x, pos.y, b.pos.x, b.pos.y) < size/2 + b.size;
  }

  void display() {
    noStroke();
    fill(0, 255, 0);
    pushMatrix();
    translate(pos.x * width, height - size * width / 2, (pos.y * height) - height);
    if (hit && hit_timer<40) {
      if (random(1)<0.5) {
        box(size * width);
      }
      hit_timer++;
    } else {
      box(size * width);
      hit=false;
    }
    popMatrix();

    text("Lives: "+lives, width/2, 20);
  }

  void hit() {
    hit = true;
    hit_timer = 0;

    lives--;
  }
}
