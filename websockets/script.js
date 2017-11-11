var ws = new WebSocket('ws://localhost:8025/');

function send() {
  ws.send(document.getElementById('msg').value);
}
