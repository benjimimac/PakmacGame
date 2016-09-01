class Dot extends GameObject implements Points {
  
  PShape dot;
  int points = 10;
  
  Dot(float x, float y, float objectWidth, color colour) {
   super(x, y, objectWidth, objectWidth, colour);
   fill(colour);
   stroke(colour);
   dot = createShape(ELLIPSE, 0, 0, objectWidth, objectHeight);
  }
  
  void render() {
   
    pushMatrix();
    translate(pos.x, pos.y);
    shape(dot);
    popMatrix();
  }
  
  public void applyTo(Pakmac pakmac) {
   pakmac.score += points;
   pakmac.foodCount += 1;
  }
}