import websockets.*;

WebsocketServer ws;

int x, y;

void setup() {
  size(600, 600);
  
  ws = new WebsocketServer(this, 8025, "/");
  
  x = 0;
  y = 0;
}

void draw() {
  background(0);
  ellipse(x, y, 8, 8);
}

void webSocketServerEvent(String msg) {
  println(msg);
  
  x = int(msg.substring(0, msg.indexOf(",")));
  y = int(msg.substring(msg.indexOf(",") + 1));
  println(x, y);
}