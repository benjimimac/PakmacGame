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
  
  public int getPathNext(int x, int y){
    return path[y][x];
  }//end getPathInfo()
  
}//end MapPath class