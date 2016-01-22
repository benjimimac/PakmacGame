class Map {
  //Fields
  PShape walls;

  //Constructor method
  Map(ArrayList<PVector> wallReference, ArrayList<PVector> ghostWall) {
    walls = createShape(GROUP);
    //PShape[] tile = new PShape[wallReference.size()];

    for (int i = 0; i < wallReference.size(); i++) {
      println(wallReference.get(i) + "Constructor method");
    }

    rectMode(CENTER);
    
    //Create the maze current level
    for (int i = 0; i < wallReference.size(); i++) {
      PShape tile = createShape(RECT, wallReference.get(i).x * tileSize, tileSize + (wallReference.get(i).y * tileSize), tileSize, tileSize);
      

      //Add the new shape to the walls PShape
      walls.addChild(tile);
    }//end for(i)
    
    for(int i = 0; i < ghostWall.size(); i++){
      PShape tile = createShape(RECT, ghostWall.get(i).x * tileSize, tileSize + (ghostWall.get(i).y * tileSize), tileSize, tileSize * 0.2f);
      
      //Add the new shape to the walls PShape
      walls.addChild(tile);
    }//end for(i)
    
    rectMode(CORNERS);
    
    stroke(0);
    fill(0);
    PShape top = createShape(RECT, 0,tileSize, width, 0);
    PShape bottom = createShape(RECT, 0, (wallReference.get(wallReference.size() - 1).y * tileSize) + tileSize, width, height);
    walls.addChild(top);
    walls.addChild(bottom);
    
    rectMode(CORNER);
  }//end Map constructor

  public void render() {
    shape(walls);
  }//end render()
}//end Map class