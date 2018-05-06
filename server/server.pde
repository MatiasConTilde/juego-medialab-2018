import websockets.*;

final float totalGrid = 5;

//Upnp upnp;
WebsocketServer ws;

Player player;
Lives lives;

ArrayList<Bomb> bombs;

void setup() {
  //size(576, 471, P3D);
  size(192, 157, P3D);

  //ws = new WebsocketServer(this, upnp.getPort(), "/");
  ws = new WebsocketServer(this, 8001, "/");

  player = new Player();
  lives = new Lives(5);
  bombs = new ArrayList();
}

void draw() {
  background(0);
  lights();
  ground();

  player.display();
  lives.display();

  for (int i = bombs.size() - 1; i >= 0; i--) {
    Bomb b = bombs.get(i);

    b.update();

    if (b.explode()) {
      println(player.pos, b.pos, dist(player.pos.x, player.pos.y, b.pos.x, b.pos.y));

      if (player.explode(b) && !b.hit) {
        lives.lives--;
        player.hit();
        fill(255, 0, 0);
        b.hit = true;
      }

      if (!b.hit || b.remove) {
        bombs.remove(b);
      }
    }

    b.display();
  }
}

void mouseMoved() {
  player.move(float(mouseX) / width, float(mouseY) / height);
}

void keyPressed() {
  bombs.add(new Bomb(new PVector(random(1), random(1))));
}

void webSocketServerEvent(String msg) {
  println(msg);
  JSONObject packet = parseJSONObject(msg);

  if (packet.getString("type").equals("bomb")) {
    bombs.add(new Bomb(new PVector(packet.getFloat("x"), packet.getFloat("y"))));
    sendPacket("bomb", packet.getFloat("x"), packet.getFloat("y"));
  }
}

void ground() {
  stroke(255);
  strokeWeight(1.5);
  // Don't change it works
  for (float i = 0; i <= totalGrid; i++) {
    line(i * width / totalGrid, height, -height, i * width / totalGrid, height, 0);
    line(0, height, i * height / totalGrid - height, width, height, i * height / totalGrid - height);
  }
}

// void exit() { // doesn't work with stop button!!!!
//   upnp.free();
//   println("Closed UPNP");
//   super.exit();
// }

void sendPacket(String type, float x, float y) {
  JSONObject packet = new JSONObject();
  packet.setString("type", type);
  packet.setFloat("x", x);
  packet.setFloat("y", y);
  try {
    ws.sendMessage(packet.toString());
  }
  catch(Exception e) {
    print("Exception, reload bug (socket is closed) " + e);
  }
}
