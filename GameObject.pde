class GameObject {
  //Fields
  protected PVector pos;
  protected PVector startPos;
  protected PVector forward;
  protected PShape sprite;
  protected float theta;
  protected float startTheta;
  protected float objectHeight, objectWidth, objectRadius;
  protected color colour;
  protected float speed = 3.0f;
  float x, y;

  protected float start1, start2, close1, close2, startAngle, closeAngle;
  protected char up, left, down, right;
  float halfWidth;
  int i;
  int startI;



  //Constructor method
  GameObject(float x, float y, float objectWidth, float objectHeight, color colour, float speed) {
    this.x = x;
    this.y = y;
    pos = new PVector(x, y);
    startPos = pos.copy();
    //startPos = new PVector(x, y);
    forward = new PVector(0, 0);
    this.objectWidth = objectWidth;
    this.objectHeight = objectHeight;
    objectRadius = objectWidth * 0.5f;
    this.colour = colour;
    this.speed = speed;
    stroke(colour);
    fill(colour);
    halfWidth = objectWidth * 0.5f;
  }

  void render() {
    //noStroke();
    //fill(colour);
  }//end render()

  void update() {
    forward.x =  cos(theta);
    forward.y = sin(theta);
    //int xReference = (int) map(pos.x, 0, width, 0, 28);
    //int yReference = (int) map(pos.y, tileSize, tileSize + (tileSize * 31), 0, 31);


    rightDirection();

    leftDirection();

    downDirection();

    upDirection();

    //forward.mult(speed);
    //pos.add(forward);
  }//end update()

  //void turnRight(){
  //  if (get((int) pos.x + (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour()) {
  //      theta = radians(0.0f);
  //      setStart1();
  //      setClose1();
  //    }
  //}//end turnRight()

  //void turnLeft(){
  //  if (get((int) pos.x - (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour()) {
  //      theta = radians(180.0f);
  //      setStart1();
  //      setClose1();
  //    }
  //}//end turnLeft()

  //void turnUp(){
  //  if (get((int) pos.x, (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour()/*maze.path.getPathNext(xReference, yReference - 1) == 1*/) {
  //      theta = radians(270.0f);
  //      setStart1();
  //      setClose1();
  //    }
  //}//end turnUp()

  //void turnDown(){
  //  if (get((int) pos.x, (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour()  &&  get((int) pos.x, (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN) {
  //      theta = radians(90.0f);
  //      setStart1();
  //      setClose1();
  //    }
  //}//end turnDown()

  void upDirection() {
    if (theta == radians(270.0f)) {
      if (pos.y <= 0) {
        pos.y = height;
      }//end if()

      if (get((int) pos.x, (int) pos.y - (tileSize + 1)) != maze.getWallColour()) {// && get((int) pos.x - (int)(tileSize * 0.5f), (int) pos.y - tileSize) != maze.getWallColour() && get((int) pos.x + (int)(tileSize * 0.5f), (int) pos.y - tileSize) != maze.getWallColour()) {//(get((int) pos.x, (int) pos.y - tileSize) != maze.getWallColour()){//dist(pos.x, pos.y, pos.x + tileSize, pos.y) != color(255)){//maze.path.getPathNext(xReference + 1, yReference) == 1) {
        forward.mult(speed);
        pos.add(forward);
      }//end if()
    }//enf if()
  }

  void leftDirection() {
    if (theta == radians(180.0f)) {
      if (pos.x <= 0) {
        pos.x = width;
      }//end if()

      if (get((int) pos.x - (tileSize), (int) pos.y) != maze.getWallColour()/* || get((int) pos.x - (tileSize), (int) pos.y) != BROWN*/) {// && get((int) pos.x - tileSize, (int) pos.y - (int)(tileSize * 0.5f)) != maze.getWallColour() && get((int) pos.x - tileSize, (int) pos.y + (int) (tileSize * 0.5f)) != maze.getWallColour()) {// (get((int) pos.x - tileSize, (int) pos.y) != maze.getWallColour()){//dist(pos.x, pos.y, pos.x + tileSize, pos.y) != color(255)){//maze.path.getPathNext(xReference + 1, yReference) == 1) {
        forward.mult(speed);
        pos.add(forward);
      }//end if()
      //else if(maze.path.getPathNext(xReference - 1, yReference) == 0){
      // pos.x = map(xReference, 1, 28, tileSize +(tileSize * 0.5f), width);//width - (tileSize + (tileSize * 0.5f));
      //}
    }//enf if()
  }

  void downDirection() {
    if (theta == radians(90.0f)) {
      if (pos.y >= height) {
        pos.y = 0;
      }//end if()

      if (get((int) pos.x, (int) pos.y + (tileSize + 1)) != maze.getWallColour()/* ||get((int) pos.x, (int) pos.y + (tileSize + 1)) != BROWN*/) {// && get((int) pos.x - (int)(tileSize * 0.5f), (int) pos.y + tileSize) != maze.getWallColour() && get((int) pos.x + (int)(tileSize * 0.5f), (int) pos.y + tileSize) != maze.getWallColour()) { //(get((int) pos.x, (int) pos.y + tileSize) != maze.getWallColour()){//dist(pos.x, pos.y, pos.x + tileSize, pos.y) != color(255)){//maze.path.getPathNext(xReference + 1, yReference) == 1) {
        forward.mult(speed);
        pos.add(forward);
      }//end if()
    }//enf if()
  }

  void rightDirection() {
    if (theta == 0.0f) {
      if (pos.x >= width) {
        pos.x = 0;
      }//end if()

      if (get((int) pos.x + (tileSize), (int) pos.y) != maze.getWallColour()) {// && get((int) pos.x + tileSize, (int) pos.y - tileSize + 1) != maze.getWallColour() && get((int) pos.x + tileSize, (int) pos.y + tileSize - 1) != maze.getWallColour()) {//dist(pos.x, pos.y, pos.x + tileSize, pos.y) != color(255)){//maze.path.getPathNext(xReference + 1, yReference) == 1) {
        forward.mult(speed);
        pos.add(forward);
      }//end if()
      //else if(maze.path.getPathNext(xReference + 1, yReference) == 0){
      //  pos.x = map(xReference - 0.5f, 0, 27, 0, width);//width - (tileSize + (tileSize * 0.5f));
      //}
      //pos.add(0.5f, 0, 0);
    }//enf if()
  }

  void openMouth() {
    startAngle = start2 + theta;
    closeAngle = close2 + theta;
  }

  void closeMouth() {
    startAngle = start1;
    closeAngle = close1;
  }

  void setStart1() {
    start1 = theta + radians(20.0f);
  }

  void setClose1() {
    close1 = theta + TWO_PI - radians(20.0f);
  }

  //Getters
  public float getPosX() {
    return pos.x;
  }

  public float getPosY() {
    return pos.y;
  }

  public float getObjectRadius() {
    return objectRadius;
  }

  public float getObjectHeight() {
    return objectRadius;
  }

  public PVector getLocation() {
    //Return yReference then xReference
    int xReference = (int) map(pos.x, 0, width, 0, 28);
    int yReference = (int) map(pos.y, tileSize, tileSize + (tileSize * 31), 0, 31);
    return new PVector(yReference, xReference);
  }
}