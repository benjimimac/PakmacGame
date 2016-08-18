class LeavingGhostAreaMovement implements Movement {

  Ghost ghost;

  LeavingGhostAreaMovement(Ghost ghost) {

    this.ghost = ghost;
  }

  public void update() {

    if (ghost.pos.y == ghost.y) {
      //println("I'm about ready to go");
      PVector leftLocation = ghost.getLocation();
      PVector rightLocation = ghost.getLocation();
      leftLocation.add(0, -2);
      rightLocation.add(0, 2);

      if (map.path[(int) leftLocation.x][(int) leftLocation.y] != 4) {
        ghost.spriteDirection = 0;
        println("Not equal to 4");
      } else if (map.path[(int) rightLocation.x][(int) rightLocation.y] != 4) {
        ghost.spriteDirection = 2;
      } else if (ghost.pos.x == width * 0.5f) {
        println("In the middle");
        ghost.spriteDirection = 3;
        ghost.ghostArea = false;
        ghost.getMovementBehaviour();
      }
    } else if (ghost.pos.y % tileWidth == 0) {
      ghost.forceTurn();
    }
  }
}