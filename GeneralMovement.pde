class GeneralMovement implements Movement {

  Ghost ghost;

  GeneralMovement(Ghost ghost) {
    this.ghost = ghost;
  }

  public void update() {

    if (ghost.pos.x % tileWidth == tileWidth * 0.5f && ghost.pos.y % tileWidth == tileWidth * 0.5f) {
      //ghost.setDirections();
      setDirections();
    } else if (ghost.pos.x % tileWidth == 0 && ghost.pos.y % tileWidth == tileWidth * 0.5f && ghost.getLocation().equals(new PVector(11, (int) map.path[0].length * 0.5f)) && ghost.eaten) {
      ghost.enterGhostArea();
    } else if (ghost.pos.equals(new PVector(pinky.x, pinky.y))) {
      ghost.ghostArea = true;
      ghost.ready = true;
      ghost.getMovementBehaviour();
      ghost.eaten = false;
      println("Tests out ok");
    }
  }

  void setDirections() {
    if (ghost.forceTurn) {
      ghost.forceTurn();
    } else {

      PVector tempLocation = ghost.getLocation();

      if (!ghost.frightened && map.path[(int) tempLocation.x][(int) tempLocation.y] == 1) {
        ghost.speed = ghost.normalSpeed;
      } else if (!ghost.frightened && map.path[(int) tempLocation.x][(int) tempLocation.y] == 2) {
        ghost.speed = ghost.otherSpeed;
      }

      //By default all directions should be false
      for (int i = 0; i < ghost.directions.length; i++) {
        ghost.directions[i] = false;
      }

      //PVector tempLocation = getLocation();

      // Check the 2d path array in the Map object - each tile above, below, left, and right
      //above
      PVector aboveLocation = ghost.getLocation();
      if (aboveLocation.x == 0) {
        aboveLocation.add(30, 0);
      } else {
        aboveLocation.add(-1, 0);
      }

      if (map.path[(int) aboveLocation.x][(int) aboveLocation.y] == 1 && ghost.spriteDirection != 1) {
        ghost.directions[3] = true;
      }

      //left
      PVector leftLocation = ghost.getLocation();
      if (leftLocation.y == 0) {
        leftLocation.add(0, 27);
      } else {
        leftLocation.add(0, -1);
      }
      if ((map.path[(int) leftLocation.x][(int) leftLocation.y] == 1 || map.path[(int) leftLocation.x][(int) leftLocation.y] == 2) && ghost.spriteDirection != 0) {
        ghost.directions[2] = true;
      }

      //down
      PVector belowLocation = ghost.getLocation();
      if (belowLocation.x == 30) {
        belowLocation.add(0, -30);
      } else {
        belowLocation.add(1, 0);
      }

      if (map.path[(int) belowLocation.x][(int) belowLocation.y] == 1 && ghost.spriteDirection != 3) {
        ghost.directions[1] = true;
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
      PVector rightLocation = ghost.getLocation();
      if (rightLocation.y == 27) {
        rightLocation.add(0, -27);
      } else {
        rightLocation.add(0, 1);
      }
      if ((map.path[(int) rightLocation.x][(int) rightLocation.y] == 1 || map.path[(int) rightLocation.x][(int) rightLocation.y] == 2) && ghost.spriteDirection != 2) {
        ghost.directions[0] = true;
      }
      //println(directions[3] + "(" + getDistance(-1, 0) + ") - " + directions[2] + "(" + getDistance(0, -1) + ") - " + directions[1] + "(" + getDistance(1, 0) + ") - " + directions[0] + "(" + getDistance(0, 1) + ") - " + targetTile);
      pickOneDirection();
    }


    //println(directions[3], directions[2], directions[1], directions[0], spriteDirection, degrees(theta));
  }

  void pickOneDirection() {

    if (!ghost.eaten && ghost.checkCurrentTile()) {
      ghost.directions[3] = false;
    }

    int distance = 0;
    //distance[0] = getDistance(-1, 0);
    //distance[1] = getDistance(0, -1);
    //distance[2] = getDistance(1, 0);
    //distance[3] = getDistance(0, 1);
    //println("At (" + currentTile.x + ", " + currentTile.y + ") we have - " + directions[0], distance[0], directions[1], distance[1], directions[2], distance[2], directions[3], distance[3] +  "target is (" + targetTile.x + ", " + targetTile.y + ")");    
    int index = ghost.directions.length - 1;
    int tempDistance = Integer.MAX_VALUE;

    for (int i = ghost.directions.length - 1; i >= 0; i--) {

      if (ghost.directions[i]) {

        switch (i) {
        case 3:
          distance = ghost.getDistance(-1, 0);
          break;

        case 2:
          distance = ghost.getDistance(0, -1);
          //println("left is true" + distance[2]);
          break;

        case 1:
          distance = ghost.getDistance(1, 0);
          break;

        case 0:
          distance = ghost.getDistance(0, 1);
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
    for (int i = 0; i < ghost.directions.length; i++) {
      if (i != index) {
        ghost.directions[i] = false;
      }
    }

    ghost.spriteDirection = index;

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
}