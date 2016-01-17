class Pakmac extends GameObject {
  //Fields
  private float start1, start2, close1, close2, startAngle, closeAngle;
  
  Pakmac(float x, float y, float objectWidth, float objectHeight, color colour) {
    super(x, y, objectWidth, objectHeight, colour);
    setStart1();
    setClose1();
    
    start2 = TWO_PI * 0.2f;
    close2 = TWO_PI - start2;
    startAngle = start1;
    closeAngle = close1;
  }
  
  void update(char up, char down, char left, char right){
    forward.x =  cos(theta);
    forward.y = sin(theta);
    forward.mult(speed);
    pos.add(forward);
    
    if(keys[right]){
      theta = radians(0.0f);
      setStart1();
      setClose1();
    }
    if(keys[down]){
      theta = radians(90.0f);
      setStart1();
      setClose1();
    }
    if(keys[left]){
      theta = radians(180.0f);
      setStart1();
      setClose1();
    }
    if(keys[up]){
      theta = radians(270.0f);
      setStart1();
      setClose1();
    }
    
  }

  void render() {
    super.render();
    arc(pos.x, pos.y, objectWidth, objectHeight, startAngle, closeAngle, PIE);
  }
  
  void openMouth(){
    startAngle = start2 + theta;
    closeAngle = close2 + theta;
  }
  
  void closeMouth(){
    startAngle = start1;
    closeAngle = close1;
  }
  
  void setStart1(){
    start1 = theta + radians(20.0f);
  }
  
  void setClose1(){
    close1 = theta + TWO_PI - radians(20.0f);
  }
  
}