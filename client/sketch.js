let player = new Player();
let bombs = [];

let ws = new WebSocket('ws://' + window.location.search.substr(1));

const canvas = document.getElementById('canvas');
const ctx = canvas.getContext('2d');

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

setInterval(() => {
  background(15);

  player.draw();

  for (let i = bombs.length - 1; i > 0; i--) {
    let b = bombs[i];
    b.update();
    if (b.dead) bombs.splice(i, 0);
    else b.draw();
  }
}, 20);

canvas.onclick = e => {
  ws.send(JSON.stringify({
    type: 'bomb',
    x: e.x / canvas.width,
    y: e.y / canvas.height
  }));
}

ws.onmessage = msg => {
  const packet = JSON.parse(msg.data);

  if (packet.type === 'player') {
    player.pos = packet;
  }

  if (packet.type === 'bomb') {
    bombs.push(new Bomb(packet));
  }
};
