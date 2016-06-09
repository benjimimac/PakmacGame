ArrayList<GameObject> gameObjects; //<>//
Map map;
Pakmac pakmac;
Ghost blinky;
float tileWidth;

boolean[] keys = new boolean[512];


boolean loaded;
int menuOption;

PVector[] restrictedTiles;


void setup() {
  size(672, 900);
  surface.setResizable(true);
  fill(0);
  stroke(255);

  tileWidth = 24.0f;

  gameObjects = new ArrayList<GameObject>();

  loaded = false;
  menuOption = 1;
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
    } else {
      loadData();
      createSprites();
    }//end if/else()

    break;

  default:
    break;
  }//end switch()
}

void gamePlay() {
  checkCollisions();

  setTargetTiles();

  for (int i = gameObjects.size() - 1; i >= 0; i--) {
    gameObjects.get(i).render();
    if (gameObjects.get(i) instanceof Pakmac || gameObjects.get(i) instanceof Ghost) {
      gameObjects.get(i).update();
    }
  }
}

void createSprites() {
  pakmac = new Pakmac(width * 0.5f, (tileWidth * 25) + (tileWidth * 0.5f), tileWidth * 1.6, color(255, 255, 0), 'W', 'A', 'S', 'D', PI);
  gameObjects.add(pakmac);

  blinky = new Ghost(width * 0.5f, (tileWidth * 13) + (tileWidth * 0.5f), (tileWidth * 2) * 0.85, tileWidth * 0.85, color(255, 0, 0), new PVector(-1, 24), PI, false, 2f, true, 11, 12);
  gameObjects.add(blinky);
  println((tileWidth * 13) + (tileWidth * 0.5f));
}

void checkCollisions() {

  for (int i = gameObjects.size() - 1; i >= 0; i--) {
    GameObject player = gameObjects.get(i);

    if (player instanceof Pakmac) {
      for (int j = gameObjects.size() - 1; j >= 0; j--) {

        GameObject dot = gameObjects.get(j);

        if (dot instanceof Dot) {
          if (player.pos.dist(dot.pos) < (player.objectHeight * 0.5f) - dot.objectHeight) {
            gameObjects.remove(dot);
          }
        }
      }
    }
  }
}

void setTargetTiles() {
  
  if(blinky.ready) {
    
    blinky.targetTile = pakmac.getLocation();
  }
}

void keyPressed() {
  keys[keyCode] = true;
}

void keyReleased() {
  keys[keyCode] = false;
}