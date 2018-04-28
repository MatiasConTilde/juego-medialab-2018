class Player {
  constructor() {
    this.x = 0;
    this.y = 0;
  }

  set text(text) {
    this.x = canvas.width*Number(text.substr(0, text.indexOf(',')));
    this.y = canvas.height*Number(text.substr(text.indexOf(',')+1));
  }
}

class Bomb {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    ws.send(x/canvas.width + "," + y/canvas.height);

    this.radius = 100;
  }

  update() {
    this.radius--;
  }

  draw() {
    ellipse(this.x, this.y, this.radius, this.radius);
  }

  get delete() {
    return this.radius <= 0;
  }
}

var ws = new WebSocket('ws://192.168.2.140:8001');

let bombs = [];
let player = new Player();

function setup() {
  createCanvas(windowWidth, windowHeight);
}

function draw() {
  background(120, 30, 80);

  for (let i = bombs.length-1; i > 0; i--) {
    b = bombs[i];
    if (b.delete) bombs.splice(i, 1);
    b.update();
    b.draw();
  }

  rect(player.x, player.y, 100, 100);
}

function mousePressed() {
  bombs.push(new Bomb(mouseX, mouseY));
}

ws.onmessage = function(msg) {
  player.text = msg.data
}
