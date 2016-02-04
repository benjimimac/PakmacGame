class Ghost extends GameObject {
  //Fields
  PShape pupil1;
  PShape pupil2;
  PVector target;
  boolean[] direction = new boolean[4];
  PVector currentTile;
  PVector nextTile;
  PVector homeTile;
  int time;
  boolean ghostArea;
  boolean ready;
  float x, y;
  PShape frightenedSprite;

  Ghost(float x, float y, float objectWidth, float objectHeight, color colour, PVector homeTile, float theta, boolean ghostArea, float speed, boolean ready, PVector nextTile) {
    super(x, y, objectWidth, objectHeight, colour, speed);
    this.x = x;
    this.y = y;
    
    //frightenedSprite = createShape(GROUP);
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
    if (theta == PI) {
      pupil1 = createShape(ELLIPSE, 0 - (objectHeight * 0.5f) - 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
      pupil2 = createShape(ELLIPSE, 0 + (objectHeight * 0.5f) - 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    } else if (theta == HALF_PI) {
      pupil1 = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) + 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
      pupil2 = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) + 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    } else {
      pupil1 = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) - 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
      pupil2 = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) - 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    }

    sprite.addChild(pupil1);
    sprite.addChild(pupil2);

    //Set direction array to false by default
    for (int i = 0; i < direction.length; i++) {
      direction[i] = false;
    }//end for(i)
    int yReference;
    int xReference;
    currentTile = new PVector(yReference = (int) map(pos.y, tileSize, tileSize + (tileSize * 31), 0, 31), xReference = (int) map(pos.x, 0, width, 0, 28));
    //nextTile = new PVector(currentTile.x, currentTile.y - 2);
    this.nextTile = nextTile;
    this.homeTile = homeTile;
    time = 0;
    this.theta = theta;
    this.ghostArea =  ghostArea;
    this.ready = ready;
    //nextTile.y -= 1;
  }//end Ghost construuctor method

  void render() {
    //super.render();
    pushMatrix();
    translate(pos.x, pos.y);
    //pupil1.rotate(PI);

    shape(sprite);
    popMatrix();
    //arc(pos.x, pos.y, objectWidth, objectHeight, PI, TWO_PI, PIE);
    //ellipse(pos.x, pos.y, objectWidth, objectHeight);
  }

  void update() {//char up, char down, char left, char right) {
    //PVector middle = new PVector(tileSize + (tileSize * 14), width * 0.5f);
    PVector middle = new PVector(width * 0.5f, tileSize + (tileSize * 14) + (tileSize * 0.5f));
    PVector left = new PVector((tileSize * 12), tileSize + (tileSize * 14) + (tileSize * 0.5f));
    PVector right = new PVector((tileSize * 16), tileSize + (tileSize * 14) + (tileSize * 0.5f));
    if (getLocation().x == 11 && (getLocation().y == 14)) {//middle.pos.distpos.dist(middle) <= 10) {    getLocation().y == 13 || 
      ghostArea = false;
      speed = 2.0f;
    }
    if (!ghostArea) {
      println("Not ghost area");
      super.update();
      getDirections();
      if (direction[0]) {//keys[up] || testTarget) {
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

          //nextTile = currentTile;
          //nextTile.x -= 1;

          theta = PI + HALF_PI;
          //setStart1();
          //setClose1();
        }
        //super.turnUp();
      } else if (direction[1]) {//keys[left]) {
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
          //nextTile = currentTile;
          //nextTile.y -= 1;

          theta = PI;
          //setStart1();
          //setClose1();
        }
        //super.turnLeft();
      } else if (direction[2]) {//keys[down]) {

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
          //nextTile = currentTile;
          //nextTile.x += 1;

          theta = HALF_PI;
          //setStart1();
          //setClose1();
        }
        //super.turnDown();
      } else if (direction[3]) {//keys[right]) {
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
          //nextTile = currentTile;
          //nextTile.y += 1;

          theta = radians(0.0f);
          //setStart1();
          //setClose1();
        }
        //super.turnRight();
      }
    } else {
      forward.x =  cos(theta);
      forward.y = sin(theta);
      println("Ghost Area");
      if (ready) {
        println("Ready");
        //println("Ready");
        //PVector middle = new PVector(tileSize + (tileSize * 11), width * 0.5f);
        if (pos.dist(middle) <= 2) {
          println("middle less than 2 " + getLocation() + ghostArea);
          //ghostArea = false;
          if (theta == HALF_PI) {
            if (get((int) pos.x, (int) pos.y + (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y + (tileSize + 5)) == maze.getWallColour()) {//pos.y >= 400) {
              pushMatrix();
              pupil1.translate(0, -10);
              pupil2.translate(0, -10);
              popMatrix();
              theta = PI + HALF_PI;
            }
          }
          if (theta == 0) {
            //if (get((int) pos.x, (int) pos.y + (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y + (tileSize + 5)) == maze.getWallColour()) {//pos.y >= 400) {
            pushMatrix();
            pupil1.translate(-5, -5);
            pupil2.translate(-5, -5);
            popMatrix();
            theta = PI + HALF_PI;
            //}
          }

          if (theta == PI) {
            //if (get((int) pos.x, (int) pos.y + (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y + (tileSize + 5)) == maze.getWallColour()) {//pos.y >= 400) {
            pushMatrix();
            pupil1.translate(5, -5);
            pupil2.translate(5, -5);
            popMatrix();
            theta = PI + HALF_PI;
            //}
          }
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

        if (pos.dist(left) == 0) {
          if (theta == PI + HALF_PI) {
            pushMatrix();
            pupil1.translate(5, 5);
            pupil2.translate(5, 5);
            popMatrix();
          }

          if (theta == HALF_PI) {
            pushMatrix();
            pupil1.translate(5, -5);
            pupil2.translate(5, -5);
            popMatrix();
          }
          theta = 0;
        }

        if (pos.dist(right) == 0) {
          if (theta == PI + HALF_PI) {
            pushMatrix();
            pupil1.translate(-5, 5);
            pupil2.translate(-5, 5);
            popMatrix();
          }

          if (theta == HALF_PI) {
            pushMatrix();
            pupil1.translate(-5, -5);
            pupil2.translate(-5, -5);
            popMatrix();
          }
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

        if (theta == PI + HALF_PI) {
          if (get((int) pos.x, (int) pos.y - (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y - (tileSize + 5)) == maze.getWallColour()) {//pos.y <= 376) {
            pushMatrix();
            pupil1.translate(0, 10);
            pupil2.translate(0, 10);
            popMatrix();
            theta = HALF_PI;
          }
        }

        if (theta == HALF_PI) {
          if (get((int) pos.x, (int) pos.y + (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y + (tileSize + 5)) == maze.getWallColour()) {//pos.y >= 400) {
            pushMatrix();
            pupil1.translate(0, -10);
            pupil2.translate(0, -10);
            popMatrix();
            theta = PI + HALF_PI;
          }
        }
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


        //if (dist(target.x, target.y, tempRef.x - 1, tempRef.y) <= dist(target.y, target.x, tempRef.y - 1, tempRef.x)) {
        // return true;
        //}
      }

      //Check tile left
      if (maze.path.getPathNext((int) currentTile.x, (int) currentTile.y - 1) == 1) {
        if (theta != 0) {
          direction[1] = true;
        }
      }

      //Check down tile
      if (maze.path.getPathNext((int) currentTile.x + 1, (int) currentTile.y) == 1) {
        if (theta != PI + HALF_PI) {
          direction[2] = true;
        }
      }//end if()

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


    if (checkCurrentTile(new PVector(11, 12)) || checkCurrentTile(new PVector(11, 15)) || checkCurrentTile(new PVector(23, 12)) || checkCurrentTile(new PVector(23, 15)))
    {
      direction[0] = false;
    }


    int distUp = getDistance(-1, 0);
    int distLeft = getDistance(0, -1);
    int distDown = getDistance(1, 0);
    int distRight = getDistance(0, 1);

    //float distUp = 0;
    //float distLeft = 0;
    //float distDown = 0;
    //float distRight =  0;

    if (direction[0])//if up
    {
      if (direction[1])//if left
      {
        if (distUp <= distLeft)//if up closer than left
        {
          //left = false
          direction[1] = false;
          if (direction[2])//if down
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
        if(temp.y < target.y){
          temp.x += 1;
          temp.y += 1;
        }else if(temp.y > target.y){
          temp.x += 1;
          temp.y -= 1;
        }else{
          temp.x += 1;
        }
      } else if (temp.x > target.x) {
        if(temp.y < target.y){
          temp.x -= 1;
          temp.y += 1;
        }else if(temp.y > target.y){
          temp.x -= 1;
          temp.y -= 1;
        }else{
          temp.x -=1;
        }
      } else {
        if(temp.y < target.y){
          temp.y += 1;
        }else{//double check maybe an else if
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
}//end Ghost class()