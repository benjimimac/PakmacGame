class Dot extends GameObject implements Points {
  
  PShape dot;
  
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
  
  void applyTo(Pakmac pakmac) {
   pakmac.score += 10;
   pakmac.foodCount += 1;
  }
}