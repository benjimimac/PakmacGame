class Bonus extends GameObject implements Points{
  
  BonusType bonusType;
  int points;
  
   Bonus(float x, float y) {
    super(x, y);
    
    //Simple Factory method to be implemented to select more bonusTypes
    bonusType = new Cherry(this);
  }
  
  public void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    bonusType.getShape();
    popMatrix();
  }
  
  public void applyTo(Pakmac pakmac) {
    pakmac.score += points;
  }
}