class LeavingGhostAreaMovement implements Movement {
 
  Ghost ghost;
  
  LeavingGhostAreaMovement(Ghost ghost) {
   
    this.ghost = ghost;
  }
  
  public void update() {
    println("I'm about ready to go");
    if(ghost.pos.equals(new PVector(ghost.x, ghost.y))) {
      
    } 
  }
}