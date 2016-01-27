class Ghost extends GameObject {
  //Fields

  Ghost(float x, float y, float objectWidth, float objectHeight, color colour) {
    super(x, y, objectWidth, objectHeight, colour);
    fill(colour);
    stroke(colour);
    sprite = createShape(GROUP);
    PShape head = createShape(ARC, pos.x, pos.y, objectWidth, objectWidth, PI, TWO_PI, PIE);
    sprite.addChild(head);
    PShape body = createShape(RECT, pos.x - tileSize, pos.y, objectWidth, objectHeight);
    sprite.addChild(body);
  }//end Ghost construuctor method
  
  void render() {
    super.render();
    shape(sprite);
    //arc(pos.x, pos.y, objectWidth, objectHeight, PI, TWO_PI, PIE);
    //ellipse(pos.x, pos.y, objectWidth, objectHeight);
  }
}//end Ghost class()