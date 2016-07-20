abstract class GameObject {
  PVector pos;
  float objectWidth;
  float objectHeight;
  color colour;
  float theta;
  float startTheta;
  float speed;
  PVector forward;

  PShape sprite;
  PShape movingSprite1[];
  PShape movingSprite2[];

  float x, y;

  int xReference;
  int yReference;

  boolean switchSprite;
  int spriteDirection;
  int startSpriteDirection;
  
  boolean eaten;
  boolean ghostArea;

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

    switchSprite = false;

    theta = HALF_PI;
  }
  
  GameObject(float x, float y) {
    
    this.x = x;
    this.y = y;
    pos = new PVector(x, y);
    forward = new PVector(0, -6);
  }

  //GameObject(float x, float y, float objectWidth, float objectHeight, color colour/*, float theta*/) {
  //  this(x, y, objectWidth, objectHeight, colour);
  //  theta = HALF_PI;
  //  //println(degrees(theta));
  //}

  abstract void render();

  void update() {

    forward.x =  cos(theta * spriteDirection);
    forward.y = sin(theta * spriteDirection);

    xReference = (int) map(pos.x, 0, width, 0, 28);
    yReference = (int) map(pos.y, (tileWidth * 2), (tileWidth * 2) + (tileWidth * 31), 0, 31);
    float fauxXPos = tileWidth * (xReference); // Fancy word, I know...

    //println("GameObject class - " + degrees(theta) + " - " + pos.x + " (" + xReference + ") " + " - " + pos.y + "(" + yReference + ") - ");// + test++);

    switch (spriteDirection) {
    case 3:

      upDirection();
      break;

    case 2:
      leftDirection();
      break;

    case 1:
      //println("left - " + pos);
      downDirection();
      break;

    case 0:
      rightDirection();
      break;

      //default:
      //println("default - " + theta);
      //break;
    }


    int xMod = (int) (pos.x % tileWidth);
    int yMod = (int) (pos.y % tileWidth);

    if (xMod > tileWidth * 0.25f && xMod < tileWidth * 0.75f && yMod > tileWidth * 0.25f && yMod < tileWidth * 0.75f) {
      switchSprite = false;
    } else {
      switchSprite = true;
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
    
    if (map.path[reference][xReference] == 3 || map.path[reference][xReference] == 4) {
      forward.mult(speed);
      pos.add(forward);
    }
  }

  void leftDirection() {
    //println("xReference mapped is - "  + map(xReference, 0, 28, 0, width));
    int reference = (int) map(pos.x - 1 - (tileWidth * 0.5f), 0, width, 0, 28);

    if (pos.x <= 0) {
      pos.x = width;
    }//end if()
    //println(pos.x % tileWidth + " - " + pos.y % tileWidth);
    //if (get((int) pos.x - (tileSize), (int) pos.y) != maze.getWallColour()) {
    if (map.path[yReference][reference] == 1 || map.path[yReference][reference] == 2) {// && map(pos.x - (tileWidth * 0.5f), 0, width, 0, 28) != xReference - 1) {

      forward.mult(speed);
      pos.add(forward);
    } 
    //}//enf if()
  }

  void downDirection() {
    //if (theta == radians(90.0f)) {
    int reference = (int) map(pos.y + (tileWidth * 0.5f), (tileWidth * 2), (tileWidth * 2) + (tileWidth * 31), 0, 31);

    if (reference == 31) {
      reference = 0;
    }

    if (pos.y >= height) {
      pos.y = 0;
    }//end if()

    if (map.path[reference][xReference] == 1) {
      forward.mult(speed);
      pos.add(forward);
    }
    
    if ((eaten && (map.path[reference][xReference] == 3 || map.path[reference][xReference] == 4))) {
      forward.mult(speed);
      pos.add(forward);
      ghostArea = true;
    }
    
    //if(eaten) {
      
    //}
    //}//end if()
  }

  void rightDirection() {
    int reference = (int) map(pos.x + (tileWidth * 0.5f), 0, width, 0, 28);

    if (reference == 28) {
      reference = 0;
    }

    //if (theta == 0.0f) {
    if (pos.x >= width) {
      pos.x = 0;
    }//end if()

    if (map.path[yReference][reference] == 1 || map.path[yReference][reference] == 2) {
      forward.mult(speed);
      pos.add(forward);
    }  
    //}//end if()
  }

  PVector getLocation() {

    int x = (int) map(pos.x, 0, width, 0, 28);
    int y = (int) map(pos.y, tileWidth * 2, (tileWidth * 2) + (tileWidth * 31), 0, 31);

    if (x > 27) {
      x = 0;
    }

    if (x < 0) {
      x = 27;
    }

    if (y > 30) {
      y = 0;
    }

    if (y < 0) {
      y = 30;
    }

    return new PVector(y, x);
  }
}