ArrayList<GameObject> gameObjects; //<>//
ArrayList<Ghost> ghosts;
Map map;
Pakmac pakmac;
Ghost blinky;
Ghost pinky;
Ghost inky;
Timer timer;
float tileWidth;

boolean[] keys = new boolean[512];


boolean loaded;
int menuOption;

PVector[] restrictedTiles;

PShape life;

int mode;
long[][] modeChangeTimes;
int modeChangeLevelIndex;
int modeChangePart;
int level;

boolean pausePlay;
boolean reset;

int amount;

//static final int FRIGHTENED_LIMIT = 420;


void setup() {
  size(672, 900);
  surface.setResizable(true);
  fill(0);
  stroke(255);

  tileWidth = 24.0f;

  gameObjects = new ArrayList<GameObject>();
  ghosts = new ArrayList<Ghost>();

  loaded = false;
  menuOption = 1;

  modeChangeTimes = new long[3][7];
  //Set the mode times for level 1
  modeChangeTimes[0][0] = 420;
  modeChangeTimes[0][1] = 1620;
  modeChangeTimes[0][2] = 2040;
  modeChangeTimes[0][3] = 3240;
  modeChangeTimes[0][4] = 3540;
  modeChangeTimes[0][5] = 4740;
  modeChangeTimes[0][6] = 5040;

  //Set the mode times for level 2
  modeChangeTimes[1][0] = 420;
  modeChangeTimes[1][1] = 1200;
  modeChangeTimes[1][2] = 420;
  modeChangeTimes[1][3] = 1200;
  modeChangeTimes[1][4] = 300;
  modeChangeTimes[1][5] = 61980;
  modeChangeTimes[1][6] = 1;

  //Set the mode times for level 2
  modeChangeTimes[2][0] = 300;
  modeChangeTimes[2][1] = 1200;
  modeChangeTimes[2][2] = 300;
  modeChangeTimes[2][3] = 1200;
  modeChangeTimes[2][4] = 300;
  modeChangeTimes[2][5] = 62220;
  modeChangeTimes[2][6] = 1;

  modeChangeLevelIndex = 0;
  modeChangePart = 0;

  mode = 0;
  level = 0;

  pausePlay = false;
  reset = true;

  amount = 0;
}

void draw() {
  background(0);

  stroke(255, 0, 0);
  //Vertical lines
  for (int i = 0; i <= 28; i++) {
    line(i * tileWidth, tileWidth * 2, i * tileWidth, (tileWidth * 2) + (tileWidth * 31));
  }

  //Horizontal lines
  for (int i = 0; i <= 31; i ++) {
    line(0, (tileWidth * 2) + i * tileWidth, width, (tileWidth * 2) + i * tileWidth);
  }


  option();
}

