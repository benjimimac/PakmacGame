class Ghost extends GameObject {
  //Fields
  PShape pupil1;
  PShape pupil2;
  PVector target;

  Ghost(float x, float y, float objectWidth, float objectHeight, color colour) {
    super(x, y, objectWidth, objectHeight, colour);
    //Group shapes together to make the ghost
    fill(colour);
    stroke(colour);
    sprite = createShape(GROUP);
    PShape head = createShape(ARC, 0, 0, objectWidth, objectWidth, PI, TWO_PI, PIE);
    sprite.addChild(head);
    PShape body = createShape(RECT, 0 - objectHeight, 0, objectWidth, objectHeight);
    sprite.addChild(body);
    fill(0);
    stroke(0);
    PShape foot1= createShape(TRIANGLE, 0 - objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 - (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
    sprite.addChild(foot1);
    PShape foot2= createShape(TRIANGLE, 0 + objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 + (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
    sprite.addChild(foot2);
    fill(255);
    stroke(255);
    PShape eye1 = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f), objectHeight * 0.5f, objectHeight * 0.615384f);
    sprite.addChild(eye1);
    PShape eye2 = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f), objectHeight * 0.5f, objectHeight * 0.615384f);
    sprite.addChild(eye2);
    fill(0);
    stroke(0);
    pupil1 = createShape(ELLIPSE, 0 - (objectHeight * 0.5f) - 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    sprite.addChild(pupil1);
    pupil2 = createShape(ELLIPSE, 0 + (objectHeight * 0.5f) - 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    sprite.addChild(pupil2);
  }//end Ghost construuctor method

  void render() {
    super.render();
    pushMatrix();
    translate(pos.x, pos.y);
    //pupil1.rotate(PI);
    
    shape(sprite);
    popMatrix();
    //arc(pos.x, pos.y, objectWidth, objectHeight, PI, TWO_PI, PIE);
    //ellipse(pos.x, pos.y, objectWidth, objectHeight);
  }

  void update(char up, char down, char left, char right) {

    super.update();
    
    boolean testTarget = target();
    println(testTarget);
    
    if (keys[right]) {
      if (get((int) pos.x + (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour()) {
        if (theta == HALF_PI) {
          pushMatrix();
          pupil1.translate(5, -5);
          pupil2.translate(5, -5);
          popMatrix();
        }//end if()
        if (theta == PI) {
          pushMatrix();
          pupil1.translate(10, 0);
          pupil2.translate(10, 0);
          popMatrix();
        }//end if
        if (theta == PI + HALF_PI) {
          pushMatrix();
          pupil1.translate(5, 5);
          pupil2.translate(5, 5);
          popMatrix();
        }//end if()
        theta = radians(0.0f);
        //setStart1();
        //setClose1();
      }
      //super.turnRight();
    }
    if (keys[left]) {
      if (get((int) pos.x - (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour()) {
        if (theta == radians(0.0f)) {
          pushMatrix();
          pupil1.translate(-10, 0);
          pupil2.translate(-10, 0);
          popMatrix();
        }//end if()
        if (theta == HALF_PI) {
          pushMatrix();
          pupil1.translate(-5, -5);
          pupil2.translate(-5, -5);
          popMatrix();
        }//end if
        if (theta == PI + HALF_PI) {
          pushMatrix();
          pupil1.translate(-5, 5);
          pupil2.translate(-5, 5);
          popMatrix();
        }//end if()
        theta = PI;
        //setStart1();
        //setClose1();
      }
      //super.turnLeft();
    }
    if (keys[down]) {

      if (get((int) pos.x, (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour()  &&  get((int) pos.x, (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN) {
        if (theta == radians(0.0f)) {
          pushMatrix();
          pupil1.translate(-5, 5);
          pupil2.translate(-5, 5);
          popMatrix();
        }//end if()
        if (theta == PI) {
          pushMatrix();
          pupil1.translate(5, 5);
          pupil2.translate(5, 5);
          popMatrix();
        }//end if
        if (theta == PI + HALF_PI) {
          pushMatrix();
          pupil1.translate(0, 10);
          pupil2.translate(0, 10);
          popMatrix();
        }//end if()
        theta = HALF_PI;
        //setStart1();
        //setClose1();
      }
      //super.turnDown();
    }
    if (keys[up]) {
      if (get((int) pos.x, (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour()/*maze.path.getPathNext(xReference, yReference - 1) == 1*/) {
        if (theta == radians(0.0f)) {
          pushMatrix();
          pupil1.translate(-5, -5);
          pupil2.translate(-5, -5);
          popMatrix();
        }//end if()
        if (theta == PI) {
          pushMatrix();
          pupil1.translate(5, -5);
          pupil2.translate(5, -5);
          popMatrix();
        }//end if
        if (theta == HALF_PI) {
          pushMatrix();
          pupil1.translate(0, -10);
          pupil2.translate(0, -10);
          popMatrix();
        }//end if()
        //theta = HALF_PI;
        theta = PI + HALF_PI;
        //setStart1();
        //setClose1();
      }
      //super.turnUp();
    }
    
  }//end update()
  
  public boolean target(){
    target = pakmac.getLocation();
    //println("target is " + target);
    
    PVector tempRef = getLocation();
    if(dist(target.x, target.y, tempRef.x, tempRef.y - 1) <= dist(target.x, target.y, tempRef.x - 1, tempRef.y) && maze.path.getPathNext((int) tempRef.y - 1, (int) tempRef.x) == 1){
      println(/*maze.path.getPathNext((int) tempRef.x, (int) tempRef.y - 1) +*/ tempRef.x + ", " + (tempRef.y - 1));
      return true;
    }
    return false;
  }
}//end Ghost class()