class Player {
  constructor() {
    this.x = 0;
    this.y = 0;
  }

  set pos(object) {
    this.x = object.x;
    this.y = object.y;
  }

  draw() {
    rect(player.x * width, player.y * height, width / 10, width / 10);
  }
}
