class Dot extends GameObject implements Goal{
  PShape dot;
  //Constructor method
  Dot(float x, float y, float objectWidth, float objectHeight, color colour){
    super(x, y, objectWidth, objectHeight, colour, 0.0f);
    
    dot = createShape(ELLIPSE, 0, 0, objectWidth, objectHeight);
  }
  
  void render(){
    //super.render();
    //pos.x = mouseX;
    //pos.y = mouseY;
    pushMatrix();
    translate(pos.x, pos.y);
    shape(dot);
    popMatrix();
    //ellipse(pos.x, pos.y, objectWidth, objectHeight);
  }
  
  void applyTo(Pakmac pakmac){
    pakmac.score += 10;
    maze.dotCount ++;
  }
}