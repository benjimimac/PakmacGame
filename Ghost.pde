class Ghost extends GameObject implements Reset, Points { //<>// //<>// //<>// //<>//

  Movement movement;

  float startTheta;
  PShape[] eatenSprite;
  PShape[] frightenedSprite;
  PVector homeTile;
  boolean ready;
  boolean[] directions;

  PVector currentTile;
  PVector lastTile;
  PVector nextTile;
  PVector startTile;
  PVector startNextTile;
  PVector targetTile;

  boolean forceTurn;


  boolean frightened;

  int frightenedTimer;

  float otherSpeed;
  float normalSpeed;

  final static int GHOST_POINTS = 200;

  Ghost(float x, float y, float objectWidth, float objectHeight, color colour, PVector homeTile, int spriteDirection, boolean ghostArea, float speed, boolean ready, int nextTileRow, int nextTileCol) {
    super(x, y, objectWidth, objectWidth, colour/*, theta*/);
    
    movement = new ScatterMovement(this);
    
    currentTile = new PVector(15, 15);

    startTheta = theta;
    movingSprite1 = new PShape[4];
    movingSprite2 = new PShape[4];
    eatenSprite = new PShape[4];
    this.ghostArea = ghostArea;
    startGhostArea = ghostArea;
    normalSpeed = 3.0f;
    otherSpeed = 2.0f;
    //if (ready) {
    this.speed = normalSpeed;
    //} else {
    //  this.speed = otherSpeed;
    //}
    this.ready = ready;

    amount = 0;

    //spriteDirection = (int) map(theta, PI + HALF_PI, 0, 3, 0);
    this.spriteDirection = spriteDirection;
    startSpriteDirection = spriteDirection;

    eaten = false;
    frightened = false;

    forceTurn = false;

    //println(dataPath("hello.txt"));

    startTile = getLocation();
    startNextTile = new PVector(nextTileRow, nextTileCol);
    nextTile = startNextTile.copy();
    lastTile = new PVector(11, 15);
    this.homeTile = homeTile;

    fill(0);
    stroke(0);
    PShape foot1= createShape(TRIANGLE, 0 - objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 - (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
    PShape foot2= createShape(TRIANGLE, 0 + objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 + (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
    PShape foot3 = createShape(TRIANGLE, -objectHeight, objectHeight, -objectHeight * 0.5f, objectHeight, -objectHeight * 0.75f, objectHeight * 0.5f);
    PShape foot4 = createShape(RECT, -2.5f, objectHeight - 5, 5, 5);
    PShape foot5 = createShape(TRIANGLE, objectHeight, objectHeight, objectHeight * 0.5f, objectHeight, objectHeight * 0.75f, objectHeight * 0.5f);

    directions = new boolean[4];

    for (int i = movingSprite1.length - 1; i >= 0; i--) {
      fill(colour);
      stroke(colour);
      movingSprite1[i] = createShape(GROUP);
      movingSprite2[i] = createShape(GROUP);
      eatenSprite[i] = createShape(GROUP);

      // create the different body shapes and add them to the GROUP shape
      PShape head = createShape(ARC, 0, 0, objectWidth, objectWidth, PI, TWO_PI, PIE);
      movingSprite1[i].addChild(head);
      movingSprite2[i].addChild(head);

      PShape body = createShape(RECT, 0 - objectHeight, 0, objectWidth, objectHeight);
      movingSprite1[i].addChild(body);
      movingSprite2[i].addChild(body);



      movingSprite1[i].addChild(foot1);      
      movingSprite1[i].addChild(foot2);      
      movingSprite2[i].addChild(foot3);      
      movingSprite2[i].addChild(foot4);      
      movingSprite2[i].addChild(foot5);

      // Create the eyes
      fill(255);
      stroke(255);

      PShape eye1 = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f), objectHeight * 0.5f, objectHeight * 0.615384f);
      movingSprite1[i].addChild(eye1);
      movingSprite2[i].addChild(eye1);
      eatenSprite[i].addChild(eye1);
      PShape eye2 = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f), objectHeight * 0.5f, objectHeight * 0.615384f);
      movingSprite1[i].addChild(eye2);
      movingSprite2[i].addChild(eye2);
      eatenSprite[i].addChild(eye2);
    }

    fill(0);
    stroke(0);

    PShape pupil1Up = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) - 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape pupil2Up = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) - 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    movingSprite1[3].addChild(pupil1Up);
    movingSprite2[3].addChild(pupil1Up);
    movingSprite1[3].addChild(pupil2Up);
    movingSprite2[3].addChild(pupil2Up);
    eatenSprite[3].addChild(pupil1Up);
    eatenSprite[3].addChild(pupil2Up);

    PShape  pupil1Left = createShape(ELLIPSE, 0 - (objectHeight * 0.5f) - 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape  pupil2Left = createShape(ELLIPSE, 0 + (objectHeight * 0.5f) - 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    movingSprite1[2].addChild(pupil1Left);
    movingSprite2[2].addChild(pupil1Left);
    movingSprite1[2].addChild(pupil2Left);
    movingSprite2[2].addChild(pupil2Left);
    eatenSprite[2].addChild(pupil1Left);
    eatenSprite[2].addChild(pupil2Left);

    PShape pupil1Down = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) + 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape pupil2Down = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) + 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    movingSprite1[1].addChild(pupil1Down);
    movingSprite2[1].addChild(pupil1Down);
    movingSprite1[1].addChild(pupil2Down);
    movingSprite2[1].addChild(pupil2Down);
    eatenSprite[1].addChild(pupil1Down);
    eatenSprite[1].addChild(pupil2Down);

    PShape pupil1Right = createShape(ELLIPSE, 0 - (objectHeight * 0.5f) + 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape pupil2Right = createShape(ELLIPSE, 0 + (objectHeight * 0.5f) + 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    movingSprite1[0].addChild(pupil1Right);
    movingSprite2[0].addChild(pupil1Right);
    movingSprite1[0].addChild(pupil2Right);
    movingSprite2[0].addChild(pupil2Right);
    eatenSprite[0].addChild(pupil1Right);
    eatenSprite[0].addChild(pupil2Right);

    frightenedSprite = new PShape[2];
    for (int i = 0; i < frightenedSprite.length; i++) {
      fill(0, 0, 245);
      stroke(0, 0, 245);
      frightenedSprite[i] = createShape(GROUP);
      PShape head = createShape(ARC, 0, 0, objectWidth, objectWidth, PI, TWO_PI, PIE);
      frightenedSprite[i].addChild(head);
      PShape body = createShape(RECT, 0 - objectHeight, 0, objectWidth, objectHeight);
      frightenedSprite[i].addChild(body);
      fill(255);
      stroke(255);
      PShape eye1 = createShape(ELLIPSE, 0 - (objectHeight * 0.3f), 0 - (objectHeight * 0.25f), objectHeight * 0.3f, objectHeight * 0.3f);
      frightenedSprite[i].addChild(eye1);
      PShape eye2 = createShape(ELLIPSE, 0 + (objectHeight * 0.3f), 0 - (objectHeight * 0.25f), objectHeight * 0.3f, objectHeight * 0.3f);
      frightenedSprite[i].addChild(eye2);
      PShape mouth1 = createShape(LINE, 0 - (objectHeight * 0.8f), 0 + (objectHeight * 0.45f), 0 - (objectHeight * 0.5f), 0 + (objectHeight * 0.35f));
      // 0 + (objectHeight * 0.8f), 0 + (objectHeight * 0.45f));
      frightenedSprite[i].addChild(mouth1);
      PShape mouth2 = createShape(LINE, 0 - (objectHeight * 0.5f), 0 + (objectHeight * 0.35f), 0, 0 + (objectHeight * 0.45f));
      frightenedSprite[i].addChild(mouth2);
      PShape mouth3 = createShape(LINE, 0, 0 + (objectHeight * 0.45f), 0 + (objectHeight * 0.5f), 0 + (objectHeight * 0.35f));
      frightenedSprite[i].addChild(mouth3);
      PShape mouth4 = createShape(LINE, 0 + (objectHeight * 0.8f), 0 + (objectHeight * 0.45f), 0 + (objectHeight * 0.5f), 0 + (objectHeight * 0.35f));
      frightenedSprite[i].addChild(mouth4);
    }

    fill(0);
    stroke(0);

    //PShape foot1= createShape(TRIANGLE, 0 - objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 - (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
    frightenedSprite[0].addChild(foot1);
    //PShape foot2= createShape(TRIANGLE, 0 + objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 + (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
    frightenedSprite[0].addChild(foot2);

    //PShape foot3 = createShape(TRIANGLE, -objectHeight, objectHeight, -objectHeight * 0.5f, objectHeight, -objectHeight * 0.75f, objectHeight * 0.5f);
    frightenedSprite[1].addChild(foot3);
    //PShape foot4 = createShape(RECT, -2.5f, objectHeight - 5, 5, 5);
    frightenedSprite[1].addChild(foot4);
    //PShape foot5 = createShape(TRIANGLE, objectHeight, objectHeight, objectHeight * 0.5f, objectHeight, objectHeight * 0.75f, objectHeight * 0.5f);
    frightenedSprite[1].addChild(foot5);
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    if (frightened) {
      if (frightenedTimer < Timer.FRIGHTENED_LIMIT - (120)) {
        if (frameCount % 20 < 10) {
          shape(frightenedSprite[0]);
        } else {
          shape(frightenedSprite[1]);
        }
      } else if (frightenedTimer < Timer.FRIGHTENED_LIMIT) {
        if (frameCount % 20 < 10) {
          shape(frightenedSprite[0]);
        } else {
          shape(movingSprite2[spriteDirection]);
        }
      } else {
        frightened = false;
      }

      frightenedTimer++;
    } else if (eaten) {
      shape(eatenSprite[spriteDirection]);
    } else {
      if (frameCount % 20 < 10) {
        shape(movingSprite2[spriteDirection]);
      } else {
        shape(movingSprite1[spriteDirection]);
      }
    }
    popMatrix();
  }

  void update() {

    super.update();
movement.update();
   /* if (!ghostArea) {
      //if((map.path[(int) tempLocation.x][(int) tempLocation.y] == 2) && pos.x % tileWidth == tileWidth * 0.5f && pos.y % tileWidth == tileWidth * 0.5f) {
      //  speed = otherSpeed;
      //} 
      //if(map.path[(int) tempLocation.x][(int) tempLocation.y] == 1 && pos.x % tileWidth == tileWidth * 0.5f && pos.y % tileWidth == tileWidth * 0.5f) {
      //  speed = normalSpeed;
      //}
      //println(pos + " - " + tempLocation);

      if (pos.x % tileWidth == tileWidth * 0.5f && pos.y % tileWidth == tileWidth * 0.5f) {
        setDirections();
      } else if (pos.x % tileWidth == 0 && pos.y % tileWidth == tileWidth * 0.5f && getLocation().equals(new PVector(11, (int) map.path[0].length * 0.5f)) && eaten) {
        enterGhostArea();
      }
    }*/
    //} else if (!ready && eaten) {

    //  if (getLocation().equals(new PVector(14, 14)) && pos.x % tileWidth == 0 && pos.y % tileWidth == tileWidth * 0.5f) {
    //    println("Not ready and eaten - in ghost house");
    //    spriteDirection = 3;
    //    ready = true;
    //    eaten = false;
    //    ghostArea = true;
    //  }
    //  //if(pos.x == ) {

    //  //}
    //} else if (ready && !eaten && getLocation().equals(new PVector(11, 14)) && pos.y % tileWidth == tileWidth * 0.5f) {
    //  println("Ready to go again - get me out of here");
    //  ghostArea = false;
    //  setDirections();
    //} else if (!ready && ghostArea) {
    //  //println("I'm not fucking ready so I'll just float about here");
    //  currentTile = getLocation();
    //  if ((map.checkPath((int) currentTile.x - 1, (int) currentTile.y) != 4 && spriteDirection == 3) || (map.checkPath((int) currentTile.x + 1, (int) currentTile.y) != 4 && spriteDirection == 1)) {

    //    forceTurn = true;
    //    setDirections();
    //  } else {
    //    //println("Oh yes it is " + currentTile);
    //  }
    //} else if (ready && ghostArea) {


    //  if (((map.checkPath((int) currentTile.x + 1, (int) currentTile.y) != 4 && spriteDirection == 1) || (map.checkPath((int) currentTile.x - 1, (int) currentTile.y) != 4 && spriteDirection == 3)) && (pos.x % tileWidth == 0)) {
    //    //println("I'm Inky and I'm fucking ready" + getLocation() + ", " + (pos.y % tileWidth) + " - " + pos + " - " + blinky.speed);
    //    forceTurn = true;
    //    setDirections();
    //    println("I'm Inky and I'm fucking ready" + inky.getLocation() + ", " + (inky.pos.y % tileWidth) + " - " + inky.pos + " - " + inky.speed + " inky.ready(" + inky.ready + ") inky.ghostArea(" + inky.ghostArea + ")");
    //  }
    //}
    //println(inky.pos.y % tileWidth + " - " + inky.speed + " - (" + x + ", " + y + ")");
  }

  void setDirections() {
    if (forceTurn) {
      forceTurn();
    } else {

      PVector tempLocation = getLocation();

      if (!frightened && map.path[(int) tempLocation.x][(int) tempLocation.y] == 1) {
        speed = normalSpeed;
      } else if (!frightened && map.path[(int) tempLocation.x][(int) tempLocation.y] == 2) {
        speed = otherSpeed;
      }

      //By default all directions should be false
      for (int i = 0; i < directions.length; i++) {
        directions[i] = false;
      }

      //PVector tempLocation = getLocation();

      // Check the 2d path array in the Map object - each tile above, below, left, and right
      //above
      PVector aboveLocation = getLocation();
      if (aboveLocation.x == 0) {
        aboveLocation.add(30, 0);
      } else {
        aboveLocation.add(-1, 0);
      }

      if (map.path[(int) aboveLocation.x][(int) aboveLocation.y] == 1 && spriteDirection != 1) {
        directions[3] = true;
      }

      //left
      PVector leftLocation = getLocation();
      if (leftLocation.y == 0) {
        leftLocation.add(0, 27);
      } else {
        leftLocation.add(0, -1);
      }
      if ((map.path[(int) leftLocation.x][(int) leftLocation.y] == 1 || map.path[(int) leftLocation.x][(int) leftLocation.y] == 2) && spriteDirection != 0) {
        directions[2] = true;
      }

      //down
      PVector belowLocation = getLocation();
      if (belowLocation.x == 30) {
        belowLocation.add(0, -30);
      } else {
        belowLocation.add(1, 0);
      }

      if (map.path[(int) belowLocation.x][(int) belowLocation.y] == 1 && spriteDirection != 3) {
        directions[1] = true;
      }
      //if (!eaten) {
      //  if (map.path[(int) belowLocation.x][(int) belowLocation.y] == 1 && spriteDirection != 3) {
      //    directions[1] = true;
      //  }
      //} else {
      //  if (map.path[(int) belowLocation.x][(int) belowLocation.y] == 1 && spriteDirection != 3 || map.path[(int) belowLocation.x][(int) belowLocation.y] == 3 && spriteDirection != 3 ) {
      //    directions[1] = true;
      //  }
      //}

      //right
      PVector rightLocation = getLocation();
      if (rightLocation.y == 27) {
        rightLocation.add(0, -27);
      } else {
        rightLocation.add(0, 1);
      }
      if ((map.path[(int) rightLocation.x][(int) rightLocation.y] == 1 || map.path[(int) rightLocation.x][(int) rightLocation.y] == 2) && spriteDirection != 2) {
        directions[0] = true;
      }
      //println(directions[3] + "(" + getDistance(-1, 0) + ") - " + directions[2] + "(" + getDistance(0, -1) + ") - " + directions[1] + "(" + getDistance(1, 0) + ") - " + directions[0] + "(" + getDistance(0, 1) + ") - " + targetTile);
      pickOneDirection();
    }


    //println(directions[3], directions[2], directions[1], directions[0], spriteDirection, degrees(theta));
  }

  /*
  void update() {
   if (!ghostArea) {
   super.update();
   setDirections();
   
   if (directions[0] && pos.x % tileWidth == 12) {
   spriteDirection = 0;
   theta = PI + HALF_PI;
   } else if (directions[1] && pos.y % tileWidth == 12) {
   spriteDirection = 1;
   theta = PI;
   } else if (directions[2] && pos.x % tileWidth == 12) {
   spriteDirection = 2;
   theta = HALF_PI;
   } else if (directions[3] && pos.y % tileWidth == 12) {
   spriteDirection = 3;
   theta = 0;
   }
   }
   }
   */

  /*
  void setDirections() {
   
   currentTile = getLocation();
   
   if (currentTile.dist(nextTile) == 0) {
   println("inside");
   if (forceTurn) {
   forceTurn();
   } else {
   lastTile = currentTile.copy();
   
   
   // Set all elements of the directions array to be false
   for (int i = 0; i < directions.length; i++) {
   directions[i] = false;
   }
   
   // Check the 2d path array in the Map object - each tile above, below, left, and right
   //above
   if (map.checkPath((int) currentTile.x - 1, (int) currentTile.y) == 1 && theta != HALF_PI) {
   directions[0] = true;
   }
   
   //left
   if (map.checkPath((int) currentTile.x, (int) currentTile.y - 1) == 1 && theta != 0) {
   directions[1] = true;
   }
   
   //down
   if (!eaten) {
   if (map.checkPath((int) currentTile.x + 1, (int) currentTile.y) == 1 && theta != PI + HALF_PI) {
   directions[2] = true;
   }
   } else {
   if (map.checkPath((int) currentTile.x + 1, (int) currentTile.y) == 1 && theta != PI + HALF_PI || map.checkPath((int) currentTile.x + 1, (int) currentTile.y) == 5 && theta != PI + HALF_PI) {
   directions[2] = true;
   }
   }
   
   //right
   if (map.checkPath((int) currentTile.x, (int) currentTile.y + 1) == 1 && theta != PI) {
   directions[3] = true;
   }
   
   pickOneDirection();
   
   if (directions[0]) {
   
   nextTile.add(-1, 0);
   } else if (directions[1]) {
   
   nextTile.add(0, -1);
   } else if (directions[2]) {
   
   nextTile.add(1, 0);
   } else {
   
   nextTile.add(0, 1);
   }
   }
   } else {
   //println("outside : currentTile - " + currentTile + " nextTile - " + nextTile); 
   }
   
   // Make sure the nextTile is still on the grid
   checkNextTileRange();
   }
   */

  void pickOneDirection() {

    if (!eaten && checkCurrentTile()) {
      directions[3] = false;
    }

    int distance = 0;
    //distance[0] = getDistance(-1, 0);
    //distance[1] = getDistance(0, -1);
    //distance[2] = getDistance(1, 0);
    //distance[3] = getDistance(0, 1);
    //println("At (" + currentTile.x + ", " + currentTile.y + ") we have - " + directions[0], distance[0], directions[1], distance[1], directions[2], distance[2], directions[3], distance[3] +  "target is (" + targetTile.x + ", " + targetTile.y + ")");    
    int index = directions.length - 1;
    int tempDistance = Integer.MAX_VALUE;

    for (int i = directions.length - 1; i >= 0; i--) {

      if (directions[i]) {

        switch (i) {
        case 3:
          distance = getDistance(-1, 0);
          break;

        case 2:
          distance = getDistance(0, -1);
          //println("left is true" + distance[2]);
          break;

        case 1:
          distance = getDistance(1, 0);
          break;

        case 0:
          distance = getDistance(0, 1);
          //println("right is true" + distance[0]);
          break;
        }

        if (distance < tempDistance) {
          tempDistance = distance;
          index = i;
        }
      }
    }
    //println(getLocation() + " - " + directions[3] + "(" + distance[3] + ") " + directions[2] + "(" + distance[2] + ") " + directions[1] + "(" + distance[1] + ") " + directions[0] + "(" + distance[0] + ") " + targetTile);
    //println(directions[0] + " (" + distance[0] + ")");
    //println("up " + distance[3] + ", left " + distance[2] + ", down " + distance[1] + ", right " + distance[0]);

    //for (int i = 0; i < directions.length; i++) {
    //  if (directions[i]) {
    //    if (distance[i] < tempDistance) {
    //      tempDistance = distance[i];
    //      index = i;
    //    }
    //  }
    //}
    for (int i = 0; i < directions.length; i++) {
      if (i != index) {
        directions[i] = false;
      }
    }

    spriteDirection = index;

    /*
    int distUp = getDistance(-1, 0);
     int distLeft = getDistance(0, -1);
     int distDown = getDistance(1, 0);
     int distRight = getDistance(0, 1);
     
     if (directions[0]) {
     if (directions[1]) {
     if (distUp <= distLeft) {
     directions[1] = false;
     if (directions[2]) {
     if (distUp <= distDown) {
     directions[2] = false;
     if (directions[3]) {
     if (distUp <= distRight) {
     directions[3] = false;
     } else {
     directions[0] = false;
     }
     }
     } else {
     directions[0] = false;
     if (directions[3]) {
     if (distDown <= distRight) {
     directions[3] = false;
     } else {
     directions[2] = false;
     }
     }
     }
     } else if (directions[3]) {
     if (distUp <= distRight) {
     directions[3] = false;
     } else {
     directions[0] = false;
     }
     }
     } else {
     directions[0] = false;
     if (directions[2]) {
     if (distLeft <= distDown) {
     directions[2] = false;
     if (directions[3]) {
     if (distLeft <= distRight) {
     directions[3] = false;
     } else {
     directions[1] = false;
     }
     }
     } else {
     directions[1] = false;
     }
     } else if (directions[3]) {
     if (distLeft <= distRight) {
     directions[3] = false;
     } else {
     directions[1] = false;
     }
     }
     }
     } else if (directions[2]) {
     if (distUp <= distDown) {
     directions[2] = false;
     if (directions[3]) {
     if (distUp <= distRight) {
     directions[3] = false;
     } else {
     directions[0] = false;
     }
     }
     } else {
     directions[0] = false;
     if (directions[3]) {
     if (distDown <= distRight) {
     directions[3] = false;
     } else {
     directions[2] = false;
     }
     }
     }
     } else if (directions[3]) {
     if (distUp <= distRight) {
     directions[3] = false;
     } else {
     directions[0] = false;
     }
     }
     } else if (directions[1]) { //else if left is a valid option - check it against the remaining two directions and distances
     if (directions[2]) {
     if (distLeft <= distDown) {
     directions[2] = false; 
     if (directions[3]) {
     if (distLeft <= distRight) {
     directions[3] = false;
     } else {
     directions[1] = false;
     }
     }
     } else {
     directions[1] = false;
     if (directions[3]) {
     if (distDown <= distRight) {
     directions[3] = false;
     } else {
     directions[2] = false;
     }
     }
     }
     } else if (directions[3]) {
     if (distLeft <= distRight) {
     directions[3] = false;
     } else {
     directions[1] = false;
     }
     }
     } else if (directions[2]) { //else if down is a valid option check it against right direction and distance
     if (directions[3]) {
     if (distDown <= distRight) {
     directions[3] = false;
     } else {
     directions[2] = false;
     }
     }
     }//if none of up, down, or left are valid then right is an automatic choice
     */
  }

  boolean checkCurrentTile() {

    PVector tempLocation = getLocation();

    for (int i = 0; i < restrictedTiles.length; i++) {
      if (restrictedTiles[i].equals(tempLocation)) {
        return true;
      }
    }
    return false;
  }

  int getDistance(int rowAdd, int colAdd) {
    int count = 0;
    PVector temp = getLocation();
    temp.add(rowAdd, colAdd);

    while (temp.dist(targetTile) != 0) {

      if (temp.x < targetTile.x) {
        if (temp.y < targetTile.y) {
          temp.add(1, 1);
        } else if (temp.y > targetTile.y) {
          temp.add(1, -1);
        } else {
          temp.add(1, 0);
        }
      } else if (temp.x > targetTile.x) {
        if (temp.y < targetTile.y) {
          temp.add(-1, 1);
        } else if (temp.y > targetTile.y) {
          temp.add(-1, -1);
        } else {
          temp.add(-1, 0);
        }
      } else {
        if (temp.y < targetTile.y) {
          temp.add(0, 1);
        } else {
          temp.add(0, -1);
        }
      }

      count++;
    }

    return count;
  }

  void checkNextTileRange() {
    if (nextTile.x < 0) {
      nextTile.add(31, 0);
    }

    if (nextTile.x > 30) {
      nextTile.add(-31, 0);
    }

    if (nextTile.y < 0) {
      nextTile.add(0, 28);
    }

    if (nextTile.y > 27) {
      nextTile.add(0, -28);
    }
  }

  void forceTurn() {
    //println("Inside forceTurn");
    //nextTile = currentTile.copy();
    if (frightened) {
      speed = otherSpeed;
    } else {
      speed = normalSpeed;
    }
    //PVector temp = nextTile.copy();
    //nextTile = lastTile.copy();
    //lastTile = temp;

    //switch (spriteDirection) {
    //case 0:
    //  spriteDirection = 2;
    //  //theta = HALF_PI;
    //  //nextTile.add(1, 0);
    //  break;

    //case 1:
    //  spriteDirection = 3;
    //  //theta = 0;
    //  //nextTile.add(0, 1);
    //  break;

    //case 2:
    //  spriteDirection = 0;
    //  //theta = PI + HALF_PI;
    //  //nextTile.add(-1, 0);
    //  break;

    //case 3:
    //  spriteDirection = 1;
    //  //theta = PI;
    //  //nextTile.add(0, -1);
    //  break;
    //}

    spriteDirection = (spriteDirection + 2) % 4;

    forceTurn = false;
    //lastTile = currentTile.copy();

    for (int i = 0; i < directions.length; i++) {
      directions[i] = false;
    }
  }

  boolean inTunnel() {

    int row = (int) map(pos.y, tileWidth * 2, (tileWidth * 2) + (tileWidth * 31), 0, 31);
    int col = (int) map(pos.x, 0, width, 0, 28);
    int colLeft = (int) map(pos.x - 1, 0, width, 0, 28);
    if (col > 27) {
      col = 0;
    }

    if (col < 0) {
      col = 27;
    }

    if (colLeft > 27) {
      colLeft = 0;
    }

    if (colLeft < 0) {
      colLeft = 27;
    }

    if (row > 30) {
      row = 0;
    }

    if (row < 0) {
      row = 30;
    }

    //if((spriteDirection == 0 && map.path[row][col] == 2) || (spriteDirection == 2 && map.path[row][colLeft] == 2)) {
    if (map.path[row][col] == 2) {
      return true;
    }


    return false;
  }

  void eaten() {
    println("I've just been eaten");
    frightened = false;
    ready = false;
    eaten = true;
  }

  void enterGhostArea() {
    println("At the door");
    for (int i = 0; i < directions.length; i++) {
      directions[i] = false;
    }

    directions[1] = true;
    spriteDirection = 1;
    ghostArea = true;
  }

  public void resetPositions() {
    pos = new PVector(x, y);
    spriteDirection = startSpriteDirection;
    ghostArea = startGhostArea;
    eaten = false;
  }

  public void applyTo(Pakmac pakmac) {
    int tempAmount = GHOST_POINTS;

    for (int i = 0; i < amount; i++) {
      tempAmount *= 2;
    }

    GhostScore ghostScore = new GhostScore(pos.x, pos.y, tempAmount);

    gameObjects.add(ghostScore);

    pakmac.score += tempAmount;
    amount++;
    println(tempAmount + " - " + amount);
  }
}