enum State {
  DEMO, PLAY, WIN, LOSE
}

void stateDemo() {
  background(0);
  fill(255);
  text("Scan this QR code with your phone to start", 8, 52, width-8, height);
  image(qrImg, width/2, qrImg.height/2);
}

void statePlay() {
  background(0);
  lights();
  ground();

  player.display();

  for (int i = bombs.size() - 1; i >= 0; i--) {
    Bomb b = bombs.get(i);

    b.update();

    if (b.explode()) {
      if (player.explode(b) && !b.hit) {
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

void stateWin() {
  background(0);
  fill(255);
  text("You won.", 8, 52, width-8, height);
}

void stateLose() {
  background(0);
  fill(255);
  text("You lost.", 8, 52, width-8, height);
}
