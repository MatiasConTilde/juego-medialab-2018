ArrayList<Bomba> bombas;
float tamano= 0;
int numBombas = 5;

import peasy.*;

PeasyCam cam;

Jugador j;

void setup() {
  size(400, 400, P3D);
  bombas = new ArrayList<Bomba>();

  for (int i = 0; i<numBombas; i++) {
    bombas.add(new Bomba());
  }
  j = new Jugador(mouseX, mouseY, 0 );
  cam = new PeasyCam(this, 100);
  //surface.setResizable(true);
}

void draw() {
  background(40, 70, 137);
  //stroke(255, 0, 0);
  //line(0, 0, 0, width/2, 0, 0);
  //stroke(0, 255, 0);
  //line(0, 0, 0, 0, height/2, 0);
  //stroke(0, 0, 255);
  //line(0, 0, 0, 0, 0, 200);
  
  for (int i = bombas.size() - 1; i > 0; i--) {
    Bomba b = bombas.get(i);
    b.mover();
    b.pintar();

    println(j.choque(b));

    if (b.llegadoSuelo()) {
      bombas.remove(i);
    }
  }
  cuadricula(20);

  j.mover(mouseX, mouseY, 0 );
  j.pintar();

  tamano = tamano + 0.2;
}

void keyPressed() {
  bombas.add(new Bomba());
}

void cuadricula(int cantidad) {
  translate(-width/2, -width/2, 0);
  stroke(0);
  int a = width / cantidad;
  for (int i=0; i <= cantidad; i ++) {
    line(i*a, 0, i*a, width);
    line(0, i*a, width, i*a);
  }
}