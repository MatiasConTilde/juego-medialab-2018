class Lives {
  int lives;

  Lives(int l) {
    lives = l;
  }

  void display() {
    for (int i=0; i<lives; i++) {
      pushMatrix();
      translate(i*100-100, -200, -500);
      sphere(50);
      popMatrix();
    }
  }
}
