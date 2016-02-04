class Map extends GameObject{
  //Fields
  PShape walls;
  MapPath path;
  color colour;
  int dotCount;

  //Constructor method
  Map(ArrayList<PVector> wallReference, MapPath path) {
    super(0,0,0,0,0,0);
    this.path = path;
    dotCount = 0;
    colour = color(0, 0, 255);
    fill(colour);
    stroke(colour);
    walls = createShape(GROUP);
    //PShape[] tile = new PShape[wallReference.size()];



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
    textSize(16);
    text("Score " + pakmac.score, width * 0.4f, tileSize * 0.6f);
  }//end render()

  public color getWallColour() {
    return colour;
  }
}//end Map class