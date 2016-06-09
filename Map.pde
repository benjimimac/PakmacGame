class Map extends GameObject {

  PShape map;
  int[][] path;

  Map(ArrayList<PShape> allWalls, int[][] path) {

    super(0, 0, 0, 0, 0);
    map = createShape(GROUP);

    for (PShape oneWall : allWalls) {
      map.addChild(oneWall);
    }

    this.path = path;

    println(path.length + ", " + path[30].length);
    for (int i = 0; i < path.length; i++) {
      for (int j = 0; j < path[i].length; j++) {
        print(this.path[i][j] + " ");
      }
      println();
    }
  }

  void render() {
    shape(map);
  }

  int checkPath(int x, int y) {
    
    if (y < 0) {
      y = 27;
    }

    if (y > 27) {
      y = 0;
    }

    if (x < 0) {
      x = 30;
    }

    if (x > 30) {
      x = 0;
    }

    return path[x][y];
  }
}