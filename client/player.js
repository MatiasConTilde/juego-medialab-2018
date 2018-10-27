class Player {
  constructor() {
    this.x = 0.5;
    this.y = 0.5;
  }

  set pos(obj) {
    this.x = obj.x;
    this.y = obj.y;
  }

  draw() {
    fill(120, 100);
    rect(this.x * canvas.width, this.y * canvas.height, canvas.width / 10, canvas.width / 10);
  }
}
