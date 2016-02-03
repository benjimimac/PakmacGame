class Pakmac extends GameObject {
  //Fields
  //private float start1, start2, close1, close2, startAngle, closeAngle;
  PShape closedMouth;
  PShape openedMouth;

  Pakmac(float x, float y, float objectWidth, float objectHeight, color colour) {
    super(x, y, objectWidth, objectHeight, colour, 3.0f);
    setStart1();
    setClose1();

    start2 = radians(250.0f);//PI + (TWO_PI * 0.2f);
    close2 = radians(470.0f);//PI - (TWO_PI * 0.2f);
    startAngle = start1;
    closeAngle = close1;

    closedMouth = createShape(ARC, 0, 0, objectWidth, objectHeight, startAngle, closeAngle, PIE);
    openedMouth = createShape(ARC, 0, 0, objectWidth, objectHeight, start2, close2, PIE);
    sprite = closedMouth;
  }

  void update(char up, char down, char left, char right) {
    //println("20 radians is " + );
    super.update();
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

    ////println(pos);

    if (keys[right]) {
      if (get((int) pos.x + (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour()) {
        if (theta == HALF_PI) {
          //sprite.rotate(-HALF_PI);
          openedMouth.rotate(-HALF_PI);
          closedMouth.rotate(-HALF_PI);
        }//end if()
        if (theta == PI) {
          //sprite.rotate(-PI);
          openedMouth.rotate(-PI);
          closedMouth.rotate(-PI);
        }//end if
        if (theta == PI + HALF_PI) {
          //sprite.rotate(-(PI + HALF_PI));
          openedMouth.rotate(-(PI + HALF_PI));
          closedMouth.rotate(-(PI + HALF_PI));
        }//end if()
        println(degrees(theta));
        theta = radians(0.0f);
        setStart1();
        setClose1();
      }
      //super.turnRight();
    }
    if (keys[left]) {
      if (get((int) pos.x - (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour()) {
        if (theta == radians(0.0f)) {
          //sprite.rotate(PI);
          openedMouth.rotate(PI);
          closedMouth.rotate(PI);
        }//end if()
        if (theta == HALF_PI) {
          //sprite.rotate(HALF_PI);
          openedMouth.rotate(HALF_PI);
          closedMouth.rotate(HALF_PI);
        }//end if
        if (theta == PI + HALF_PI) {
          //sprite.rotate(-HALF_PI);
          openedMouth.rotate(-HALF_PI);
          closedMouth.rotate(-HALF_PI);
        }//end if()
        theta = PI;
        println(degrees(theta));
        setStart1();
        setClose1();
      }
      //super.turnLeft();
    }
    if (keys[down]) {

      if (get((int) pos.x, (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour()  &&  get((int) pos.x, (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN) {
        if (theta == radians(0.0f)) {
          //sprite.rotate(HALF_PI);
          openedMouth.rotate(HALF_PI);
          closedMouth.rotate(HALF_PI);
        }//end if()
        if (theta == PI) {
          //sprite.rotate(-HALF_PI);
          openedMouth.rotate(-HALF_PI);
          closedMouth.rotate(-HALF_PI);
        }//end if
        if (theta == PI + HALF_PI) {
          //sprite.rotate(-PI);
          openedMouth.rotate(-PI);
          closedMouth.rotate(-PI);
        }//end if()
        theta = HALF_PI;
        println(degrees(theta));
        setStart1();
        setClose1();
      }
      //super.turnDown();
    }
    if (keys[up]) {
      if (get((int) pos.x, (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour()/*maze.path.getPathNext(xReference, yReference - 1) == 1*/) {
        if (theta == radians(0.0f)) {
          //sprite.rotate(PI + HALF_PI);
          openedMouth.rotate(PI + HALF_PI);
          closedMouth.rotate(PI + HALF_PI);
        }//end if()
        if (theta == PI) {
          //sprite.rotate(HALF_PI);
          openedMouth.rotate(HALF_PI);
          closedMouth.rotate(HALF_PI);
        }//end if
        if (theta == HALF_PI) {
          //sprite.rotate(PI);
          openedMouth.rotate(PI);
          closedMouth.rotate(PI);
        }//end if()
        //theta = HALF_PI;
        println(degrees(theta));
        theta = PI + HALF_PI;
        setStart1();
        setClose1();
      }
      //super.turnUp();
    }
  }

  void render() {
    //super.render();
    //arc(pos.x, pos.y, objectWidth, objectHeight, startAngle, closeAngle, PIE);
    pushMatrix();
    translate(pos.x, pos.y);
    shape(sprite);
    popMatrix();
  }

  void openMouth() {
   //startAngle = start2 + theta;
   //closeAngle = close2 + theta;
   sprite = openedMouth;
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