class Pakmac extends GameObject {

  float angle;
  char up, left, down, right;
  int spriteDirection;

  Pakmac(float x, float y, float objectWidth, color colour, char up, char left, char down, char right, float theta) {
    super(x, y, objectWidth, objectWidth, colour, theta);
    //this.theta = theta;
    //println(degrees(theta));
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
    //println(pos);
  }

  void render() {
    //println("theta is " + theta);
    pushMatrix();
    translate(pos.x, pos.y);
    //shape(sprite);
    shape(movingSprite[spriteDirection]);
    popMatrix();
  }

  void update() {
    super.update();
println("Pakmac class - " + degrees(theta) + " - " + pos.x + " (" + xReference + ") " + " - " + pos.y + "(" + yReference + ") - ");// + test++);

    //println(xReference, yReference);
    //println(map.path[yReference][xReference - 1]);
    checkKeys();
  }
  
  void checkKeys() {
    if (keys[right]) {
     if (map.path[yReference][xReference + 1] == 1 && pos.y % tileWidth == tileWidth * 0.5f) {
       spriteDirection = 3;
       theta = 0;
     }
     //super.turnRight();
    }
    if (keys[left]) {
     //if (get((int) pos.x - (tileWidth + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x - (tileWidth + 5), (int) pos.y - (tileWidth - 3)) != maze.getWallColour() && get((int) pos.x - (tileWidth + 5), (int) pos.y + (tileWidth - 3)) != maze.getWallColour()) {
     println(theta);
     if (map.path[yReference][xReference - 1] == 1 && pos.y % tileWidth == tileWidth * 0.5f) {
       println(true);
       spriteDirection = 1;
       theta = PI;
     } else {
       println(false);
     }
     //super.turnLeft();
    }
    if (keys[down]) {

     if (map.path[yReference + 1][xReference] == 1 && pos.x % tileWidth == tileWidth * 0.5f) {
       spriteDirection = 2;
       theta = HALF_PI;
     }
    }
    if (keys[up]) {
     if (map.path[yReference - 1][xReference] == 1 && pos.x % tileWidth == tileWidth * 0.5f) {
       spriteDirection = 0;
       theta = PI + HALF_PI;
     }
     //super.turnUp();
    }
  }
}