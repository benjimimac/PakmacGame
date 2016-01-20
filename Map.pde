class Map {
  //Fields
  PShape walls;

  //Constructor method
  Map(ArrayList<PVector> tiles) {
    walls = createShape(GROUP);
    //PShape[] tile = new PShape[tiles.size()];

    for (int i = 0; i < tiles.size(); i++) {
      println(tiles.get(i) + "Constructor method");
    }

    rectMode(CENTER);
    
    //Create the maze current level
    for (int i = 0; i < tiles.size(); i++) {
      PShape tile = createShape(RECT, tiles.get(i).x * tileSize, (tileSize) + tiles.get(i).y * tileSize, tileSize, tileSize);
      

      //Add the new shape to the walls PShape
      walls.addChild(tile);
    }//end for(i)
    
    rectMode(CORNERS);
    
    stroke(0);
    fill(0);
    PShape top = createShape(RECT, 0, 0 + tileSize, width, 0);
    PShape bottom = createShape(RECT, 0, (tiles.get(tiles.size() - 1).y * tileSize), width, height);
    walls.addChild(top);
    walls.addChild(bottom);
    
    rectMode(CORNER);
  }//end Map constructor

  public void render() {
    shape(walls);
  }//end render()
}//end Map class