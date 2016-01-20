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

    //Create the maze current level
    for (int i = 0; i < tiles.size(); i++) {
      PShape tile = createShape(RECT, tiles.get(i).x * tileSize, tiles.get(i).y * tileSize, tileSize, tileSize);
      

      //Add the new shape to the walls PShape
      walls.addChild(tile);
    }//end for(i)
  }//end Map constructor

  public void render() {
    shape(walls);
  }//end render()
}//end Map class