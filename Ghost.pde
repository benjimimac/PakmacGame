class Ghost extends GameObject { //<>// //<>// //<>//
  float startTheta;
  PShape[] eatenSprite;
  PShape[] frightenedSprite;
  PVector homeTile;
  boolean ghostArea;
  boolean ready;
  boolean[] directions;

  PVector currentTile;
  PVector lastTile;
  PVector nextTile;
  PVector startTile;
  PVector startNextTile;
  PVector targetTile;

  boolean forceTurn;

  boolean eaten;
  boolean frightened;

  int frightenedTimer;

  Ghost(float x, float y, float objectWidth, float objectHeight, color colour, PVector homeTile, int spriteDirection, boolean ghostArea, float speed, boolean ready, int nextTileRow, int nextTileCol) {
    super(x, y, objectWidth, objectWidth, colour/*, theta*/);
    currentTile = new PVector(15, 15);

    startTheta = theta;
    movingSprite1 = new PShape[4];
    movingSprite2 = new PShape[4];
    eatenSprite = new PShape[4];
    this.ghostArea = ghostArea;
    this.speed = speed;
    this.ready = ready;

    //spriteDirection = (int) map(theta, PI + HALF_PI, 0, 3, 0);
    this.spriteDirection = spriteDirection;

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

    for (int i = movingSprite1.length - 1; i >= 0 ; i--) {
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
      if (frightenedTimer < FRIGHTENED_LIMIT - (120)) {
        if (frameCount % 20 < 10) {
          shape(frightenedSprite[0]);
        } else {
          shape(frightenedSprite[1]);
        }
      } else if (frightenedTimer < FRIGHTENED_LIMIT) {
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

    //println(directions[0], directions[1], directions[2], directions[3]);
    //println(map.path[(int) currentTile.x - 1][(int) currentTile.y], map.path[(int) currentTile.x][(int) currentTile.y - 1], map.path[(int) currentTile.x + 1][(int) currentTile.y], map.path[(int) currentTile.x][(int) currentTile.y + 1]);
    //println(currentTile, nextTile, lastTile);
  }

  void update() {

    if (!ghostArea) {
      super.update();
println(directions[0], directions[1], directions[2], directions[3], spriteDirection, degrees(theta));
      if (pos.x % tileWidth == tileWidth * 0.5f && pos.y % tileWidth == tileWidth * 0.5f) {
        setDirections();
      }
    }
  }

  void setDirections() {
    if (forceTurn) {
      forceTurn();
    } else {
      //By default all directions should be false
      for (int i = 0; i < directions.length; i++) {
        directions[i] = false;
      }

      PVector tempLocation = getLocation();

      // Check the 2d path array in the Map object - each tile above, below, left, and right
      //above
      if (map.checkPath((int) tempLocation.x - 1, (int) tempLocation.y) == 1 && spriteDirection != 1) {
        directions[3] = true;
      }

      //left
      if (map.checkPath((int) tempLocation.x, (int) tempLocation.y - 1) == 1 && spriteDirection != 0) {
        directions[2] = true;
      }

      //down
      if (!eaten) {
        if (map.checkPath((int) tempLocation.x + 1, (int) tempLocation.y) == 1 && spriteDirection != 3) {
          directions[1] = true;
        }
      } else {
        if (map.checkPath((int) tempLocation.x + 1, (int) tempLocation.y) == 1 && spriteDirection != 3 || map.checkPath((int) currentTile.x + 1, (int) currentTile.y) == 5 && theta != PI + HALF_PI) {
          directions[1] = true;
        }
      }

      //right
      if (map.checkPath((int) currentTile.x, (int) currentTile.y + 1) == 1 && spriteDirection != 2) {
        directions[0] = true;
      }
    }
    
    pickOneDirection();
    
    println(directions[3], directions[2], directions[1], directions[0], spriteDirection, degrees(theta));
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
   println("outside : currentTile - " + currentTile + " nextTile - " + nextTile); 
   }
   
   // Make sure the nextTile is still on the grid
   checkNextTileRange();
   }
   */

  void pickOneDirection() {

    if (!eaten) {
      if (checkCurrentTile()) {
        directions[0] = false;
      }
    }

    int[] distance = new int[4];
    //distance[0] = getDistance(-1, 0);
    //distance[1] = getDistance(0, -1);
    //distance[2] = getDistance(1, 0);
    //distance[3] = getDistance(0, 1);
    //println("At (" + currentTile.x + ", " + currentTile.y + ") we have - " + directions[0], distance[0], directions[1], distance[1], directions[2], distance[2], directions[3], distance[3] +  "target is (" + targetTile.x + ", " + targetTile.y + ")");    
    int index = directions.length - 1;
    int tempDistance = Integer.MAX_VALUE;

    for (int i = directions.length - 1; i >= 0 ; i--) {

      if (directions[i]) {

        switch (i) {
        case 3:
          distance[i] = getDistance(-1, 0);
          break;

        case 2:
          distance[i] = getDistance(0, -1);
          break;

        case 1:
          distance[i] = getDistance(1, 0);
          break;

        case 0:
          distance[i] = getDistance(0, 1);
          break;
        }

        if (distance[i] < tempDistance) {
          tempDistance = distance[i];
          index = i;
        }
      }
    }

    //for (int i = 0; i < directions.length; i++) {
    //  if (directions[i]) {
    //    if (distance[i] < tempDistance) {
    //      tempDistance = distance[i];
    //      index = i;
    //    }
    //  }
    //}
println("index is " + index);
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
    //nextTile = currentTile.copy();
    PVector temp = nextTile.copy();
    nextTile = lastTile.copy();
    lastTile = temp;

    switch (spriteDirection) {
    case 0:
      spriteDirection = 2;
      theta = HALF_PI;
      //nextTile.add(1, 0);
      break;

    case 1:
      spriteDirection = 3;
      theta = 0;
      //nextTile.add(0, 1);
      break;

    case 2:
      spriteDirection = 0;
      theta = PI + HALF_PI;
      //nextTile.add(-1, 0);
      break;

    case 3:
      spriteDirection = 1;
      theta = PI;
      //nextTile.add(0, -1);
      break;
    }

    forceTurn = false;
    //lastTile = currentTile.copy();

    for (int i = 0; i < directions.length; i++) {
      directions[i] = false;
    }
  }
}