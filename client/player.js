class Player {
  constructor() {
    this.x = 0;
    this.y = 0;
  }

  set pos(obj) {
    this.x = obj.x;
    this.y = obj.y;
  }

  draw() {
    rect(this.x * width, this.y * height, width / 10, width / 10);
  }
}
