class Bonus extends GameObject{
  
  BonusType bonusType;
  int points;
  
   Bonus(float x, float y) {
    super(x, y);
    
    bonusType = new Cherry(this);
  }
  
  public void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    bonusType.render();
    popMatrix();
  }
}