class Cherry implements BonusType {
 
  PShape cherry;
  Bonus bonus;
  
  Cherry(Bonus bonus) {
    this.bonus = bonus;
    bonus.points = 100;
    
    setShape();
    
    
  }
  
  public void setShape() {
    //cherry = createShape(RECT, -12, -12, 25, 25); 
    fill(255, 0, 0);
    stroke(0);
    cherry = createShape(GROUP);
    PShape leftCherry = createShape(ELLIPSE, -(0.25f * tileWidth), 0.25f * tileWidth, tileWidth * 0.8f, tileWidth * 0.8f);
    cherry.addChild(leftCherry);
    
    PShape rightCherry = createShape(ELLIPSE, 0.25f * tileWidth, 0.5f * tileWidth, tileWidth * 0.8f, tileWidth * 0.8f);
    cherry.addChild(rightCherry);
    
    stroke(255);
    
    PShape glare = createShape(ELLIPSE, -(0.45f * tileWidth), 0.3f * tileWidth, 2, 2);
    cherry.addChild(glare);
    glare = createShape(ELLIPSE, -(0.35f * tileWidth), 0.4f * tileWidth, 2, 2);
    cherry.addChild(glare);
    glare = createShape(ELLIPSE, (0.05f * tileWidth), 0.55f * tileWidth, 2, 2);
    cherry.addChild(glare);
    glare = createShape(ELLIPSE, (0.15f * tileWidth), 0.65f * tileWidth, 2, 2);
    cherry.addChild(glare);
    
    stroke(236, 180, 116);
    PShape stem = createShape(LINE, -3, 0, 12, -12);
    cherry.addChild(stem);
    stem = createShape(LINE, 8, 5, 12, -12);
    cherry.addChild(stem);
  }
  
  public void getShape() {
    shape(cherry);
  }
}