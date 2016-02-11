class Pakmac extends GameObject {
  //Fields
  PShape closedMouth;
  PShape openedMouth;
  PShape[] spriteOpenMouth;
  int score;
  int lives;
  PShape liveSprite;
  boolean died;
  float angle;
  boolean eating;
  int foodCount;
  boolean finished;

  Pakmac(float x, float y, float objectWidth, float objectHeight, color colour, char up, char left, char down, char right, float theta) {
    super(x, y, objectWidth, objectHeight, colour, 3.0f);
    setStart1();
    setClose1();
    this.x = x;
    this.y = y;
    score = 0;
    died = false;
    angle = HALF_PI * 0.9f;
    i = 1;
    eating = false;
    this.theta = theta;
    this.startTheta = theta;
    finished = false;
    score = currentScore;
    lives = currentLives;

    start2 = radians(250.0f);
    close2 = radians(470.0f);
    startAngle = start1;
    closeAngle = close1;

    foodCount = 0;
    sprite = createShape(ELLIPSE, 0, 0, objectWidth, objectHeight);
    this.up = up;
    this.left = left;
    this.down = down;
    this.right = right;

    spriteOpenMouth = new PShape[4];
    spriteOpenMouth[0] = createShape(ARC, 0, 0, objectWidth, objectHeight, -HALF_PI + angle, PI + HALF_PI - angle, PIE);
    spriteOpenMouth[1] = createShape(ARC, 0, 0, objectWidth, objectHeight, -PI + angle, PI - angle, PIE);
    spriteOpenMouth[2] = createShape(ARC, 0, 0, objectWidth, objectHeight, HALF_PI + angle, HALF_PI + TWO_PI - angle, PIE);
    spriteOpenMouth[3] = createShape(ARC, 0, 0, objectWidth, objectHeight, angle, TWO_PI - angle, PIE);


    liveSprite = createShape(ARC, 0, 0, objectWidth * 0.5f, objectHeight * 0.5f, -PI + (TWO_PI * 0.12f), PI - (TWO_PI * 0.12f), PIE);
  }

  void update() {
    super.update();
    if (foodCount == 240) {
      finished = true;
    }

    if (pos.x % tileSize > 10  && pos.y % tileSize > 10) {
      eating = false;
    }

    if ((pos.x % tileSize < 10 && pos.y % tileSize > 10) || (pos.x % tileSize > 10 && pos.y % tileSize < 10)) {
      eating = true;
    }

    if (keys[right]) {
      if (get((int) pos.x + (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour()) {
        i = 3;
        theta = 0;
      }
      //super.turnRight();
    }
    if (keys[left]) {
      if (get((int) pos.x - (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour()) {
        i = 1;
        theta = PI;
      }
      //super.turnLeft();
    }
    if (keys[down]) {

      if (get((int) pos.x, (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour()  &&  get((int) pos.x, (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN) {
        i = 2;
        theta = HALF_PI;
      }
    }
    if (keys[up]) {
      if (get((int) pos.x, (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour()/*maze.path.getPathNext(xReference, yReference - 1) == 1*/) {
        i = 0;
        theta = PI + HALF_PI;
      }
      //super.turnUp();
    }
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    if (!eating) {
      shape(sprite);
    } else {
      shape(spriteOpenMouth[i]);
    }
    popMatrix();

    for (int i = 0; i < lives; i++) {
      pushMatrix();
      translate(tileSize + (tileSize * i), height - tileSize * 2);
      shape(liveSprite);
      popMatrix();
    }
  }

  public float getTheta() {
    return theta;
  }

  void resetPakmac() {

    pos = startPos.copy();
    this.theta = PI;
    this.i = 1;
  }
}