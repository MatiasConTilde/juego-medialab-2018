import websockets.*;

WebsocketServer ws;
String msg = "";

void setup() {
  ws = new WebsocketServer(this, 8025, "/");
}

void draw() {
}

void webSocketServerEvent(String _msg) {
  msg = _msg;
  println(msg);
}