class Dot extends GameObject{
 
  //Constructor method
  Dot(float x, float y, float objectWidth, float objectHeight, color colour){
    super(x, y, objectWidth, objectHeight, colour);
  }
  
  void render(){
    super.render();
    pos.x = mouseX;
    pos.y = mouseY;
    ellipse(pos.x, pos.y, objectWidth, objectHeight);
  }
}