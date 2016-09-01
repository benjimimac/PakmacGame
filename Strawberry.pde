class Strawberry implements BonusType {
 
  PShape strawberry;
  Bonus bonus;
  
  Strawberry(Bonus bonus) {
    this.bonus = bonus;
    bonus.points = 300;
    
    setShape();
  }
  
  public void setShape() {
    
  }
  
  public void getShape() {
    shape(strawberry);
  }
}