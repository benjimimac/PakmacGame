abstract class GameObject {
  PVector pos;
  float objectWidth;
  float objectHeight;
  color colour;
  float theta;
  float startTheta;
  
  PShape sprite;
  PShape movingSprite[];
  
  PVector startPos;
  
  GameObject(float x, float y, float objectWidth, float objectHeight, color colour) {
    
    pos = new PVector(x, y);
    startPos = pos.copy();
    this.objectWidth = objectWidth;
    this.objectHeight = objectHeight;
    this.colour = colour;
  }
  
  abstract void render();
}