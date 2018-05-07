import websockets.*;
import com.cage.zxing4p3.*;

final float totalGrid = 5;

Upnp upnp;
WebsocketServer ws;

ZXING4P zxing;
PImage qrImg;

Player player;
Lives lives;

ArrayList<Bomb> bombs;

void setup() {
  size(576, 471, P3D);
  //size(192, 157, P3D);

  zxing = new ZXING4P();

  resetUpnp();

  player = new Player();
  lives = new Lives(5);
  bombs = new ArrayList();
}

void draw() {
  background(0);
  lights();
  ground();

  fill(255);
  image(qrImg, 0, 0);

  player.display();
  lives.display();

  for (int i = bombs.size() - 1; i >= 0; i--) {
    Bomb b = bombs.get(i);

    b.update();

    if (b.explode()) {
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
  newBomb(random(1), random(1));
}

void mousePressed() {
  newBomb(float(mouseX) / width, float(mouseY) / height);
}

void webSocketServerEvent(String msg) {
  JSONObject packet = parseJSONObject(msg);

  if (packet.getString("type").equals("bomb")) {
    newBomb(packet.getFloat("x"), packet.getFloat("y"));
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

boolean resetUpnp() {
  if (ws != null) ws.dispose();
  if (upnp != null) upnp.free();

  upnp = new Upnp(ceil(random(1024, 65535)));
  //upnp = new Upnp(8000);
  ws = new WebsocketServer(this, upnp.getPort(), "/");
  qrImg = zxing.generateQRCode("http://cd-mlp.matiascontilde.com/?"+upnp.getExternalIP()+":"+upnp.getPort(), 50, 50);

  return true;
}

void newBomb(float x, float y) {
  bombs.add(new Bomb(new PVector(x, y)));
  sendPacket("bomb", x, y);
}

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

void exit() { // doesn't work with stop button!!!!
  upnp.free();
  super.exit();
}
