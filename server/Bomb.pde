class Bomb {
  PVector pos;
  float size;

  boolean hit;
  boolean remove;

  float burst;

  Bomb(PVector _pos) {
    pos = _pos.copy();
    size = width*.026;
    hit = false;
    remove = false;
    burst = 0;
  }

  void update() {
    pos.y += height/80;
  }

  boolean explode() {
    return pos.y >= height - size;
  }

  void display() {
    noStroke();
    if (burst == 0) {
      fill(255, 0, 0);
    } else {
      fill(255, 0, 0, 200);
    }

    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(min(size + burst, size + 20));
    popMatrix();

    if (hit) {
      burst += .2;
      if (burst>22) {
        remove= true;
      }
      pos.y -= height/80;
    }

    stroke(255, 0, 0);
    strokeWeight(1);
    line(pos.x, pos.y, pos.z, pos.x, height, pos.z);
  }
}
