class Map extends GameObject {
  //Fields
  PShape walls;
  MapPath path;
  color colour;
  int dotCount;
  PVector ghostPoint;
  float move;
  int newScore;
  boolean levelFinished;
  int finishedCount;

  //Constructor method
  Map(ArrayList<PVector> wallReference, MapPath path) {
    super(0, 0, 0, 0, 0, 0);
    this.path = path;
    dotCount = 0;
    colour = color(0, 0, 255);
    fill(colour);
    stroke(colour);
    walls = createShape(GROUP);

    ghostPoint = new PVector(-100, -100);
    move = 0;
    newScore = 0;
    levelFinished = false;
    finishedCount = 0;

    rectMode(CENTER);

    //Create the maze current level
    for (int i = 0; i < wallReference.size(); i++) {
      PShape tile = createShape(RECT, wallReference.get(i).x * tileSize, tileSize + (wallReference.get(i).y * tileSize), tileSize, tileSize);

      //Add the new shape to the walls PShape
      walls.addChild(tile);
    }//end for(i)    


    PShape tile = createShape(RECT, tileSize * 12.5, tileSize * 14, tileSize, tileSize);
    walls.addChild(tile);
    tile = createShape(RECT, tileSize * 15.5, tileSize * 14, tileSize, tileSize);
    walls.addChild(tile);
    fill(BROWN);
    stroke(BROWN);
    tile = createShape(RECT, width * 0.5f, tileSize * 14, tileSize * 2, tileSize);
    walls.addChild(tile);


    rectMode(CORNERS);

    stroke(0);
    fill(0);
    PShape top = createShape(RECT, 0, tileSize, width, 0);
    PShape bottom = createShape(RECT, 0, (wallReference.get(wallReference.size() - 1).y * tileSize) + tileSize, width, height);
    walls.addChild(top);
    walls.addChild(bottom);

    rectMode(CORNER);

    //Maybe I'll remove this - not sure yet
    PShape ghostHouse = createShape(RECT, 11 * tileSize, tileSize + (13 * tileSize), 6 * tileSize, 3 * tileSize);
    walls.addChild(ghostHouse);
  }//end Map constructor

  public void render() {
    shape(walls);
    textSize(30);
    fill(255);
    text("Score " + pakmac.score, width * 0.8f, height - tileSize);
    text("Level " + level, width * 0.8f, height - tileSize * 2);

    if (pakmac.finished) {
      finishedCount += 1;
      if (finishedCount > 180) {
        currentScore = pakmac.score;
        currentLives = pakmac.lives;
        level += 1;
        loaded = false;
      }
    }
  }//end render()

  void update() {
    if (ghostPoint.y > -50) {
      move -= 5;
    }

    if (pakmac.lives == 0) {
      gameOver = true;
      pakmac.lives = 3;
      level = 1;
      currentScore = 0;
    }
    text(ghostPoints + ghostPoints, ghostPoint.x, ghostPoint.y + move--);
  }

  void addGhostPoints() {
    ghostPoint = pakmac.pos.copy();
    move = 0;
    ghostPoints *= 2;
    pakmac.score += (ghostPoints * 2);
    ghostPoint = pakmac.pos.copy();
  }

  public color getWallColour() {
    return colour;
  }
}//end Map class