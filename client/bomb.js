class Bomb {
  constructor(object) {
    this.x = object.x;
    this.y = object.y;
    this.z = 1;
  }

  update() {
    this.z -= 1 / 80;
  }

  draw() {
    ellipse(this.x * width, this.y * height, this.z * 100);
  }

  get dead() {
    return this.z <= 0;
  }
}
