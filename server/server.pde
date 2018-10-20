import com.cage.zxing4p3.*;

final float totalGrid = 5;

final boolean ENABLE_UPNP = false;
Upnp upnp;
WsServer ws;

ZXING4P zxing;
PImage qrImg;
PFont font;

Player player;
ArrayList<Bomb> bombs;

State state;

void setup() {
  //size(576, 471, P3D);
  size(192, 157, P3D);

  zxing = new ZXING4P();
  resetUpnp();
  font = createFont("m5x7.ttf", 32);
  textFont(font);
  textAlign(CENTER, TOP);
  imageMode(CENTER);

  player = new Player();
  bombs = new ArrayList();

  state = State.DEMO;
}

void draw() {
  switch(state) {
  case DEMO:
    stateDemo();
    break;
  case PLAY:
    statePlay();
    break;
  case WIN:
    stateWin();
    break;
  case LOSE:
    stateLose();
    break;
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
  if (upnp != null) upnp.free();

  try { 
    if (ws != null) {
      ws.stop(1000);
    }
  } 
  catch (InterruptedException e) {
  }

  int port = ceil(random(1024, 65535));

  if (ENABLE_UPNP) {
    upnp = new Upnp(port);
    println("http://cd-mlp.matiascontilde.com/?"+upnp.getExternalIP()+":"+upnp.getPort());
    qrImg = zxing.generateQRCode("http://cd-mlp.matiascontilde.com/?"+upnp.getExternalIP()+":"+upnp.getPort(), 50, 50);
  } else {
    println(port);
    qrImg = zxing.generateQRCode("http://localhost:8080/?localhost:"+port, 48, 48);
  }

  ws = new WsServer(port);

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
    ws.broadcast(packet.toString());
  }
  catch(Exception e) {
    print("Exception, reload bug (socket is closed) " + e);
  }
}

void exit() { // doesn't work with stop button!!!!
  try { 
    ws.stop(1000);
  } 
  catch (InterruptedException e) {
  }

  if (ENABLE_UPNP) upnp.free();
  super.exit();
}
