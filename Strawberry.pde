class Strawberry implements BonusType {
 
  PShape strawberry;
  Bonus bonus;
  
  Strawberry(Bonus bonus) {
    this.bonus = bonus;
    bonus.points = 300;
    
    setShape();
  }
  
  public void setShape() {
    fill(255, 0, 0);
    stroke(0);
    
    strawberry = createShape(GROUP);
    PShape ellipse = createShape(ELLIPSE, 0, -8, tileWidth * 1.25f, tileWidth * 0.5f);
    strawberry.addChild(ellipse);
  }
  
  public void getShape() {
    shape(strawberry);
  }
}