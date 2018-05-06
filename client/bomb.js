class Bomb {
  constructor(obj) {
    this.x = obj.x;
    this.y = obj.y;
    this.z = 1;
  }

  update() {
    this.z -= 1 / 80;
  }

  draw() {
    ellipse(this.x * width, this.y * height, this.z * (width / 10));
  }

  get dead() {
    return this.z <= 0;
  }
}
