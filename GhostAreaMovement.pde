class GhostAreaMovement implements Movement {

  Ghost ghost;

  GhostAreaMovement(Ghost ghost) {

    this.ghost = ghost;
  }

  public void update() {
    //println(ghost.pos.x % tileWidth + " - " + ghost.pos.y % tileWidth);
    if (ghost.pos.y % tileWidth == 0) {
      
      ghost.forceTurn();      
    }
  }
}