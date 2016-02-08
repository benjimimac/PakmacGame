class Pakmac extends GameObject {
  //Fields
  //private float start1, start2, close1, close2, startAngle, closeAngle;
  PShape closedMouth;
  PShape openedMouth;
  PShape[] spriteOpenMouth;
  int score;
  int level;
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
    level = 1;
    lives = 3;
    died = false;
    angle = HALF_PI * 0.9f;
    i = 1;
    eating = false;
    this.theta = theta;
    this.startTheta = theta;
    finished = false;

    start2 = radians(250.0f);//PI + (TWO_PI * 0.2f);
    close2 = radians(470.0f);//PI - (TWO_PI * 0.2f);
    startAngle = start1;
    closeAngle = close1;
    
    foodCount = 0;

    //closedMouth = createShape(ARC, 0, 0, objectWidth, objectHeight, startAngle, closeAngle, PIE);
    sprite = createShape(ELLIPSE, 0, 0, objectWidth, objectHeight);

    //openedMouth = createShape(ARC, 0, 0, objectWidth, objectHeight, start2, close2, PIE);
    //sprite = closedMouth;
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

  void update() {//char up, char down, char left, char right) {
    super.update();
    if(foodCount == 240){
      finished = true;
    }
    //forward.x =  cos(theta);
    //forward.y = sin(theta);
    ////int xReference = (int) map(pos.x, 0, width, 0, 28);
    ////int yReference = (int) map(pos.y, tileSize, tileSize + (tileSize * 31), 0, 31);


    //if (theta == 0.0f) {
    //  if(pos.x >= width){
    //    pos.x = 0;
    //  }//end if()

    //  if (get((int) pos.x + (tileSize), (int) pos.y) != maze.getWallColour()){// && get((int) pos.x + tileSize, (int) pos.y - tileSize + 1) != maze.getWallColour() && get((int) pos.x + tileSize, (int) pos.y + tileSize - 1) != maze.getWallColour()) {//dist(pos.x, pos.y, pos.x + tileSize, pos.y) != color(255)){//maze.path.getPathNext(xReference + 1, yReference) == 1) {
    //    forward.mult(speed);
    //    pos.add(forward);
    //  }//end if()
    //  //else if(maze.path.getPathNext(xReference + 1, yReference) == 0){
    //  //  pos.x = map(xReference - 0.5f, 0, 27, 0, width);//width - (tileSize + (tileSize * 0.5f));
    //  //}
    //  //pos.add(0.5f, 0, 0);
    //}//enf if()

    //if (theta == radians(180.0f)) {
    //  if(pos.x <= 0){
    //    pos.x = width;
    //  }//end if()

    //  if (get((int) pos.x - (tileSize), (int) pos.y) != maze.getWallColour()){// && get((int) pos.x - tileSize, (int) pos.y - (int)(tileSize * 0.5f)) != maze.getWallColour() && get((int) pos.x - tileSize, (int) pos.y + (int) (tileSize * 0.5f)) != maze.getWallColour()) {// (get((int) pos.x - tileSize, (int) pos.y) != maze.getWallColour()){//dist(pos.x, pos.y, pos.x + tileSize, pos.y) != color(255)){//maze.path.getPathNext(xReference + 1, yReference) == 1) {
    //    forward.mult(speed);
    //    pos.add(forward);
    //  }//end if()
    //  //else if(maze.path.getPathNext(xReference - 1, yReference) == 0){
    //  // pos.x = map(xReference, 1, 28, tileSize +(tileSize * 0.5f), width);//width - (tileSize + (tileSize * 0.5f));
    //  //}
    //}//enf if()

    //if (theta == radians(90.0f)) {
    //  if(pos.y >= height){
    //    pos.y = 0;
    //  }//end if()

    //  if (get((int) pos.x, (int) pos.y + (tileSize + 1)) != maze.getWallColour()){// && get((int) pos.x - (int)(tileSize * 0.5f), (int) pos.y + tileSize) != maze.getWallColour() && get((int) pos.x + (int)(tileSize * 0.5f), (int) pos.y + tileSize) != maze.getWallColour()) { //(get((int) pos.x, (int) pos.y + tileSize) != maze.getWallColour()){//dist(pos.x, pos.y, pos.x + tileSize, pos.y) != color(255)){//maze.path.getPathNext(xReference + 1, yReference) == 1) {
    //    forward.mult(speed);
    //    pos.add(forward);
    //  }//end if()
    //}//enf if()

    //if (theta == radians(270.0f)) {
    //  if(pos.y <= 0){
    //    pos.y = height;
    //  }//end if()

    //  if (get((int) pos.x, (int) pos.y - (tileSize + 1)) != maze.getWallColour()){// && get((int) pos.x - (int)(tileSize * 0.5f), (int) pos.y - tileSize) != maze.getWallColour() && get((int) pos.x + (int)(tileSize * 0.5f), (int) pos.y - tileSize) != maze.getWallColour()) {//(get((int) pos.x, (int) pos.y - tileSize) != maze.getWallColour()){//dist(pos.x, pos.y, pos.x + tileSize, pos.y) != color(255)){//maze.path.getPathNext(xReference + 1, yReference) == 1) {
    //    forward.mult(speed);
    //    pos.add(forward);
    //  }//end if()
    //}//enf if()

    ////forward.mult(speed);
    ////pos.add(forward);


    if (keys[right]) {
      if (get((int) pos.x + (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour()) {
        //if (theta == HALF_PI) {
        //  //sprite.rotate(-HALF_PI);
        //  openedMouth.rotate(-HALF_PI);
        //  closedMouth.rotate(-HALF_PI);
        //}//end if()
        //if (theta == PI) {
        //  //sprite.rotate(-PI);
        //  openedMouth.rotate(-PI);
        //  closedMouth.rotate(-PI);
        //}//end if
        //if (theta == PI + HALF_PI) {
        //  //sprite.rotate(-(PI + HALF_PI));
        //  openedMouth.rotate(-(PI + HALF_PI));
        //  closedMouth.rotate(-(PI + HALF_PI));
        //}//end if()
        //theta = radians(0.0f);
        //setStart1();
        //setClose1();
        i = 3;
        theta = 0;
      }
      //super.turnRight();
    }
    if (keys[left]) {
      if (get((int) pos.x - (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour()) {
        //if (theta == radians(0.0f)) {
        //  //sprite.rotate(PI);
        //  openedMouth.rotate(PI);
        //  closedMouth.rotate(PI);
        //}//end if()
        //if (theta == HALF_PI) {
        //  //sprite.rotate(HALF_PI);
        //  openedMouth.rotate(HALF_PI);
        //  closedMouth.rotate(HALF_PI);
        //}//end if
        //if (theta == PI + HALF_PI) {
        //  //sprite.rotate(-HALF_PI);
        //  openedMouth.rotate(-HALF_PI);
        //  closedMouth.rotate(-HALF_PI);
        //}//end if()
        //theta = PI;
        //setStart1();
        //setClose1();
        i = 1;
        theta = PI;
      }
      //super.turnLeft();
    }
    if (keys[down]) {

      if (get((int) pos.x, (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour()  &&  get((int) pos.x, (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN) {
        //if (theta == radians(0.0f)) {
        //  //sprite.rotate(HALF_PI);
        //  openedMouth.rotate(HALF_PI);
        //  closedMouth.rotate(HALF_PI);
        //}//end if()
        //if (theta == PI) {
        //  //sprite.rotate(-HALF_PI);
        //  openedMouth.rotate(-HALF_PI);
        //  closedMouth.rotate(-HALF_PI);
        //}//end if
        //if (theta == PI + HALF_PI) {
        //  //sprite.rotate(-PI);
        //  openedMouth.rotate(-PI);
        //  closedMouth.rotate(-PI);
        //}//end if()
        //theta = HALF_PI;
        //setStart1();
        //setClose1();
        i = 2;
        theta = HALF_PI;
      }
      //super.turnDown();
    }
    if (keys[up]) {
      if (get((int) pos.x, (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour()/*maze.path.getPathNext(xReference, yReference - 1) == 1*/) {
        //if (theta == radians(0.0f)) {
        //  //sprite.rotate(PI + HALF_PI);
        //  openedMouth.rotate(PI + HALF_PI);
        //  closedMouth.rotate(PI + HALF_PI);
        //}//end if()
        //if (theta == PI) {
        //  //sprite.rotate(HALF_PI);
        //  openedMouth.rotate(HALF_PI);
        //  closedMouth.rotate(HALF_PI);
        //}//end if
        //if (theta == HALF_PI) {
        //  //sprite.rotate(PI);
        //  openedMouth.rotate(PI);
        //  closedMouth.rotate(PI);
        //}//end if()
        ////theta = HALF_PI;
        //theta = PI + HALF_PI;
        //setStart1();
        //setClose1();
        i = 0;
        theta = PI + HALF_PI;
      }
      //super.turnUp();
    }
  }

  void render() {
    //super.render();
    //arc(pos.x, pos.y, objectWidth, objectHeight, startAngle, closeAngle, PIE);
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

  void openMouth() {
    //startAngle = start2 + theta;
    //closeAngle = close2 + theta;
    //sprite = openedMouth;
  }

  void closeMouth() {
    sprite = closedMouth;
    //startAngle = start1;
    //closeAngle = close1;
  }

  public float getTheta() {
    return theta;
  }

  //void setStart1() {
  //  start1 = theta + radians(20.0f);
  //}

  //void setClose1() {
  //  close1 = theta + TWO_PI - radians(20.0f);
  //}
}