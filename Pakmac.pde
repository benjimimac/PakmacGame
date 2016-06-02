class Pakmac extends GameObject {
  
  float angle;
  char up, left, down, right;
  int spriteDirection;
  
  Pakmac(float x, float y, float objectWidth, color colour, char up, char left, char down, char right, float theta) {
    super(x, y, objectWidth, objectWidth, colour);
    this.theta = theta;
    startTheta = theta;
    angle = HALF_PI * 0.9f;
    
    fill(colour);
    stroke(colour);
    sprite = createShape(ELLIPSE, 0, 0, objectWidth, objectHeight);
    
    movingSprite = new PShape[4];
    movingSprite[0] = createShape(ARC, 0, 0, objectWidth, objectHeight, -HALF_PI + angle, PI + HALF_PI - angle, PIE);
    movingSprite[1] = createShape(ARC, 0, 0, objectWidth, objectHeight, -PI + angle, PI - angle, PIE);
    movingSprite[2] = createShape(ARC, 0, 0, objectWidth, objectHeight, HALF_PI + angle, HALF_PI + TWO_PI - angle, PIE);
    movingSprite[3] = createShape(ARC, 0, 0, objectWidth, objectHeight, angle, TWO_PI - angle, PIE);
    spriteDirection = 1;
    
    this.up = up;
    this.left = left;
    this.down = down;
    this.right = right;
  }
  
  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    shape(sprite);
    popMatrix();
  }
}