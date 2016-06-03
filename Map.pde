class Map extends GameObject{

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
    for(int i = 0; i < path.length; i++) {
     for(int j = 0; j < path[i].length; j++) {
       print(this.path[i][j] + " ");
     }
     println();
    }
    
  }

  void render() {
    shape(map);
  }
}