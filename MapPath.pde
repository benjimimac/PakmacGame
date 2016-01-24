class MapPath {
  //Fields
  int[][] path;

  //Constructor method
  MapPath() {
    path = new int[28][31];
  }//end MapPath constructor
  
  public void setPathBlank(PVector blankTile){
    path[(int) blankTile.x][(int) blankTile.y] = 0;
  }//end setPathBlank method()
  
  public void setPath(PVector pathTile){
    path[(int) pathTile.x][(int) pathTile.y] = 1;
  }//end setPath method()
  
  public int getPathInfo(int x, int y){
    return path[x][y];
  }//end getPathInfo()
  
}//end MapPath class