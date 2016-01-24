class Pakmac extends GameObject {
  //Fields
  private float start1, start2, close1, close2, startAngle, closeAngle;

  Pakmac(float x, float y, float objectWidth, float objectHeight, color colour) {
    super(x, y, objectWidth, objectHeight, colour);
    setStart1();
    setClose1();

    start2 = TWO_PI * 0.2f;
    close2 = TWO_PI - start2;
    startAngle = start1;
    closeAngle = close1;
  }

  void update(char up, char down, char left, char right) {
    forward.x =  cos(theta);
    forward.y = sin(theta);
    int xReference = (int) map(pos.x, 0, width, 1, 28);
    int yReference = (int) map(pos.y, tileSize, tileSize + (tileSize * 31), 1, 31);
    //println(xReference + ", " + yReference);
    //

    if (theta == 0.0f) {
      if (maze.path.getPathNext(xReference + 1, yReference) == 1) {
        forward.mult(speed);
        pos.add(forward);
      }//end if()
      else if(maze.path.getPathNext(xReference + 1, yReference) == 0){
        pos.x = map(xReference + 0.5f, 1, 28, 0, width);//width - (tileSize + (tileSize * 0.5f));
      }
      //pos.add(0.5f, 0, 0);
    }//enf if()
    
    if (theta == radians(180.0f)) {
      if (maze.path.getPathNext(xReference - 1, yReference) == 1) {
        forward.mult(speed);
        pos.add(forward);
        
        println(pos);
      }//end if()
      else if(maze.path.getPathNext(xReference - 1, yReference) == 0){
        pos.x = map(xReference - 0.5f, 1, 28, 0, width);//width - (tileSize + (tileSize * 0.5f));
      }
    }//enf if()
    
    if (theta == radians(90.0f)) {
      if (maze.path.getPathNext(xReference, yReference + 1) == 1) {
        forward.mult(speed);
        pos.add(forward);
      }//end if()
      else if(maze.path.getPathNext(xReference, yReference + 1) == 0){
        pos.y = map(yReference + 0.5f, 1, 31, 0, tileSize + (tileSize * 31));//width - (tileSize + (tileSize * 0.5f));
      }
    }//enf if()
    
    if (theta == radians(270.0f)) {
      if (maze.path.getPathNext(xReference, yReference - 1) == 1) {
        forward.mult(speed);
        pos.add(forward);
      }//end if()
    }//enf if()

    //forward.mult(speed);
    //pos.add(forward);

    if (keys[right]) {
      theta = radians(0.0f);
      setStart1();
      setClose1();
    }
    if (keys[down]) {
      theta = radians(90.0f);
      setStart1();
      setClose1();
    }
    if (keys[left]) {
      theta = radians(180.0f);
      setStart1();
      setClose1();
    }
    if (keys[up]) {
      theta = radians(270.0f);
      setStart1();
      setClose1();
    }
  }

  void render() {
    super.render();
    arc(pos.x, pos.y, objectWidth, objectHeight, startAngle, closeAngle, PIE);
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
}