void loadData() {
  noFill();
  PShape shape;
  ArrayList<PShape> allWalls;
  int[][] path = new int[31][28];

  float dotSize = tileWidth * 0.2f;
  color white = color(255, 255, 255);

  allWalls = new ArrayList<PShape>();

  String[] lines = loadStrings("test.csv");
  String[] firstLine = lines[0].split(",");
  color colour = color(Integer.parseInt(firstLine[0]), Integer.parseInt(firstLine[1]), Integer.parseInt(firstLine[2]));

  restrictedTiles = new PVector[firstLine.length - 3];

  for (int i = 3; i < firstLine.length; i++) {
    String[] points = firstLine[i].split("-");
    restrictedTiles[i - 3] = new PVector(Integer.parseInt(points[0]), Integer.parseInt(points[1]));
  }

  strokeWeight(2);

  for (int i = 1; i < lines.length; i++) {
    String[] parts = lines[i].split(",");
    for (int j = 0; j < parts.length; j++) {
      String[] piece = parts[j].split("-");
      int location = Integer.parseInt(piece[0]);
      int type = Integer.parseInt(piece[1]);
      int rotateBy = Integer.parseInt(piece[2]);

      noFill();
      stroke(colour);

      switch (type) {
      case 0:
        float tempW = 0;
        if (rotateBy == 2 || rotateBy == 3) {
          tempW = tileWidth;
        }

        if (rotateBy == 0 || rotateBy == 3) {
          shape = getCorner(tileWidth + (tileWidth * (j - 1)), tempW + (tileWidth * (i - 1)), tileWidth, tileWidth, HALF_PI * rotateBy);
        } else {
          shape = getCorner(tileWidth + (tileWidth * j), tempW + (tileWidth * (i - 1)), tileWidth, tileWidth, HALF_PI * rotateBy);
        }
        //shape(shape);
        allWalls.add(shape);

        path[i - 1][j] = 0;
        break;

      case 1:
        if (rotateBy == 1 || rotateBy == 3) {
          shape = getFlat((tileWidth * j), tileWidth * 0.5f + (tileWidth * (i - 1)), (tileWidth * j) + tileWidth, tileWidth * 0.5f + (tileWidth * (i - 1)));
        } else {
          shape = getFlat((tileWidth * 0.5f) + (tileWidth * j), tileWidth * (i - 1), (tileWidth * 0.5f) + (tileWidth * j), tileWidth + (tileWidth * (i - 1)));
        }
        //shape(shape);
        allWalls.add(shape);
        path[i - 1][j] = 0;
        break;

      case 5:
        Dot dot = new Dot((j * tileWidth) + (tileWidth * 0.5f), tileWidth + (i * tileWidth) + (tileWidth * 0.5f), dotSize, white);
        gameObjects.add(dot);
        path[i - 1][j] = 1;
        break;

      case 6:
        path[i - 1][j] = 1;
        break;

      case 7:
        Powerup powerup = new Powerup((j * tileWidth) + (tileWidth * 0.5f), tileWidth + (i * tileWidth) + (tileWidth * 0.5f), tileWidth * 0.8f, white);
        gameObjects.add(powerup);
        path[i - 1][j] = 1;
        break;

      case 8:
        path[i - 1][j] = 2;
        break;

      case 9:
        path[i - 1][j] = 3;
        break;

      case 4:
        path[i - 1][j] = 4;
        break;

      default:
        break;
      }

      // if location is 0, 2, 3, 4, 5 the wall is an external, or edge piece, it has a second shape
      if (location == 0) {
        switch (type) {
        case 0:
          float tempW = 0;
          if (rotateBy == 2 || rotateBy == 3) {
            tempW = tileWidth;
          }

          if (rotateBy == 0 || rotateBy == 3) {
            shape = getCorner(tileWidth + (tileWidth * (j - 1)), tempW + (tileWidth * (i - 1)), tileWidth * 1.9f, tileWidth * 1.9f, HALF_PI * rotateBy);
          } else {
            shape = getCorner(tileWidth + (tileWidth * j), tempW + (tileWidth * (i - 1)), tileWidth * 1.9f, tileWidth * 1.9f, HALF_PI * rotateBy);
          }
          //shape(shape);
          allWalls.add(shape);
          break;

        case 1:
          switch (rotateBy) {
          case 0:
            shape = getFlat((tileWidth * 0.95f) + (tileWidth * j), tileWidth * (i - 1), (tileWidth * 0.95f) + (tileWidth * j), tileWidth + (tileWidth * (i - 1)));
            allWalls.add(shape);
            break;

          case 1:
            shape = getFlat((tileWidth * j), (tileWidth * 0.95f) + (tileWidth * (i - 1)), (tileWidth * j) + tileWidth, (tileWidth * 0.95f) + (tileWidth * (i - 1)));
            allWalls.add(shape);
            break;

          case 2:
            shape = getFlat((tileWidth * 0.05f) + tileWidth * j, tileWidth * (i - 1), (tileWidth * 0.05f) + tileWidth * j, tileWidth + (tileWidth * (i - 1)));
            allWalls.add(shape);
            break;

          case 3:
            shape = getFlat((tileWidth * j), (tileWidth * 0.05f) + (tileWidth * (i - 1)), (tileWidth * j) + tileWidth, (tileWidth * 0.05f) + (tileWidth * (i - 1)));
            allWalls.add(shape);
            break;

          default:
            break;
          }

          break;

        default:
          break;
        }
      } else if (location != 1) {
        switch (location) {
        case 2:
          shape = getFlat((tileWidth * 0.95f) + (tileWidth * j), tileWidth * (i - 1), (tileWidth * 0.95f) + (tileWidth * j), tileWidth + (tileWidth * (i - 1)));
          allWalls.add(shape);
          break;

        case 3:
          shape = getFlat((tileWidth * j), (tileWidth * 0.95f) + (tileWidth * (i - 1)), (tileWidth * j) + tileWidth, (tileWidth * 0.95f) + (tileWidth * (i - 1)));
          allWalls.add(shape);
          break;

          //case 6:
        case 5:
          shape = getFlat((tileWidth * j), (tileWidth * 0.05f) + (tileWidth * (i - 1)), (tileWidth * j) + tileWidth, (tileWidth * 0.05f) + (tileWidth * (i - 1)));
          allWalls.add(shape);
          break;

        case 4:
          shape = getFlat((tileWidth * 0.05f) + tileWidth * j, tileWidth * (i - 1), (tileWidth * 0.05f) + tileWidth * j, tileWidth + (tileWidth * (i - 1)));
          allWalls.add(shape);
          break;
        default:
          break;
        }
      }
    }
  }

  strokeWeight(6);
  PShape ghostDoor = getGhostDoor();
  allWalls.add(ghostDoor);

  map = new Map(allWalls, path);
  gameObjects.add(map);
  strokeWeight(1);

  timer = new Timer();
  gameObjects.add(timer);

  loaded = true;
}

