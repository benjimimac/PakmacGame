abstract class GameObject {
  PVector pos;
  float objectWidth;
  float objectHeight;
  color colour;
  float theta;
  float startTheta;
  float speed = 3.0f;
  PVector forward;

  PShape sprite;
  PShape movingSprite[];

  float x, y;

  int xReference;
  int yReference;

  int test = 0;

  GameObject(float x, float y, float objectWidth, float objectHeight, color colour) {
    this.x = x;
    this.y = y;
    pos = new PVector(x, y);
    //startPos = new PVector(x, y);//pos.copy();
    this.objectWidth = objectWidth;
    this.objectHeight = objectHeight;
    this.colour = colour;
    forward = new PVector(0, 0);
  }

  GameObject(float x, float y, float objectWidth, float objectHeight, color colour, float theta) {
    this(x, y, objectWidth, objectHeight, colour);
    this.theta = theta;
    println(degrees(theta));
  }

  abstract void render();

  void update() {
    forward.x =  cos(theta);
    forward.y = sin(theta);
    xReference = (int) map(pos.x, 0, width, 0, 28);
    yReference = (int) map(pos.y, (tileWidth * 2), (tileWidth * 2) + (tileWidth * 31), 0, 31);
    float fauxXPos = tileWidth * (xReference); // Fancy word, I know...

    println("GameObject class - " + degrees(theta) + " - " + pos.x + " (" + xReference + ") " + " - " + pos.y + "(" + yReference + ") - ");// + test++);

    switch ((int) degrees(theta)) {
    case 0:

      rightDirection(); 
      break;

    case 90:
      downDirection();
      break;

    case 180:
      //println("left - " + pos);
      leftDirection();
      break;

    case 270:
      upDirection();
      break;

      //default:
      //println("default - " + theta);
      //break;
    }




    //

    //
  }//end update()  

  void upDirection() {
    int reference = (int) map(pos.y - 1 - (tileWidth * 0.5f), (tileWidth * 2), (tileWidth * 2) + (tileWidth * 31), 0, 31);
    
      if (pos.y <= 0) {
        pos.y = height;
      }//end if()

      if (map.path[reference][xReference] == 1) {
        forward.mult(speed);
        pos.add(forward);
      } 
  }

  void leftDirection() {
    println("xReference mapped is - "  + map(xReference, 0, 28, 0, width));
    int reference = (int) map(pos.x - 1 - (tileWidth * 0.5f), 0, width, 0, 28);

    if (pos.x <= 0) {
      pos.x = width;
    }//end if()
    //println(pos.x % tileWidth + " - " + pos.y % tileWidth);
    //if (get((int) pos.x - (tileSize), (int) pos.y) != maze.getWallColour()) {
    if (map.path[yReference][reference] == 1) {// && map(pos.x - (tileWidth * 0.5f), 0, width, 0, 28) != xReference - 1) {

      forward.mult(speed);
      pos.add(forward);
    } 
    //}//enf if()
  }

  void downDirection() {
    //if (theta == radians(90.0f)) {
      int reference = (int) map(pos.y + (tileWidth * 0.5f), (tileWidth * 2), (tileWidth * 2) + (tileWidth * 31), 0, 31);
      
      if(reference == 31) {
       reference = 0; 
      }
      
      if (pos.y >= height) {
        pos.y = 0;
      }//end if()

      if (map.path[reference][xReference] == 1) {
        forward.mult(speed);
        pos.add(forward);
      } 
    //}//end if()
  }

  void rightDirection() {
    int reference = (int) map(pos.x + (tileWidth * 0.5f), 0, width, 0, 28);
    
    if(reference == 28) {
     reference = 0; 
    }
    
    //if (theta == 0.0f) {
    if (pos.x >= width) {
      pos.x = 0;
    }//end if()

    if (map.path[yReference][reference] == 1) {
      forward.mult(speed);
      pos.add(forward);
    }  
    //}//end if()
  }
}