class Ghost extends GameObject {
  //Fields

  Ghost(float x, float y, float objectWidth, float objectHeight, color colour) {
    super(x, y, objectWidth, objectHeight, colour);
    //Group shapes together to make the ghost
    fill(colour);
    stroke(colour);
    sprite = createShape(GROUP);
    PShape head = createShape(ARC, pos.x, pos.y, objectWidth, objectWidth, PI, TWO_PI, PIE);
    sprite.addChild(head);
    PShape body = createShape(RECT, pos.x - tileSize, pos.y, objectWidth, objectHeight);
    sprite.addChild(body);
    fill(0);
    stroke(0);
    PShape foot1= createShape(TRIANGLE, pos.x - tileSize, pos.y + tileSize, pos.x, pos.y + tileSize, pos.x - (tileSize * 0.5f), pos.y + (tileSize * 0.5f));
    sprite.addChild(foot1);
    PShape foot2= createShape(TRIANGLE, pos.x + tileSize, pos.y + tileSize, pos.x, pos.y + tileSize, pos.x + (tileSize * 0.5f), pos.y + (tileSize * 0.5f));
    sprite.addChild(foot2);
    fill(255);
    stroke(255);
    PShape eye1 = createShape(ELLIPSE, pos.x - (tileSize * 0.5f), pos.y - (tileSize * 0.25f), tileSize * 0.5f, tileSize * 0.615384f);
    sprite.addChild(eye1);
    PShape eye2 = createShape(ELLIPSE, pos.x + (tileSize * 0.5f), pos.y - (tileSize * 0.25f), tileSize * 0.5f, tileSize * 0.615384f);
    sprite.addChild(eye2);
    fill(0);
    stroke(0);
    PShape pupil1 = createShape(ELLIPSE, pos.x - (tileSize * 0.5f), pos.y - (tileSize * 0.25f), tileSize * 0.153846f, tileSize * 0.153846f);
    sprite.addChild(pupil1);
    PShape pupil2 = createShape(ELLIPSE, pos.x + (tileSize * 0.5f), pos.y - (tileSize * 0.25f), tileSize * 0.153846f, tileSize * 0.153846f);
    sprite.addChild(pupil2);
    
  }//end Ghost construuctor method
  
  void render() {
    super.render();
     pushMatrix();
    translate(pos.x, pos.y);
    shape(sprite);
    popMatrix();
    //arc(pos.x, pos.y, objectWidth, objectHeight, PI, TWO_PI, PIE);
    //ellipse(pos.x, pos.y, objectWidth, objectHeight);
  }
  
  void update(){
    for(int i = 0; i < sprite.getVertexCount(); i++){
      pos = sprite.getVertex(i);
      super.update();
      sprite.setVertex(i, pos.x, pos.y);
      
    }//end for(i)
  }//end update()
}//end Ghost class()