enum State {
  DEMO, PLAY, WIN, LOSE
}

void stateDemo() {
  // DEMO
  state = State.PLAY;
}

void statePlay() {
  background(0);
  lights();
  ground();

  fill(255);
  image(qrImg, 0, 0);

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
  // DEMO
  state = State.PLAY;
}

void stateLose() {
  // DEMO
  state = State.PLAY;
}
