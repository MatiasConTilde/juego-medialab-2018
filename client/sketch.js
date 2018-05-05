let player = new Player();
let bombs = [];

let ws = new WebSocket('ws://' + window.location.search.substr(1));

function setup() {
  createCanvas(windowWidth, windowHeight);
  rectMode(CENTER);
}

function draw() {
  background(51);

  for (let i = bombs.length - 1; i > 0; i--) {
    let b = bombs[i];
    b.update();
    if (b.dead) bombs.splice(i, 0);
    else b.draw();
  }

  player.draw();
}

function mousePressed() {
  ws.send({
    bomb: {
      x: mouseX / width,
      y: mouseY / height
    }
  });
}

ws.onmessage = function (msg) {
  const packet = JSON.parse(msg);

  if (packet.player) {
    player.pos = packet.player;
  }

  if (packet.bomb) {
    bombs.push(new Bomb(packet.bomb));
  }
}
