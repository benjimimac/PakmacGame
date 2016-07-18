class Pakmac extends GameObject implements Reset{

  float angle;
  char up, left, down, right;
  int score, foodCount, lives;

  Pakmac(float x, float y, float objectWidth, color colour, char up, char left, char down, char right, int spriteDirection) {
    super(x, y, objectWidth, objectWidth, colour/*, theta*/);
    //this.theta = theta;
    //println(degrees(theta));
    startTheta = theta;
    angle = HALF_PI * 0.9f;
    speed = 3.0f;
    this.spriteDirection = spriteDirection;
    startSpriteDirection = spriteDirection;
    
    score = 0;
    foodCount = 0;
    lives = 3;

    fill(colour);
    stroke(colour);
    sprite = createShape(ELLIPSE, 0, 0, objectWidth, objectHeight);

    movingSprite1 = new PShape[4];
    movingSprite1[3] = createShape(ARC, 0, 0, objectWidth, objectHeight, -HALF_PI + angle, PI + HALF_PI - angle, PIE);
    movingSprite1[2] = createShape(ARC, 0, 0, objectWidth, objectHeight, -PI + angle, PI - angle, PIE);
    movingSprite1[1] = createShape(ARC, 0, 0, objectWidth, objectHeight, HALF_PI + angle, HALF_PI + TWO_PI - angle, PIE);
    movingSprite1[0] = createShape(ARC, 0, 0, objectWidth, objectHeight, angle, TWO_PI - angle, PIE);
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
    if (!switchSprite) {
      shape(sprite);
    } else {
      shape(movingSprite1[spriteDirection]);
    }
    popMatrix();
  }

  void update() {
    super.update();
    //println("Pakmac class - " + degrees(theta) + " - " + pos.x + " (" + xReference + ") " + " - " + pos.y + "(" + yReference + ") - ");// + test++);

    
    //println(xReference, yReference);
    //println(map.path[yReference][xReference - 1]);
    checkKeys();
  }

  void checkKeys() {
    if (keys[right]) {
      if(xReference > 26) {
       xReference = -1; 
      }
      if ((map.path[yReference][xReference + 1] == 1 || map.path[yReference][xReference + 1] == 2) && pos.y % tileWidth == tileWidth * 0.5f) {
        spriteDirection = 0;
        //theta = 0;
      }
      //super.turnRight();
    }
    if (keys[left]) {
      if(xReference < 1) {
        xReference = 28;
      }
      //if (get((int) pos.x - (tileWidth + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x - (tileWidth + 5), (int) pos.y - (tileWidth - 3)) != maze.getWallColour() && get((int) pos.x - (tileWidth + 5), (int) pos.y + (tileWidth - 3)) != maze.getWallColour()) {
      //println(theta);
      if ((map.path[yReference][xReference - 1] == 1 || map.path[yReference][xReference - 1] == 2) && pos.y % tileWidth == tileWidth * 0.5f) {
        //println(true);
        spriteDirection = 2;
        //theta = PI;
      } else {
        //println(false);
      }
      //super.turnLeft();
    }
    if (keys[down]) {

      if(yReference > 29) {
        yReference = -1;
      }
      
      if (map.path[yReference + 1][xReference] == 1 && pos.x % tileWidth == tileWidth * 0.5f) {
        spriteDirection = 1;
        //theta = HALF_PI;
      }
    }
    if (keys[up]) {
      
      if(yReference < 1) {
       yReference = 31; 
      }
      
      if (map.path[yReference - 1][xReference] == 1 && pos.x % tileWidth == tileWidth * 0.5f) {
        spriteDirection = 3;
        //theta = PI + HALF_PI;
      }
      //super.turnUp();
    }
  }
  
  public void resetPositions() {
    println("Got you, ye little shit ye....");
    pos = new PVector(x, y);
    spriteDirection = startSpriteDirection;
    lives -= 1;
    
    for(Ghost ghost : ghosts) {
      ghost.resetPositions();
    }
  }
}