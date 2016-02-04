class Powerup extends GameObject implements Goal {
  PShape powerup;
  
  Powerup(float x, float y, float objectWidth, float objectHeight, color colour) {
    super(x, y, objectWidth, objectHeight, colour, 0.0f);
    powerup = createShape(ELLIPSE, 0, 0, objectWidth, objectHeight);  
  }
  void applyTo(Pakmac pakmac) {
    pakmac.score += 50;
  }
  
  void render(){
    pushMatrix();
    translate(pos.x, pos.y);
    shape(powerup);
    popMatrix();
  }
}