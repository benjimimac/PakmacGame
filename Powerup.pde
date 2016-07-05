class Powerup extends GameObject implements Points {

  PShape powerup;

  Powerup(float x, float y, float objectWidth, color colour) {
    super(x, y, objectWidth, objectWidth, colour);
    fill(colour);
    stroke(colour);
    powerup = createShape(ELLIPSE, 0, 0, objectWidth, objectWidth);
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    shape(powerup);
    popMatrix();
  }

  void applyTo(Pakmac pakmac) {
    pakmac.score += 50;

    for (Ghost ghost : ghosts) {
      ghost.forceTurn();
      ghost.frightened = true; 
      ghost.frightenedTimer = 0;
    }
  }
}