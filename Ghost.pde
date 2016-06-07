class Ghost extends GameObject { //<>//
  float startTheta;
  PShape[] eatenSprite;
  PVector homeTile;
  boolean ghostArea;
  boolean ready;
  
  Ghost(float x, float y, float objectWidth, float objectHeight, color colour, PVector homeTile, float theta, boolean ghostArea, float speed, boolean ready, int nextTileRow, int nextTileCol) {
    super(x, y, objectWidth, objectWidth, colour, theta);
    startTheta = theta;
    this.homeTile = homeTile;
    movingSprite1 = new PShape[4];
    movingSprite2 = new PShape[4];
    eatenSprite = new PShape[4];
    this.ghostArea = ghostArea;
    this.speed = speed;
    this.ready = ready;
    
    for(int i = 0; i < movingSprite1.length; i++) {
      fill(colour);
      stroke(colour);
      movingSprite1[i] = createShape(GROUP);
      movingSprite2[i] = createShape(GROUP);
      eatenSprite[i] = createShape(GROUP);
      
      // create the different body shapes and add them to the GROUP shape
      PShape head = createShape(ARC, 0, 0, objectWidth, objectWidth, PI, TWO_PI, PIE);
      movingSprite1[i].addChild(head);
      movingSprite2[i].addChild(head);
      
      PShape body = createShape(RECT, 0 - objectHeight, 0, objectWidth, objectHeight);
      movingSprite1[i].addChild(body);
      movingSprite2[i].addChild(body);
      
      fill(0);
      stroke(0);
      
      PShape foot1= createShape(TRIANGLE, 0 - objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 - (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
      movingSprite1[i].addChild(foot1);
      PShape foot2= createShape(TRIANGLE, 0 + objectHeight, 0 + objectHeight, 0, 0 + objectHeight, 0 + (objectHeight * 0.5f), 0 + (objectHeight * 0.5f));
      movingSprite1[i].addChild(foot2);
      
      PShape foot3 = createShape(TRIANGLE, -objectHeight, objectHeight, -objectHeight * 0.5f, objectHeight, -objectHeight * 0.75f, objectHeight * 0.5f);
      movingSprite2[i].addChild(foot3);
      PShape foot4 = createShape(RECT, -2.5f, objectHeight - 5, 5, 5);
      movingSprite2[i].addChild(foot4);
      PShape foot5 = createShape(TRIANGLE, objectHeight, objectHeight, objectHeight * 0.5f, objectHeight, objectHeight * 0.75f, objectHeight * 0.5f);
      movingSprite2[i].addChild(foot5);
      
      // Create the eyes
      fill(255);
      stroke(255);
      
      PShape eye1 = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f), objectHeight * 0.5f, objectHeight * 0.615384f);
      movingSprite1[i].addChild(eye1);
      movingSprite2[i].addChild(eye1);
      eatenSprite[i].addChild(eye1);
      PShape eye2 = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f), objectHeight * 0.5f, objectHeight * 0.615384f);
      movingSprite1[i].addChild(eye2);
      movingSprite2[i].addChild(eye2);
      eatenSprite[i].addChild(eye2);
    }
    
    fill(0);
    stroke(0);
    
    PShape pupil1Up = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) - 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape pupil2Up = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) - 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    movingSprite1[0].addChild(pupil1Up);
    movingSprite2[0].addChild(pupil1Up);
    movingSprite1[0].addChild(pupil2Up);
    movingSprite2[0].addChild(pupil2Up);
    eatenSprite[0].addChild(pupil1Up);
    eatenSprite[0].addChild(pupil2Up);
    
    PShape  pupil1Left = createShape(ELLIPSE, 0 - (objectHeight * 0.5f) - 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape  pupil2Left = createShape(ELLIPSE, 0 + (objectHeight * 0.5f) - 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    movingSprite1[1].addChild(pupil1Left);
    movingSprite2[1].addChild(pupil1Left);
    movingSprite1[1].addChild(pupil2Left);
    movingSprite2[1].addChild(pupil2Left);
    eatenSprite[1].addChild(pupil1Left);
    eatenSprite[1].addChild(pupil2Left);
    
    PShape pupil1Down = createShape(ELLIPSE, 0 - (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) + 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape pupil2Down = createShape(ELLIPSE, 0 + (objectHeight * 0.5f), 0 - (objectHeight * 0.25f) + 5, objectHeight * 0.153846f, objectHeight * 0.153846f);
    movingSprite1[2].addChild(pupil1Down);
    movingSprite2[2].addChild(pupil1Down);
    movingSprite1[2].addChild(pupil2Down);
    movingSprite2[2].addChild(pupil2Down);
    eatenSprite[2].addChild(pupil1Down);
    eatenSprite[2].addChild(pupil2Down);
    
    PShape pupil1Right = createShape(ELLIPSE, 0 - (objectHeight * 0.5f) + 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    PShape pupil2Right = createShape(ELLIPSE, 0 + (objectHeight * 0.5f) + 5, 0 - (objectHeight * 0.25f), objectHeight * 0.153846f, objectHeight * 0.153846f);
    movingSprite1[3].addChild(pupil1Right);
    movingSprite2[3].addChild(pupil1Right);
    movingSprite1[3].addChild(pupil2Right);
    movingSprite2[3].addChild(pupil2Right);
    eatenSprite[3].addChild(pupil1Right);
    eatenSprite[3].addChild(pupil2Right);
  }
  
  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    shape(movingSprite2[3]);
    popMatrix();
  }
  
  void update() {
    if(!ghostArea) {
      super.update();
    }
  }
}