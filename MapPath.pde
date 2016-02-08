class MapPath {
  //Fields
  int[][] path;

  //Constructor method
  MapPath() {
    path = new int[31][28];
  }//end MapPath constructor
  
  public void setPathBlank(PVector blankTile){
    path[(int) blankTile.y][(int) blankTile.x] = 0;
  }//end setPathBlank method()
  
  public void setPath(PVector pathTile){
    path[(int) pathTile.y][(int) pathTile.x] = 1;
  }//end setPath method()
  
  public void setGhostDoor(PVector ghostDoor){
    path[(int) ghostDoor.x][(int) ghostDoor.y] = 5;
  }
  
  public int getPathNext(int x, int y){
    if(y < 0){
      y = 27;
    }
    if(y > 27){
      y = 0;
    }
    return path[x][y];
  }//end getPathInfo()
  
}//end MapPath class