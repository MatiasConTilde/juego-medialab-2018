class Bomb {
  PVector pos;
  float size;

  boolean hit;
  boolean remove;

  float burst;

  Bomb(PVector _pos) {
    pos = _pos.copy();
    size = 0.05;
    hit = false;
    remove = false;
    burst = 0;
  }

  void update() {
    pos.z += float(height) / 80;
  }

  boolean explode() {
    return pos.z >= height - size * width;
  }

  void display() {
    noStroke();
    if (burst == 0) {
      fill(255, 0, 0);
    } else {
      fill(255, 0, 0, 200);
    }

    pushMatrix();
    translate(pos.x * width, pos.z, (1-pos.y) * -height);
    sphere(size * width + burst);
    popMatrix();

    if (hit) {
      burst += height/785f;
      if (burst > height/15.7) {
        burst = 0;
        remove = true;
      }
      pos.z = height - size * width;
    }

    stroke(255, 0, 0);
    strokeWeight(1);
    line(pos.x * width, pos.z, (1-pos.y) * -height, pos.x * width, height, (1-pos.y) * -height);
  }
}