PShape getCorner(float x, float y, float shapeW, float shapeH, float start) {


  PShape shape = createShape(ARC, x, (tileWidth * 2) + y, shapeW, shapeH, start, start + HALF_PI);
  return shape;
}

PShape getFlat(float x1, float y1, float x2, float y2) {
  PShape shape = createShape(LINE, x1, (tileWidth * 2) + y1, x2, (tileWidth * 2) + y2);
  return shape;
}

PShape getGhostDoor() {

  stroke(255);

  float upper = (tileWidth * 2) + (tileWidth * 12) + (tileWidth * 0.55f);
  float lower = (tileWidth * 2) + (tileWidth * 12) + (tileWidth * 0.95f);
  float middle = (upper + lower) * 0.5f;

  PShape shape = createShape(GROUP);
  PShape leftSide = createShape(LINE, (tileWidth * 13) + (tileWidth * 0.05f), upper, (tileWidth * 13) + (tileWidth * 0.05f), lower);
  shape.addChild(leftSide);

  PShape rightSide = createShape(LINE, (tileWidth * 14) + (tileWidth * 0.95f), upper, (tileWidth * 14) + (tileWidth * 0.95f), lower);
  shape.addChild(rightSide);

  PShape middleShape = createShape(LINE, (tileWidth * 13) + (tileWidth * 0.05f), middle, (tileWidth * 14) + (tileWidth * 0.95f), middle);
  shape.addChild(middleShape);
  return shape;
}

void option() {

  //Use a switch case to drive menu
  switch (menuOption) {
  case 0:
    //mainMenu();
    println("Menu will go here");
    break;

  case 1:
    if (loaded) {
      //maze.render();
      gamePlay();
      displayDetails();
    } else {
      createSprites();
      loadData();
    }//end if/else()

    break;

  default:
    break;
  }//end switch()
}

void gamePlay() {

  if (pakmac.lives >= 0) {
    if (!pausePlay) {
      checkCollisions();

      setTargetTiles();
    } else {
      timer.pauseTimer++;

      if (timer.pauseTimer > 120 && pakmac.lives >= 0 && !reset) {
        pakmac.resetPositions();
      }
      println(timer.pauseTimer);
      if (timer.pauseTimer > 180) {
        timer.pauseTimer = 0;
        pausePlay = false;
      }
    }
  }
  /*Code will go here to end the game....
   Use a timer to go back to the menu
   ....
   ....
   ....
   ....
   */

  for (int i = gameObjects.size() - 1; i >= 0; i--) {
    gameObjects.get(i).render();
    if ((!pausePlay && (gameObjects.get(i) instanceof Pakmac || gameObjects.get(i) instanceof Ghost || gameObjects.get(i) instanceof Timer)) || gameObjects.get(i) instanceof GhostScore) {
      gameObjects.get(i).update();
    }
  }
}

void createSprites() {
  pakmac = new Pakmac(width * 0.5f, (tileWidth * 25) + (tileWidth * 0.5f), tileWidth * 1.6, color(255, 255, 0), 'W', 'A', 'S', 'D', 2);
  gameObjects.add(pakmac);


  life = createShape(ARC, 0, 0, tileWidth, tileWidth, -PI + radians(20), PI - radians(20));

  blinky = new Ghost(width * 0.5f, (tileWidth * 13) + (tileWidth * 0.5f), (tileWidth * 2) * 0.85, tileWidth * 0.85, color(255, 0, 0), new PVector(-1, 24), 2, false, 3.0f, true, 11, 12);
  gameObjects.add(blinky);
  ghosts.add(blinky);

  pinky = new Ghost(width * 0.5f, (tileWidth * 16) + (tileWidth * 0.5f), (tileWidth * 2) * 0.85, tileWidth * 0.85, color(255, 184, 222), new PVector(-1, 6), 1, true, 0.5f, true, 11, 13);
  gameObjects.add(pinky);
  ghosts.add(pinky);
  
  inky = new Ghost((tileWidth * 12), (tileWidth * 16) + (tileWidth * 0.5f), (tileWidth * 2) * 0.85, tileWidth * 0.85, color(0, 255, 223), new PVector(32, 18), 3, true, 0.5f, false, 11, 13);
  gameObjects.add(inky);
  ghosts.add(inky);
  println((tileWidth * 13) + (tileWidth * 0.5f));
}

