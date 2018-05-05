import websockets.*;

final float totalGrid = 5;

//Upnp upnp;
WebsocketServer ws;


Player player;
Lifes lifes;

ArrayList<Bomb> bombs;

void setup() {
  //size(576, 471, P3D);
  size(192, 157, P3D);
  
  //ws = new WebsocketServer(this, upnp.getPort(), "/");
  ws = new WebsocketServer(this, 8001, "/");
  
  player = new Player();
  lifes = new Lifes(5);
  bombs = new ArrayList();
}

void draw() {
  background(0);
  lights();
  ground();

  player.move(mouseX, mouseY - height);
  player.display();
  lifes.display();

  for (int i = bombs.size() - 1; i >= 0; i--) {
    Bomb b = bombs.get(i);

    b.update();

    if (b.explode()) {
      if (player.explode(b)) {
        if (!b.hit) {
          pushMatrix();
          lifes.lifes--;
          player.hit();
          translate(b.pos.x, b.pos.y, b.pos.z);
          fill(255, 0, 0);
          popMatrix();
        }
        b.hit = true;
      }
      if (!b.hit || b.remove) {
        bombs.remove(b);
      }
    }

    b.display();
  }
}

void keyPressed() {
  bombs.add(new Bomb(new PVector(random(width), 0, random(-height))));
}

void webSocketServerEvent(String msg) {
  println(msg);
  float x =  float(msg.substring(0, msg.indexOf(",")));
  float y =  float(msg.substring(msg.indexOf(",") + 1));
  bombs.add(new Bomb(new PVector(width *x, 0, -height*(1-y))));
}

void ground() {
  stroke(255);
  strokeWeight(1.5);
  for (float i = 0; i <= totalGrid; i++) {
    line(i * width / totalGrid, height, -height, i * width / totalGrid, height, 0);
    line(0, height, i * height / totalGrid - height, width, height, i * height / totalGrid - height);
  }
}
//void exit() {//doesn't work with stop button!!!!
//upnp.free();
//println("EXITED CORRECTLY");
//super.exit();
//}
