class ScatterMovement implements Movement {
 
  Ghost ghost;
  
  ScatterMovement(Ghost ghost) {
   this.ghost = ghost; 
  }
  
  public void update() {
    
    if (ghost.pos.x % tileWidth == tileWidth * 0.5f && ghost.pos.y % tileWidth == tileWidth * 0.5f) {
        ghost.setDirections();
      } else if (ghost.pos.x % tileWidth == 0 && ghost.pos.y % tileWidth == tileWidth * 0.5f && ghost.getLocation().equals(new PVector(11, (int) map.path[0].length * 0.5f)) && ghost.eaten) {
        ghost.enterGhostArea();
      }
  }
  
}