class Ghost extends GameObject { //<>// //<>//
  //Fields
  PShape[] sprites;
  PShape frightenedSprite;
  PShape[] eatenSprite;
  PShape pupil1;
  PShape pupil2;
  PVector target;
  boolean[] direction = new boolean[4];
  PVector currentTile;
  int startTileCol;
  int startTileRow;
  PVector nextTile;
  int nextTileCol;
  int nextTileRow;
  PVector lastTile;
  PVector homeTile;
  int time;
  boolean ghostArea;
  boolean ready;
  boolean startGhostArea;
  boolean startReady;

  boolean eaten;
  boolean scared;


  Ghost(float x, float y, float objectWidth, float objectHeight, color colour, PVector homeTile, float theta, boolean ghostArea, float speed, boolean ready, int nextTileCol, int nextTileRow) {
    super(x, y, objectWidth, objectHeight, colour, speed);
    this.x = x;
    this.y = y;
    this.theta = theta;
    this.startTheta = theta;
    i = (int) map(startTheta, PI + HALF_PI, 0, 3, 0);
    startI = (int) map(startTheta, PI + HALF_PI, 0, 3, 0);
    sprites = new PShape[4];
    eatenSprite = new PShape[4];
    scared = false;
    eaten = false;

    //frightenedSprite = createShape(GROUP);
    //Create 4 separate sprites for each direction
    //Group shapes together to make the ghost
    for (int index = 0; index < sprites.length; index++) {
      fill(colour);
      stroke(colour);
      sprites[index] = createShape(GROUP);
      eatenSprite[index] = createShape(GROUP);
      PShape head = createShape(ARC, 0, 0, objectWidth, objectWidth, PI, TWO_PI, PIE);
      sprites[index].addChild(head);
      PShape body = createShape(RECT, 0 - objectHeight, 0, objectWidth, objectHeight);
      sprites[index].addChild(body);
      fill(0);
      stroke(0);
      PShape foot1= createShape(TRIANGLE, 0 - objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 - (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
      sprites[index].addChild(foot1);
      PShape foot2= createShape(TRIANGLE, 0 + objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 + (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
      sprites[index].addChild(foot2);
      fill(255);
      stroke(255);
      PShape eye1 = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f), objectHeight * 0.5f, objectHeight * 0.615384f);
      sprites[index].addChild(eye1);
      eatenSprite[index].addChild(eye1);
      PShape eye2 = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f), objectHeight * 0.5f, objectHeight * 0.615384f);
      sprites[index].addChild(eye2);
      eatenSprite[index].addChild(eye2);
    }
    fill(0);
    stroke(0);

    //Pupils facing up
    PShape pupil1Up = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) - 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape pupil2Up = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) - 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    sprites[0].addChild(pupil1Up);
    sprites[0].addChild(pupil2Up);
    eatenSprite[0].addChild(pupil1Up);
    eatenSprite[0].addChild(pupil2Up);

    //Pupils facing left
    PShape  pupil1Left = createShape(ELLIPSE, 0 - (objectHeight * 0.5f) - 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape  pupil2Left = createShape(ELLIPSE, 0 + (objectHeight * 0.5f) - 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    sprites[1].addChild(pupil1Left);
    sprites[1].addChild(pupil2Left);
    eatenSprite[1].addChild(pupil1Left);
    eatenSprite[1].addChild(pupil2Left);

    //Pupils facing down
    PShape pupil1Down = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) + 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape pupil2Down = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) + 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    sprites[2].addChild(pupil1Down);
    sprites[2].addChild(pupil2Down);
    eatenSprite[2].addChild(pupil1Down);
    eatenSprite[2].addChild(pupil2Down);

    //Pupils facing right
    PShape pupil1Right = createShape(ELLIPSE, 0 - (objectHeight * 0.5f) + 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape pupil2Right = createShape(ELLIPSE, 0 + (objectHeight * 0.5f) + 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    sprites[3].addChild(pupil1Right);
    sprites[3].addChild(pupil2Right);
    eatenSprite[3].addChild(pupil1Right);
    eatenSprite[3].addChild(pupil2Right);

    fill(0, 0, 245);
    stroke(0, 0, 245);
    frightenedSprite = createShape(GROUP);
    PShape head = createShape(ARC, 0, 0, objectWidth, objectWidth, PI, TWO_PI, PIE);
    frightenedSprite.addChild(head);
    PShape body = createShape(RECT, 0 - objectHeight, 0, objectWidth, objectHeight);
    frightenedSprite.addChild(body);
    fill(0);
    stroke(0);
    PShape foot1= createShape(TRIANGLE, 0 - objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 - (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
    frightenedSprite.addChild(foot1);
    PShape foot2= createShape(TRIANGLE, 0 + objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 + (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
    frightenedSprite.addChild(foot2);
    fill(255);
    stroke(255);
    PShape eye1 = createShape(ELLIPSE, 0 - (objectHeight * 0.3f), 0 - (objectHeight * 0.25f), objectHeight * 0.3f, objectHeight * 0.3f);
    frightenedSprite.addChild(eye1);
    PShape eye2 = createShape(ELLIPSE, 0 + (objectHeight * 0.3f), 0 - (objectHeight * 0.25f), objectHeight * 0.3f, objectHeight * 0.3f);
    frightenedSprite.addChild(eye2);
    PShape mouth1 = createShape(LINE, 0 - (objectHeight * 0.8f), 0 + (objectHeight * 0.45f), 0 - (objectHeight * 0.5f), 0 + (objectHeight * 0.35f));
    // 0 + (objectHeight * 0.8f), 0 + (objectHeight * 0.45f));
    frightenedSprite.addChild(mouth1);
    PShape mouth2 = createShape(LINE, 0 - (objectHeight * 0.5f), 0 + (objectHeight * 0.35f), 0, 0 + (objectHeight * 0.45f));
    frightenedSprite.addChild(mouth2);
    PShape mouth3 = createShape(LINE, 0, 0 + (objectHeight * 0.45f), 0 + (objectHeight * 0.5f), 0 + (objectHeight * 0.35f));
    frightenedSprite.addChild(mouth3);
    PShape mouth4 = createShape(LINE, 0 + (objectHeight * 0.8f), 0 + (objectHeight * 0.45f), 0 + (objectHeight * 0.5f), 0 + (objectHeight * 0.35f));
    frightenedSprite.addChild(mouth4);

    //Set direction array to false by default
    for (int i = 0; i < direction.length; i++) {
      direction[i] = false;
    }//end for(i)
    //int yReference;
    //int xReference;

    startTileRow = (int) map(pos.x, 0, width, 0, 28);
    startTileCol = (int) map(pos.y, tileSize, tileSize + (tileSize * 31), 0, 31);
    currentTile = new PVector(startTileCol, startTileRow);//new PVector(yReference = (int) map(pos.y, tileSize, tileSize + (tileSize * 31), 0, 31), xReference = (int) map(pos.x, 0, width, 0, 28));
    lastTile = new PVector(11, 15);
    //nextTile = new PVector(currentTile.x, currentTile.y - 2);
    this.nextTileCol = nextTileCol;
    this.nextTileRow = nextTileRow;
    this.nextTile = new PVector(nextTileCol, nextTileRow);
    this.homeTile = homeTile;
    time = 0;
    this.theta = theta;
    this.ghostArea =  ghostArea;
    this.ready = ready;
    this.startGhostArea = ghostArea;
    this.startReady = ready;
    //nextTile.y -= 1;
  }//end Ghost construuctor method

  void render() {
    //super.render();
    pushMatrix();
    translate(pos.x, pos.y);
    //pupil1.rotate(PI);
    if (!scared && !eaten) {
      shape(sprites[i]);
    } else if (eaten) {
      shape(eatenSprite[i]);
    } else {    
      shape(frightenedSprite);
    }
    popMatrix();

    //println("Ghost eaten: " + eaten + ", Target: " + target);

    //arc(pos.x, pos.y, objectWidth, objectHeight, PI, TWO_PI, PIE);
    //ellipse(pos.x, pos.y, objectWidth, objectHeight);
  }

  void update() {//char up, char down, char left, char right) {
    if (mode[2]) {
      if (!ghostArea && ready) {
        scared = true;
      }
    }


    if (ghostArea && getLocation().x == 11 && (getLocation().y == 14)) {//middle.pos.distpos.dist(middle) <= 10) {    getLocation().y == 13 || 
      ghostArea = false;
      //nextTile = new PVector(11, 12);
      speed = 2.0f;
    }
    if (!ghostArea) {
      super.update();



      getDirections();
      if(currentTile.dist(ghostAreaRespawn) == 0){
        for(int i = 0; i < direction.length; i++){
          direction[i] = false;
        }
        
        direction[0] = true;
        pos = respawnPos.copy();
        theta = PI + HALF_PI;
        i = 0;
        ghostArea = true;
        ready = true;
        eaten = false;
        nextTile = newNextTile.copy();
      }
      
      if (direction[0]) {//keys[up] || testTarget) {
        if (get((int) pos.x, (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour()/*maze.path.getPathNext(xReference, yReference - 1) == 1*/) {
          this.i = 0;

          theta = PI + HALF_PI;
          //setStart1();
          //setClose1();
        }
        //super.turnUp();
      } else if (direction[1]) {//keys[left]) {
        if (get((int) pos.x - (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour()) {
          this.i = 1;

          theta = PI;
          //setStart1();
          //setClose1();
        }
        //super.turnLeft();
      } else if (direction[2]) {//keys[down]) {

        if (!eaten) {
          println("jsggggggggggggggggl");
          if (get((int) pos.x, (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour()  &&  get((int) pos.x, (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN) {
            this.i = 2;

            theta = HALF_PI;
            //setStart1();
            //setClose1();
          }
        }else{
          println("helphelphelp");
          if ((get((int) pos.x, (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour()) || get((int) pos.x, (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN){
            this.i = 2;

            theta = HALF_PI;
          }
        }
        //super.turnDown();
      } else if (direction[3]) {//keys[right]) {
        if (get((int) pos.x + (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour()) {
          this.i = 3;

          theta = radians(0.0f);
          //setStart1();
          //setClose1();
        }
        //super.turnRight();
      }
    } else {
      forward.x =  cos(theta);
      forward.y = sin(theta);
      if (ready) {
        //PVector middle = new PVector(tileSize + (tileSize * 14), width * 0.5f);
        

        //println("Ready");
        //PVector middle = new PVector(tileSize + (tileSize * 11), width * 0.5f);
        if (pos.dist(centre) <= 2) {
          //ghostArea = false;
          //if (theta == HALF_PI) {
          //  if (get((int) pos.x, (int) pos.y + (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y + (tileSize + 5)) == maze.getWallColour()) {//pos.y >= 400) {
          this.i = 0;
          theta = PI + HALF_PI;
          //}
          // }
          //if (theta == 0) {
          //  //if (get((int) pos.x, (int) pos.y + (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y + (tileSize + 5)) == maze.getWallColour()) {//pos.y >= 400) {
          //  pushMatrix();
          //  pupil1.translate(-5, -5);
          //  pupil2.translate(-5, -5);
          //  popMatrix();
          //  theta = PI + HALF_PI;
          //  //}
          //}

          //if (theta == PI) {
          //  //if (get((int) pos.x, (int) pos.y + (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y + (tileSize + 5)) == maze.getWallColour()) {//pos.y >= 400) {
          //  pushMatrix();
          //  pupil1.translate(5, -5);
          //  pupil2.translate(5, -5);
          //  popMatrix();
          //  theta = PI + HALF_PI;
          //  //}
          //}
        }

        //if (theta == PI + HALF_PI) {
        if (get((int) pos.x, (int) pos.y - (tileSize + 5)) == maze.getWallColour()) {//pos.y <= 376) {
          this.i = 2;
          theta = HALF_PI;
        }
        // }

        //if (theta == HALF_PI) {
        if (get((int) pos.x, (int) pos.y + (tileSize + 5)) == maze.getWallColour()) {//pos.y >= 400) {
          this.i = 0;
          theta = PI + HALF_PI;
        }

        if (pos.dist(outside) <= 2) {
          i = 1;
          theta = PI;
          setTarget(homeTile);
        }
        // if (theta == 0) {
        //   pushMatrix();
        //   pupil1.translate(-5, -5);
        //   pupil2.translate(-5, -5);
        //   popMatrix();
        //   theta = PI + HALF_PI;
        // }

        // if (theta == PI) {
        //   pushMatrix();
        //   pupil1.translate(5, -5);
        //   pupil2.translate(5, -5);
        //   popMatrix();
        //   theta = PI + HALF_PI;
        // }
        //}

        if (pos.dist(leftCentre) == 0) {
          this.i = 3;
          theta = 0;
        }

        if (pos.dist(rightCentre) == 0) {
          this.i = 1;
          theta = PI;
        }

        //  if (theta == HALF_PI) {
        //    pushMatrix();
        //    pupil1.translate(-5, 5);
        //    pupil2.translate(-5, 5);
        //    popMatrix();
        //  }

        //  theta = 0;
        //}

        //if (pos.dist(right) == 0) {
        //  if (theta == PI + HALF_PI) {
        //    pushMatrix();
        //    pupil1.translate(-5, 5);
        //    pupil2.translate(-5, 5);
        //    popMatrix();
        //  }

        //  if (theta == HALF_PI) {
        //    pushMatrix();
        //    pupil1.translate(-5, -5);
        //    pupil2.translate(-5, -5);
        //    popMatrix();
        //  }

        //  theta = PI;
        //}

        //if(pos.dist(new PVector(x, y)) <= 5){
        //}
      } else {

        //if (theta == PI + HALF_PI) {
        if (get((int) pos.x, (int) pos.y - (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y - (tileSize + 5)) == maze.getWallColour()) {//pos.y <= 376) {
          this.i = 2;
          theta = HALF_PI;
        }
        // }

        //if (theta == HALF_PI) {
        if (get((int) pos.x, (int) pos.y + (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y + (tileSize + 5)) == maze.getWallColour()) {//pos.y >= 400) {
          this.i = 0;
          theta = PI + HALF_PI;
        }
        // }
      }

      super.upDirection();
      super.leftDirection();
      super.downDirection();
      super.rightDirection();
    }
    //boolean testTarget = getDirection();

    //if (frameCount % 240 == 0) {
    //  ready = true;
    //}

    //pickOneDirection();
  }//end update()

  public void getDirections() {//PVector target) {
    //boolean[] tempDir = new boolean[4];  //to be copied to the direction array later
    currentTile = getLocation();
    if (currentTile.x == nextTile.x && currentTile.y == nextTile.y) {

      //println("current == next");

      //if (pakmac.level == 1) {
      //if (timer.count == 420) {// || timer.getCount() == 2040 || timer.getCount() == 3540 || timer.getCount() == 5040) {//Switch to chase
      //  for (int j = 0; j < 200; j++) {
      //    println("Mode change");
      //  }
      //  mode[0] = false;
      //  mode[1] = true;
      //  //forceTurn();
      //} else if (timer.count == 1620 || timer.count == 3240 || timer.count == 4740) {
      //  mode[0] = true;
      //  mode[1] = false;
      //  //forceTurn();
      //}
      // }
      lastTile = currentTile;

      //Set direction array all to false
      for (int i = 0; i < direction.length; i++) {
        direction[i] = false;
      }//end for(i)

      //target = pakmac.getLocation();
      //target = homeTile;
      //this.target = target;



      //Check tile above

      if (maze.path.getPathNext((int) currentTile.x - 1, (int) currentTile.y) == 1) {
        if (theta != HALF_PI) {
          direction[0] = true;
        }
      }

      //Check tile left
      if (maze.path.getPathNext((int) currentTile.x, (int) currentTile.y - 1) == 1) {
        if (theta != 0) {
          direction[1] = true;
        }
      }

      if (!eaten) {
        //Check down tile
        if (maze.path.getPathNext((int) currentTile.x + 1, (int) currentTile.y) == 1) {
          if (theta != PI + HALF_PI) {
            direction[2] = true;
          }
        }//end if()
      } else {
        if (maze.path.getPathNext((int) currentTile.x + 1, (int) currentTile.y) == 1 || maze.path.getPathNext((int) currentTile.x + 1, (int) currentTile.y) == 5) {
          if (theta != PI + HALF_PI) {
            direction[2] = true;
          }
        }
      }

      //check tile right
      if (maze.path.getPathNext((int) currentTile.x, (int) currentTile.y + 1) == 1) {
        if (theta != PI) {
          direction[3] = true;
        }
      }
      //nextTile = currentTile;

      pickOneDirection();

      if (direction[0]) {        
        nextTile.x -= 1;
      }//end if()
      if (direction[1]) {
        if (nextTile.y > 0) {
          nextTile.y -= 1;
        } else {
          nextTile.y = 27;
        }
      }//end if()
      if (direction[2]) {        
        nextTile.x += 1;
      }//end if()
      if (direction[3]) {
        if (nextTile.y < 27) {
          nextTile.y += 1;
        } else {
          nextTile.y = 0;
        }
      }//end if()
    } else {
      //println("Not equal");
    }
    //direction = tempDir;


    //return false;
  }//end getDirections

  public void pickOneDirection() {
    //if(theta == PI + HALF_PI){
    //  direction[2] = false;
    //}//end if()
    //if(theta == PI){
    //  direction[3] = false;
    //}//end if()
    //if(theta == HALF_PI){
    //  direction[0] = false;
    //}//end if()
    //if(theta == 0){
    //  direction[1] = false;
    //}//end if()

    //if (direction[0]) {//if up
    //  if (direction[1]) {//if left
    //    if (distanceToTarget(new PVector(currentTile.x - 1, currentTile.y), new PVector(currentTile.x, currentTile.y - 1)) && theta != HALF_PI) {//dist(target.x, target.y, currentTile.x - 1, currentTile.y) <= dist(target.x, target.y)){
    //      direction[1] = false;
    //      if (direction[2]) {
    //        if (distanceToTarget(new PVector(currentTile.x - 1, currentTile.y), new PVector(currentTile.x + 1, currentTile.y))) {
    //          direction[2] = false;
    //          if (direction[3]) {
    //            if (distanceToTarget(new PVector(currentTile.x - 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1))) {
    //              direction[3] = false;
    //            }//end if()
    //            else {
    //              direction[0] = false;
    //            }//end else
    //          }//end if()
    //        }//end if()
    //        else {
    //          direction[0] = false;
    //          if (direction[3]) {
    //            if (distanceToTarget(new PVector(currentTile.x + 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1))) {
    //              direction[3] = false;
    //            }//end if()
    //            else {
    //              direction[2] = false;
    //            }//end else
    //          }//end if()
    //        }//end else
    //      }//end if()
    //    }//end if()
    //    else {
    //      direction[0] = false;
    //      if (direction[2]) {
    //        if (distanceToTarget(new PVector(currentTile.x, currentTile.y - 1), new PVector(currentTile.x + 1, currentTile.y))) {
    //          direction[2] = false;
    //          if (direction[3]) {
    //            if (distanceToTarget(new PVector(currentTile.x, currentTile.y - 1), new PVector(currentTile.x, currentTile.y + 1))) {
    //              direction[3] = false;
    //            }//end if()
    //          }//end if()
    //        }//end if()
    //        else {
    //          direction[1] = false;
    //          if (distanceToTarget(new PVector(currentTile.x + 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1))) {
    //            direction[3] = false;
    //          }//end if()
    //          else {
    //            direction[2] = false;
    //          }//end else
    //        }//end else
    //      }//end if()
    //    }//end if()
    //  }//end if()
    //}//end if()

    //if (direction[1]) {
    //  if (direction[2]) {
    //    if (distanceToTarget(new PVector(currentTile.x, currentTile.y - 1), new PVector(currentTile.x + 1, currentTile.y))) {//dist(target.x, target.y, currentTile.x - 1, currentTile.y) <= dist(target.x, target.y)){
    //      direction[2] = false;
    //      if (direction[3]) {
    //        if (distanceToTarget(new PVector(currentTile.x, currentTile.y - 1), new PVector(currentTile.x, currentTile.y + 1))) {
    //          direction[3] = false;
    //        }//end if()
    //        else {
    //          direction[1] = false;
    //        }//end else
    //      }//end if()
    //    }//end if()
    //    else {
    //      direction[1] = false;
    //    }//end if()
    //  }//end if()
    //}//end if()

    //if (direction[2]) {
    //  if (direction[3]) {
    //    if (distanceToTarget(new PVector(currentTile.x + 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1))) {
    //      direction[3] = false;
    //    }//end if()
    //    else {
    //      direction[2] = false;
    //    }//end else
    //  }//end if()
    //}//end else

    if (!eaten) {
      if (checkCurrentTile(new PVector(11, 12)) || checkCurrentTile(new PVector(11, 15)) || checkCurrentTile(new PVector(23, 12)) || checkCurrentTile(new PVector(23, 15)))
      {
        direction[0] = false;
      }
    }


    int distUp = getDistance(-1, 0);
    int distLeft = getDistance(0, -1);
    int distDown = getDistance(1, 0);
    int distRight = getDistance(0, 1);

    //float distUp = 0;
    //float distLeft = 0;
    //float distDown = 0;
    //float distRight =  0;

    if (direction[0]) {
      if (direction[1]) {
        if (distUp <= distLeft) {
          direction[1] = false;
          if (direction[2]) {
            if (distUp <= distDown) {
              direction[2] = false;
              if (direction[3]) {
                if (distUp <= distRight) {
                  direction[3] = false;
                } else {
                  direction[0] = false;
                }
              }
            } else {
              direction[0] = false;
              if (direction[3]) {
                if (distDown <= distRight) {
                  direction[3] = false;
                } else {
                  direction[2] = false;
                }
              }
            }
          } else if (direction[3]) {
            if (distUp <= distRight) {
              direction[3] = false;
            } else {
              direction[0] = false;
            }
          }
        } else {
          direction[0] = false;
          if (direction[2]) {
            if (distLeft <= distDown) {
              direction[2] = false;
              if (direction[3]) {
                if (distLeft <= distRight) {
                  direction[3] = false;
                } else {
                  direction[1] = false;
                }
              }
            } else {
              direction[1] = false;
            }
          } else if (direction[3]) {
            if (distLeft <= distRight) {
              direction[3] = false;
            } else {
              direction[1] = false;
            }
          }
        }
      } else if (direction[2]) {
        if (distUp <= distDown) {
          direction[2] = false;
          if (direction[3]) {
            if (distUp <= distRight) {
              direction[3] = false;
            } else {
              direction[0] = false;
            }
          }
        } else {
          direction[0] = false;
          if (direction[3]) {
            if (distDown <= distRight) {
              direction[3] = false;
            } else {
              direction[2] = false;
            }
          }
        }
      } else if (direction[3]) {
        if (distUp <= distRight) {
          direction[3] = false;
        } else {
          direction[0] = false;
        }
      }
    } else if (direction[1]) {
      if (direction[2]) {
        if (distLeft <= distDown) {
          direction[2] = false; 
          if (direction[3]) {
            if (distLeft <= distRight) {
              direction[3] = false;
            } else {
              direction[1] = false;
            }
          }
        } else {
          direction[1] = false;
          if (direction[3]) {
            if (distDown <= distRight) {
              direction[3] = false;
            } else {
              direction[2] = false;
            }
          }
        }
      } else if (direction[3]) {
        if (distLeft <= distRight) {
          direction[3] = false;
        } else {
          direction[1] = false;
        }
      }
    } else if (direction[2]) {
      if (direction[3]) {
        if (distDown <= distRight) {
          direction[3] = false;
        } else {
          direction[2] = false;
        }
      }
    }




    /*
    if (direction[0])//if up    {
     if (direction[1])//if left      {
     if (distUp <= distLeft)//if up closer than left        {
     //left = false
     direction[1] = false;
     if (direction[2])//if down          {
     if (distUp <= distDown)//up closer than down
     {
     //down = false
     direction[2] = false;
     if (direction[3])//if right
     {
     if (distUp <= distRight)//if up closer than right
     {
     //right = false
     direction[3] = false;
     } else {
     direction[0] = false;
     }
     }
     } else {
     //up = false
     direction[0] = false;
     if (direction[3])//if right
     {
     if (distDown <= distRight)//if down closer than right
     {
     //right = false
     direction[3] = false;
     } else
     {
     //down = false
     direction[2] = false;
     }
     }
     }
     } else if (direction[3]) {//if right
     if (distUp <= distRight)//if up closer than right
     {
     //right = false
     direction[3] = false;
     } else
     {
     //up = false
     direction[0] = false;
     }
     }
     } else {//if down
     //up = false
     direction[0] = false;
     if (direction[2])//if down
     {
     if (distLeft <= distDown)//if left closer than down
     {
     direction[2] = false;
     if (direction[3])//if right
     {
     if (distLeft <= distRight) //if left closer than right
     {
     direction[3] = false;
     } else
     {
     direction[1] = false;
     }
     }
     } else
     {
     direction[1] = false;
     if (direction[3])//if right
     {
     if (distDown <= distRight)//if down closer than right
     {
     direction[3] = false;
     } else
     {
     direction[2] = false;
     }
     }
     }
     } else if (direction[3]) {
     if (distLeft <= distRight) {
     direction[3] = false;
     } else {
     direction[1] = false;
     }
     }
     }
     } else if (direction[2]) //if down
     {
     if (distUp <= distDown)//up closer than down
     {
     //down = false
     direction[2] = false;
     if (direction[3])//if right
     {
     if (distUp <= distRight)//if up closer than right
     {
     //right = false
     direction[3] = false;
     } else
     {
     //up = false
     direction[0] = false;
     }
     }
     } else
     {
     //up = false 
     direction[0] = false;
     if (direction[3])//if right
     {
     if (distDown <= distRight) { //if down closer than right
     direction[3] = false;
     } else
     {
     direction[2] = false;
     }
     }
     }
     } else if (direction[3]) //if right
     {
     if (distUp <= distRight)//if up closer than right
     {
     //right = false;
     direction[3] = false;
     } else
     {
     //up = false
     direction[0] = false;
     }
     }
     } else if (direction[1]) 
     {
     if (direction[2]) 
     {
     if (distLeft <= distDown)//if left closer than down
     {
     //down = false
     direction[2] = false;
     if (direction[3])//if right
     {
     if (distLeft <= distRight)//if left closer than right
     {
     //right = false
     direction[3] = false;
     } else
     {
     //left = false 
     direction[1] = false;
     }
     }
     } else {
     //left = false
     direction[1] = false;
     if (direction[3])//if right
     {
     if (distDown <= distRight)//if down closer than right
     {
     //right is false
     direction[3] = false;
     } else
     {
     //down is false
     direction[2] = false;
     }
     }
     }
     } else if (direction[3])//if right 
     {
     if (distLeft <= distRight)//if left closer than right
     {
     //right = false;
     direction[3] = false;
     } else
     {
     //left = false
     direction[1] = false;
     }
     }
     } else if (direction[2]) 
     {
     if (direction[3]) 
     {
     if (distDown <= distRight)//if down closer than right
     {
     direction[3] = false;
     } else {
     direction[2] = false;
     }
     }
     }
     
     */
    /*
    if (direction[0])//if up
     {
     if (direction[1])//if left
     {
     if (distanceToTarget(new PVector(currentTile.x - 1, currentTile.y), new PVector(currentTile.x, currentTile.y - 1)))//if up closer than left
     {
     //left = false
     direction[1] = false;
     if (direction[2])//if down
     {
     if (distanceToTarget(new PVector(currentTile.x - 1, currentTile.y), new PVector(currentTile.x + 1, currentTile.y)))//up closer than down
     {
     //down = false
     direction[2] = false;
     if (direction[3])//if right
     {
     if (distanceToTarget(new PVector(currentTile.x - 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1)))//if up closer than right
     {
     //right = false
     direction[3] = false;
     } else {
     direction[0] = false;
     }
     }
     } else {
     //up = false
     direction[0] = false;
     if (direction[3])//if right
     {
     if (distanceToTarget(new PVector(currentTile.x + 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1)))//if down closer than right
     {
     //right = false
     direction[3] = false;
     } else
     {
     //down = false
     direction[2] = false;
     }
     }
     }
     } else if (direction[3]) {//if right
     if (distanceToTarget(new PVector(currentTile.x - 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1)))//if up closer than right
     {
     //right = false
     direction[3] = false;
     } else
     {
     //up = false
     direction[0] = false;
     }
     }
     } else {//if down
     //up = false
     direction[0] = false;
     if (direction[2])//if down
     {
     if (distanceToTarget(new PVector(currentTile.x, currentTile.y - 1), new PVector(currentTile.x + 1, currentTile.y)))//if left closer than down
     {
     direction[2] = false;
     if (direction[3])//if right
     {
     if (distanceToTarget(new PVector(currentTile.x, currentTile.y - 1), new PVector(currentTile.x, currentTile.y + 1)))
     {
     direction[3] = false;
     } else
     {
     direction[1] = false;
     }
     }
     } else
     {
     direction[1] = false;
     if (direction[3])//if right
     {
     if (distanceToTarget(new PVector(currentTile.x + 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1)))//if down closer than right
     {
     direction[3] = false;
     } else
     {
     direction[2] = false;
     }
     }
     }
     }
     }
     } else if (direction[2]) //if down
     {
     if (distanceToTarget(new PVector(currentTile.x - 1, currentTile.y), new PVector(currentTile.x + 1, currentTile.y)))//up closer than down
     {
     //down = false
     direction[2] = false;
     if (direction[3])//if right
     {
     if (distanceToTarget(new PVector(currentTile.x - 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1)))//if up closer than right
     {
     //right = false
     direction[3] = false;
     } else
     {
     //up = false
     direction[0] = false;
     }
     }
     } else
     {
     //up = false 
     direction[0] = false;
     if (direction[3])//if right
     {
     if (distanceToTarget(new PVector(currentTile.x + 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1))) { //if down closer than right
     direction[3] = false;
     } else
     {
     direction[2] = false;
     }
     }
     }
     } else if (direction[3]) //if right
     {
     if (distanceToTarget(new PVector(currentTile.x - 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1)))//if up closer than right
     {
     //right = false;
     direction[3] = false;
     } else
     {
     //up = false
     direction[0] = false;
     }
     }
     } else if (direction[1]) 
     {
     if (direction[2]) 
     {
     if (distanceToTarget(new PVector(currentTile.x, currentTile.y - 1), new PVector(currentTile.x + 1, currentTile.y)))//if left closer than down
     {
     //down = false
     direction[2] = false;
     if (direction[3])//if right
     {
     if (distanceToTarget(new PVector(currentTile.x, currentTile.y - 1), new PVector(currentTile.x, currentTile.y + 1)))//if left closer than right
     {
     //right = false
     direction[3] = false;
     } else
     {
     //left = false 
     direction[1] = false;
     }
     }
     } else {
     //left = false
     direction[1] = false;
     if (direction[3])//if right
     {
     if (distanceToTarget(new PVector(currentTile.x + 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1)))//if down closer than right
     {
     //right is false
     direction[3] = false;
     } else
     {
     //down is false
     direction[2] = false;
     }
     }
     }
     } else if (direction[3])//if right 
     {
     if (distanceToTarget(new PVector(currentTile.x, currentTile.y - 1), new PVector(currentTile.x, currentTile.y + 1)))//if left closer than right
     {
     //right = false;
     direction[3] = false;
     } else
     {
     //left = false
     direction[1] = false;
     }
     }
     } else if (direction[2]) 
     {
     if (direction[3]) 
     {
     if (distanceToTarget(new PVector(currentTile.x + 1, currentTile.y), new PVector(currentTile.x, currentTile.y + 1)))//if down closer than right
     {
     direction[3] = false;
     } else {
     direction[2] = false;
     }
     }
     }// else if (direction[3]) 
     //{
     //}
     
     */
  }//end pickOneDirection

  public boolean distanceToTarget(PVector tile1, PVector tile2) {
    if (dist(target.x, target.y, tile1.x, tile1.y) <= dist(target.x, target.y, tile2.x, tile2.y)) {
      return true;
    }//end if

    return false;
  }//end distanceToTarget()

  //There are four tiles that ghosts can not turn up on - perform check
  public boolean checkCurrentTile(PVector restricted) {
    if (restricted.x == currentTile.x && restricted.y == currentTile.y) {
      return true;
    }//end if()
    return false;
  }

  public void setTarget(PVector target) {
    this.target = target;
  }

  public int getDistance(int xAdd, int yAdd) {
    //return dist(pakmac.pos.x, pakmac.pos.y, pos.x + (yAdd * tileSize), pos.y + (xAdd * tileSize));
    int count = 0;
    PVector temp = new PVector(getLocation().x + xAdd, getLocation().y + yAdd);

    while (temp.dist(target) != 0) { 
      //while(temp.x != target.x && temp.y != target.y){
      if (temp.x < target.x) {
        if (temp.y < target.y) {
          temp.x += 1;
          temp.y += 1;
        } else if (temp.y > target.y) {
          temp.x += 1;
          temp.y -= 1;
        } else {
          temp.x += 1;
        }
      } else if (temp.x > target.x) {
        if (temp.y < target.y) {
          temp.x -= 1;
          temp.y += 1;
        } else if (temp.y > target.y) {
          temp.x -= 1;
          temp.y -= 1;
        } else {
          temp.x -=1;
        }
      } else {
        if (temp.y < target.y) {
          temp.y += 1;
        } else {//double check maybe an else if
          temp.y -= 1;
        }
      }
      count += 1;
    }

    return  count;
  }

  public boolean allowedToTurn(int xAdd, int yAdd) {
    if (maze.path.getPathNext((int) currentTile.x + xAdd, (int) currentTile.y + yAdd) == 1) {
      return true;
    }
    return false;
  }

  void forceTurn() {
    //for(int i = 0; i < direction.length; i++){
    //  direction[i] = false;
    //}
    if (theta == PI + HALF_PI) {
      theta = HALF_PI;
      //direction[2] = true;
    } else if (theta  == PI) {
      theta = 0;
      //direction[3] = true;
    } else if (theta == HALF_PI) {
      theta = PI + HALF_PI;
      //direction[0] = true;
    } else {
      theta = PI;
      //direction[1] = true;
    }
    nextTile = lastTile;
  }

  void resetGhost() {
    nextTile = new PVector(nextTileCol, nextTileRow);
    theta = startTheta;
    i = startI;
    ghostArea = startGhostArea;
    ready = startReady;
  }
}//end Ghost class()