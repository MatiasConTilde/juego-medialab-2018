let player = new Player();
let bombs = [];

let ws = new WebSocket('ws://' + window.location.search.substr(1));

function setup() {
  createCanvas(windowWidth, windowHeight);
  rectMode(CENTER);
}

function draw() {
  background(51);

  player.draw();

  for (let i = bombs.length - 1; i > 0; i--) {
    let b = bombs[i];
    b.update();
    if (b.dead) bombs.splice(i, 0);
    else b.draw();
  }
}

function mousePressed() {
  ws.send(JSON.stringify({
    type: 'bomb',
    x: mouseX / width,
    y: mouseY / height
  }));
}

ws.onmessage = function (msg) {
  const packet = JSON.parse(msg.data);

  if (packet.type === 'player') {
    player.pos = packet;
  }

  if (packet.type === 'bomb') {
    bombs.push(new Bomb(packet));
  }
}
