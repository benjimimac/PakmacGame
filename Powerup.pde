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

  public void applyTo(Pakmac pakmac) {
    pakmac.score += 50;
    timer.frightened = true;
    
    for (Ghost ghost : ghosts) {
      if (ghost.ready) {
        ghost.forceTurn = true;
        ghost.frightened = true; 
        ghost.frightenedTimer = 0;
      }
    }
  }
}