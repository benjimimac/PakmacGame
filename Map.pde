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
  }

  void render() {
    shape(map);
  }
}