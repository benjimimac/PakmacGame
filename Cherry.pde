class Cherry implements BonusType {
 
  PShape cherry;
  Bonus bonus;
  
  Cherry(Bonus bonus) {
    this.bonus = bonus;
    bonus.points = 100;
    
    //cherry = createShape(RECT, -12, -12, 25, 25); 
    cherry = createShape(GROUP);
    PShape leftCherry = createShape(ELLIPSE, -6, 6, 12, 12);
    cherry.addChild(leftCherry);
    
    PShape rightCherry = createShape(ELLIPSE, 6, 6, 12, 12);
    cherry.addChild(rightCherry);
    
    PShape stem = createShape(LINE, -3, 0, 6, -12);
    cherry.addChild(stem);
  }
  
  public void render() {
    shape(cherry);
  }
}