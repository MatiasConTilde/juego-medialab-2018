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
    circle(this.x * canvas.width, this.y * canvas.height, this.z * (canvas.width / 10));
  }

  get dead() {
    return this.z <= 0;
  }
}
