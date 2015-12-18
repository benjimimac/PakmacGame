class GameObject{
 //Fields
  protected PVector pos;
  protected PVector forward;
  protected float theta = 0.0f;
  protected float objectHeight, objectWidth, objectRadius;
  protected color colour;
  protected float speed = 2.0f;
  
  //Constructor method
  GameObject(float x, float y, float objectWidth, float objectHeight, color colour){
    //this.x = x;
    //this.y = y;
    pos = new PVector(x, y);
    forward = new PVector(0, -1);
    this.objectWidth = objectWidth;
    this.objectHeight = objectHeight;
    objectRadius = objectWidth * 0.5f;
    this.colour = colour;
  }
  
  void render(){
    fill(colour);
  }  
  
  //Getters
  public float getPosX(){
   return pos.x; 
 }
  
  public float getPosY(){
   return pos.y; 
  }
  
  public float getObjectRadius(){
   return objectRadius; 
  }
  
  public float getObjectHeight(){
   return objectRadius; 
  }
}