void checkCollisions() {

  for (int i = gameObjects.size() - 1; i >= 0; i--) {
    GameObject player = gameObjects.get(i);

    if (player instanceof Pakmac) {
      for (int j = gameObjects.size() - 1; j >= 0; j--) {

        GameObject object = gameObjects.get(j);

        if (object instanceof Dot ) {
          if (player.pos.dist(object.pos) < (player.objectHeight * 0.5f) - object.objectHeight) {
            gameObjects.remove(object);
            ((Dot) object).applyTo((Pakmac) player);
          }
        } else if (object instanceof Powerup) {
          if (player.pos.dist(object.pos) < (player.objectWidth * 0.5f) - object.objectWidth * 0.5f) {
            println("POWERUP");
            gameObjects.remove(object);
            ((Powerup) object).applyTo((Pakmac) player);
          }
        } else if (object instanceof Ghost) {
          if (player.getLocation().equals(object.getLocation())) {
            if (((Ghost) object).frightened) {
              ((Ghost) object).eaten();
              ((Ghost) object).applyTo(((Pakmac) player));
            } else if (!((Ghost) object).eaten) {
              //((Pakmac) player).resetPositions();
              pausePlay = true;
              pakmac.lives -= 1;
              reset = false;
            }
          }
        }
      }
    }
  }
}

void setTargetTiles() {

  if (modeChangePart != 7) {

    while (timer.count > modeChangeTimes[modeChangeLevelIndex][modeChangePart]) {
      modeChangePart++;

      if (modeChangePart == 7) {
        break;
      }
    }
  }

  mode = modeChangePart % 2;

  for (int i = 0; i < ghosts.size(); i++) {
    if (ghosts.get(i).frightened) {
      int row = (int) random(map.path.length);
      int col = (int) random(map.path[0].length);
      ghosts.get(i).targetTile = new PVector(row, col);
    } else if (ghosts.get(i).ready) {
      switch (mode) {

      case 0:

        ghosts.get(i).targetTile = ghosts.get(i).homeTile;

        break;

      case 1:
        switch (i) {
        case 0:
          ghosts.get(i).targetTile = pakmac.getLocation();
          break;

        case 1:
          println("Pinky case");
          PVector tempTarget = pakmac.getLocation();
          switch (pakmac.spriteDirection) {
          case 0:
            tempTarget.add(0, 4);
            break;

          case 1:
            tempTarget.add(4, 0);
            break;

          case 2:
            tempTarget.add(0, -4);
            break;

          case 3:
            tempTarget.add(-4, 0);
            break;
          }
          ghosts.get(i).targetTile = tempTarget;
          break;
        }
        break;
      }
    } else if (ghosts.get(i).eaten) {
      ghosts.get(i).targetTile = new PVector(11, 14);
    }
  }
  
  //println(blinky.targetTile);
}

void displayDetails() {
  fill(255);
  stroke(255);
  textSize(tileWidth * 2);
  text("1UP", tileWidth, tileWidth * 1.75f);
  text(pakmac.score, width * 0.25f, tileWidth * 1.75f);
  text("HIGH", (width * 0.5f), tileWidth * 1.75f);
  text(pakmac.score, width * 0.75f, tileWidth * 1.75f);

  for (int i = 0; i < pakmac.lives; i++) {
    pushMatrix();
    translate(tileWidth + (tileWidth * (i * 1.5f)), height - (tileWidth * 2));
    shape(life);
    popMatrix();
  }



  //println(dataPath("text.csv"));
  //File file = new File(dataPath("test.csv"));

  //if(file.exists()) {
  // println("exists"); 
  //} else {
  // println("not exist"); 
  //}
}

void keyPressed() {
  keys[keyCode] = true;
}

void keyReleased() {
  keys[keyCode] = false;
}