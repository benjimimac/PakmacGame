class Ghost extends GameObject {  //<>//
  //Fields
  PShape[] sprites; //sprites will be stored in arrays to of size 4 - inedex 0 = up, 1 = left, 2 = down, 3 = right
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
  PVector startNextTile;
  int nextTileCol;
  int nextTileRow;
  PVector lastTile;
  PVector homeTile;
  int time;
  boolean ghostArea;
  boolean ready;
  boolean startGhostArea;
  boolean startReady;
  float startSpeed;
  PVector[] restrictedTiles;
  boolean eaten;
  boolean scared;


  Ghost(float x, float y, float objectWidth, float objectHeight, color colour, PVector homeTile, float theta, boolean ghostArea, float speed, boolean ready, int nextTileRow, int nextTileCol) {
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
    startSpeed = speed;

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

    currentTile = new PVector(startTileCol, startTileRow);
    lastTile = new PVector(11, 15);
    this.startNextTile = new PVector(nextTileRow, nextTileCol);
    this.nextTileCol = nextTileCol;
    this.nextTileRow = nextTileRow;
    this.nextTile = startNextTile.copy();
    this.homeTile = homeTile;
    time = 0;
    this.theta = theta;
    this.ghostArea =  ghostArea;
    this.ready = ready;
    this.startGhostArea = ghostArea;
    this.startReady = ready;

    //Ghosts cannot turn up into a restricted tile
    restrictedTiles = new PVector[4];
    restrictedTiles[0] = new PVector(11, 12);
    restrictedTiles[1] = new PVector(11, 15);
    restrictedTiles[2] = new PVector(23, 12);
    restrictedTiles[3] = new PVector(23, 15);
  }//end Ghost construuctor methods

  void render() {
    //super.render();
    pushMatrix();
    translate(pos.x, pos.y);
    if (eaten) {
      shape(eatenSprite[i]);
    } else if (!scared) {
      shape(sprites[i]);
    } else {    
      shape(frightenedSprite);
    }
    popMatrix();
  }

  void update() {
    if (ghostArea && pos.dist(outside) <= 10) {
      ghostArea = false;
      nextTile = newNextTile.copy();
      i = 1;
      theta = PI;
      speed = 2.0f;
    }
    if (!ghostArea) {
      super.update();
      getDirections();
      if (currentTile.dist(ghostAreaRespawn) == 0) {

        for (int i = 0; i < direction.length; i++) {
          direction[i] = false;
        }
        direction[0] = true;
        pos = centre.copy();
        theta = PI + HALF_PI;
        i = 0;
        ghostArea = true;
        ready = true;
        eaten = false;
        scared = false;
        nextTile = newNextTile.copy();
      }

      if (direction[0]) {
        if (get((int) pos.x, (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y - (tileSize + 5)) != maze.getWallColour()/*maze.path.getPathNext(xReference, yReference - 1) == 1*/) {
          this.i = 0;

          theta = PI + HALF_PI;
        }
      } else if (direction[1]) {
        if (get((int) pos.x - (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour() && get((int) pos.x - (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour()) {
          this.i = 1;

          theta = PI;
        }
      } else if (direction[2]) {
        if (!eaten) {
          if (get((int) pos.x, (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour()  &&  get((int) pos.x, (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != BROWN) {
            this.i = 2;

            theta = HALF_PI;
          }
        } else {
          if ((get((int) pos.x, (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour() && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) != maze.getWallColour()) || get((int) pos.x, (int) pos.y + (tileSize + 5)) == BROWN && get((int) pos.x - (tileSize - 3), (int) pos.y + (tileSize + 5)) == BROWN && get((int) pos.x + (tileSize - 3), (int) pos.y + (tileSize + 5)) == BROWN) {
            this.i = 2;

            theta = HALF_PI;
          }
        }
      } else if (direction[3]) {
        if (get((int) pos.x + (tileSize + 5), (int) pos.y) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y + (tileSize - 3)) != maze.getWallColour() && get((int) pos.x + (tileSize + 5), (int) pos.y - (tileSize - 3)) != maze.getWallColour()) {
          this.i = 3;

          theta = radians(0.0f);
        }
      }
    } else {
      forward.x =  cos(theta);
      forward.y = sin(theta);
      if (ready) {
        if (pos.dist(centre) <= 2) {
          for (int index = 0; index < direction.length; index++) {
            direction[index] = false;
          }

          direction[0] = true;
          this.i = 0;
          theta = PI + HALF_PI;
        } 
        if (pos.dist(leftCentre) == 0) {
          this.i = 3;
          theta = 0;
        }

        if (get((int) pos.x, (int) pos.y - (tileSize + 5)) == maze.getWallColour()) {
          this.i = 2;
          theta = HALF_PI;
        }
        // }

        //if (theta == HALF_PI) {
        if (get((int) pos.x, (int) pos.y + (tileSize + 5)) == maze.getWallColour()) {
          this.i = 0;
          theta = PI + HALF_PI;
        }

        if (pos.dist(rightCentre) == 0) {
          this.i = 1;
          theta = PI;
        }
      } else {
        if (get((int) pos.x, (int) pos.y - (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y - (tileSize + 5)) == maze.getWallColour()) {
          this.i = 2;
          theta = HALF_PI;
        }
        if (get((int) pos.x, (int) pos.y + (tileSize + 5)) == BROWN || get((int) pos.x, (int) pos.y + (tileSize + 5)) == maze.getWallColour()) {
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
  }//end update()

  public void getDirections() {
    currentTile = getLocation().copy();
    if (currentTile.dist(nextTile) == 0) {
      lastTile = currentTile.copy();

      //Set direction array all to false
      for (int i = 0; i < direction.length; i++) {
        direction[i] = false;
      }//end for(i)

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
      } else {//if eaten the ghost can go through the brown ghost door
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
    }
  }//end getDirections

  public void pickOneDirection() {
    if (!eaten) {     
      if (checkCurrentTile(restrictedTiles[0]) || checkCurrentTile(restrictedTiles[1]) || checkCurrentTile(restrictedTiles[2]) || checkCurrentTile(restrictedTiles[3]))
      {
        direction[0] = false;
      }
    }

    //Call the get distance method to check how far away the target is in each direction
    int distUp = getDistance(-1, 0);
    int distLeft = getDistance(0, -1);
    int distDown = getDistance(1, 0);
    int distRight = getDistance(0, 1);

    //every direction and distance must be checked and compared
    //and systematicall ruled out

    //if up is a valid option - check it against every other distance and direction
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
    } else if (direction[1]) { //else if left is a valid option - check it against the remaining two directions and distances
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
    } else if (direction[2]) { //else ifdown is a valid option check it against right direction and distance
      if (direction[3]) {
        if (distDown <= distRight) {
          direction[3] = false;
        } else {
          direction[2] = false;
        }
      }
    }//if none of up, down, or left are valid then right is an automatic choice
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
    nextTile = lastTile.copy();
  }

  void resetGhost() {
    pos = startPos.copy();
    nextTile = startNextTile.copy();
    this.theta = startTheta;
    this.i = startI + 0;
    direction[i] = true;
    this.ghostArea = startGhostArea;
    this.ready = startReady;
    eaten = false;
    for (int index = 0; index < direction.length; index++) {
      direction[index] = false;
    }
    direction[i] = true;
    speed = startSpeed;
  }
}//end Ghost class()