class Dot extends GameObject {
  
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
}