import ddf.minim.*;

ArrayList<GameObject> gameObject = new ArrayList<GameObject>();
ArrayList<GameObject> foodObject = new ArrayList<GameObject>();
ArrayList<Ghost> enemyObject = new ArrayList<Ghost>();
Pakmac pakmac;
Ghost blinky;
Ghost pinky;
Ghost inky;
Ghost clyde;
Dot food;
Powerup powerup;
Map maze;
Timer timer;
int tileSize;
int infoBar;
int details;

final color BROWN  = color(139, 69, 19);

boolean[] keys = new boolean[512];

AudioSnippet eat;
Minim minim;



float margin;
float tableH;
float tile;

int menuOption;

boolean loaded;


boolean[] mode;

void setup() {
  //frameRate(2);
  size(600, 600);
  surface.setResizable(true);  //I want to be able to resize the window for game play

  //pakmac = new Pakmac(100, 100, width * 0.05f, height * 0.05f, color(255, 255, 0));
  //spriteObject.add(pakmac);
  //food = new Dot(width * 0.5f, height * 0.5f, width * 0.01f, height * 0.01f, color(255));
  //foodObject.add(food);

  minim = new Minim(this);
  eat = minim.loadSnippet("pacman_chomp.wav");

  margin= width * 0.1f;
  tableH = height - margin * 2.0f;
  tile = tableH * 0.03571428f;

  tileSize = 25;
  infoBar = 15;
  details = 100;

  menuOption = 1;  //Default is 0 for main menu

  mode = new boolean[3];
  mode[0] = false;  //Scatter mode
  mode[1] = true;  //Chase mode
  mode[2] = false;  //Frightened mode

  loaded = false; //If false load the new map data - true play game
}

void draw() {

  background(0);
  stroke(255);

  option();

  stroke(255, 0, 0);
  for (int i = 0; i <= 31; i++) {
    line(0, tileSize + (i * tileSize), width, tileSize + (i * tileSize));
  }
  for (int i = 0; i <= 28; i++) {
    line(tileSize * i, tileSize, tileSize * i, tileSize + (tileSize * 31));
  }


  if (dist(pakmac.getLocation().x, pakmac.getLocation().y, blinky.getLocation().x, blinky.getLocation().y) == 0) {//pakmac.getLocation() == blinky.getLocation()){
    println("The same tile");
  } else {
    //println("Not the same tile - distance is " + (int) dist(pakmac.getLocation().x, pakmac.getLocation().y, blinky.getLocation().x, blinky.getLocation().y));
  }

  //gamePlay();
}

void option() {
  //Use a switch case to drive menu
  switch (menuOption) {
  case 0:
    mainMenu();
    break;

  case 1:
    if (loaded) {
      //maze.render();
      gamePlay();
    } else {
      loadData();
    }//end if/else()
    break;
  }//end switch()
}//end menu()

void mainMenu() {
  //Resize the window for main menu - 800 * 800
  surface.setSize(600, 600);

  text("You are in the main menu", 100, 100);
}//end mainMenu()

void loadData() {
  println("You are in the loadData method");            //Remove later
  //Resize the window for game play - 840 * 930
  surface.setSize(700, 906);
  tileSize = width / 28;

  pakmac = new Pakmac(width * 0.5f, tileSize + (tileSize * 23) + (tileSize * 0.5f), tileSize * 1.6, tileSize * 1.6, color(255, 255, 0), 'W', 'A', 'S', 'D');
  gameObject.add(pakmac);



  //Create an ArrayList to store temp PVector references - these row and column references will be passed 
  //to the map object to create the map
  ArrayList<PVector> wallReference = new ArrayList<PVector>();
  //ArrayList<PVector> ghostWall = new ArrayList<PVector>();
  //ArrayList<PVector> ghostDoor = new ArrayList<PVector>();
  //ArrayList<PVector> blankReference = new ArrayList<PVector>();
  MapPath path = new MapPath();

  //Load the map file
  String[] mapLines = loadStrings("stageTest3.csv");

  //Cycle through the mapLines array and create the map
  for (int i = 0; i < mapLines.length; i++) {
    //Split the arrays based on ',' - commas
    String[] mapValues = mapLines[i].split(",");

    //Loop through each element of the mapValues array to retrieve data
    for (int j = 0; j < mapValues.length; j++) {
      //If an element equals "0" it's part of the wall
      if (mapValues[j].equals("0")) {
        wallReference.add(new PVector(j, i));
      }//end if()

      //if (mapValues[j].equals("2")) {
      //  ghostWall.add(new PVector(j, i));
      //}//end if()


      //if(mapValues[j].equals("6")){
      //  ghostDoor.add(new PVector(j, i));
      //}//end if()
    }//end for(j)
  }//end for(i)

  //Load the path file
  String[] pathLines = loadStrings("testPath.csv");

  //Cycle through each element of the pathLines array and retrieve data
  for (int i = 0; i < pathLines.length; i++) {
    //Split each element on "," - comma
    String[] pathValues = pathLines[i].split(",");

    //Loop through each element of pathValues
    for (int j = 0; j < pathValues.length; j++) {

      //If an element equals "0" it's a blank tile
      if (pathValues[j].equals("0")) {
        PVector tempPath = new PVector(j, i);
        path.setPathBlank(tempPath);
        //blankReference.add(new PVector(j, i));
      }//end if()

      //If an element equals "1", "2", or "3" it's a path tile - "1" is food - "3" is powerup
      if (pathValues[j].equals("2") || pathValues[j].equals("1") || pathValues[j].equals("3")) {
        PVector tempPath = new PVector(j, i);
        path.setPath(tempPath);

        if (pathValues[j].equals("2")) {
          //for (int i = 0; i < 20; i ++) {
          food = new Dot((j * tileSize) + (tileSize * 0.5f), tileSize + (i * tileSize) + ( tileSize * 0.5f), tileSize * 0.2f, tileSize * 0.2f, color(255));
          gameObject.add(food);
          // }
        }
        if (pathValues[j].equals("3")) {
          powerup = new Powerup((j * tileSize) + (tileSize * 0.5f), tileSize + (i * tileSize) + (tileSize * 0.5f), tileSize * 0.8f, tileSize * 0.8f, color(255));
          gameObject.add(powerup);
        }

        //if(pathValues[j].equals("3")){

        //}
        //blankReference.add(new PVector(j, i));
      }//end if()
    }//end for(j)
  }//end for(i)

  maze = new Map(wallReference, path);

  gameObject.add(maze);
  //Add ghost sprites
  blinky = new Ghost(width * 0.5f, (tileSize * 12) + (tileSize * 0.5f), (tileSize * 2) * 0.85, tileSize * 0.85, color(255, 0, 0), new PVector(-1, 24), PI, false, 2.5f, true, new PVector(11, 12));
  gameObject.add(blinky);
  enemyObject.add(blinky);
  pinky = new Ghost((tileSize * 14), (tileSize * 15)/*(tileSize * 15)*/ + (tileSize * 0.5f), (tileSize * 2) * 0.85, tileSize * 0.85, color(255, 184, 222), new PVector(-1, 6), HALF_PI, true, 1.0f, false, new PVector(11, 14));
  //pinky = new Ghost(width * 0.5f, (tileSize * 12) + (tileSize * 0.5f), (tileSize * 2) * 0.85, tileSize * 0.85, color(255, 184, 222), new PVector(-1, 6), PI, false);
  gameObject.add(pinky);
  enemyObject.add(pinky);
  inky = new Ghost((tileSize * 12), (tileSize * 15)/*(tileSize * 15)*/ + (tileSize * 0.5f), (tileSize * 2) * 0.85, tileSize * 0.85, color(0, 255, 223), new PVector(32, 18), PI + HALF_PI, true, 1.0f, false, new PVector(11, 14));
  gameObject.add(inky);
  enemyObject.add(inky);
  clyde = new Ghost((tileSize * 16), (tileSize * 15)/*(tileSize * 15)*/ + (tileSize * 0.5f), (tileSize * 2) * 0.85, tileSize * 0.85, color(255, 160, 0), new PVector(32, 1), PI + HALF_PI, true, 1.0f, false, new PVector(11, 14));
  gameObject.add(clyde);
  enemyObject.add(clyde);

  loaded = true;


  //testing
  for (int i = 0; i < 31; i++) {
    for (int j = 0; j < 28; j++) {
      print(maze.path.path[i][j] + ", ");
    }
    println();
  }
  timer = new Timer();
  gameObject.add(timer);
}//end loadData()

void gamePlay() {
  //pakmac.render();
  //food.render();
  PVector target;
  float targetTheta;

  for (int i = 0; i < gameObject.size(); i++) {
    gameObject.get(i).render();
  }//end for()

  //for (int i = 0; i < foodObject.size(); i++) {
  //  foodObject.get(i).render();
  //}//end for()

  if (mode[0]) {
    //Set Blinky's home tile target
    target = blinky.homeTile;
    blinky.setTarget(target);

    //set Pinkys home tile target
    target = pinky.homeTile;
    pinky.setTarget(target);

    //Set Inkys hometile target
    target = inky.homeTile;
    inky.setTarget(target);

    //Set Clydes home tile target
    target = clyde.homeTile;
    clyde.setTarget(target);
  } else if (mode[1]) {
    //Set Blinkys chase target
    target = pakmac.getLocation();
    blinky.setTarget(target);

    //Set Pinkys chase target
    targetTheta = pakmac.getTheta();    
    target = pakmac.getLocation();
    if (targetTheta == 0) {
      target.y += 4;
    } else if (targetTheta == HALF_PI) {
      target.x += 4;
    } else if (targetTheta == PI) {
      target.y -= 4;
    } else {
      target.x -= 4;
    }
    pinky.setTarget(target);

    //Set Inkys chase target
    target = pakmac.getLocation();
    if (targetTheta == 0) {
      target.y += 2;
    } else if (targetTheta == HALF_PI) {
      target.x += 2;
    } else if (targetTheta == PI) {
      target.y -= 2;
    } else {
      target.x -= 2;
    }
    PVector blinkyLoc = blinky.getLocation();
    float xAdd = target.x - blinkyLoc.x;
    float yAdd = target.y - blinkyLoc.y;
    target.x += xAdd;
    target.y += yAdd;
    inky.setTarget(target);

    //Set Clydes chase target
    target = pakmac.getLocation();
    if (dist(clyde.currentTile.x, clyde.currentTile.y, target.x, target.y) < 8) {
      target = clyde.homeTile;
      clyde.setTarget(target);
    } else {
      clyde.setTarget(target);
    }

    println("blinky: " + blinky.pos.x + ", " + blinky.pos.y + ", " + blinky.getLocation() + ", " + blinky.target + " - " + blinky.ghostArea + ", " + blinky.ready + ", " + degrees(blinky.theta));//pinky.getLocation());
    println("pinky: " + pinky.pos.x + ", " + pinky.pos.y + ", " + pinky.getLocation() + ", " + pinky.target + " - " + pinky.ghostArea + ", " + pinky.ready + ", " + degrees(pinky.theta));//pinky.getLocation());
    println("inky: " + inky.pos.x + ", " + inky.pos.y + ", " + inky.getLocation() + ", " + inky.target + " - " + inky.ghostArea + ", " + inky.ready + ", " + degrees(inky.theta));//inky.getLocation());
    println("clyde: " + clyde.pos.x + ", " + clyde .pos.y + ", " + clyde.getLocation() + ", " + clyde.target + " - " + clyde.ghostArea + ", " + clyde.ready + ", " + degrees(clyde.theta));//clyde.getLocation());
    
    if(frameCount == 30){
      pinky.ready = true;
    }
    if(maze.dotCount == 30){
     inky.ready = true; 
    }
    if(maze.dotCount == 85){
      clyde.ready = true;
    }

    checkCollisions();
  }

  //pakmac.update();//'W', 'S', 'A', 'D');
  //blinky.update();//'I', 'K', 'J', 'L');
  for (int i = 0; i < gameObject.size(); i++) {
    gameObject.get(i).update();
  }
  //line(100, 140, 100 + pakmac.getObjectRadius(), 140);


  //if (dist(pakmac.getPosX(), pakmac.getPosY(), food.getPosX(), food.getPosY()) <= (pakmac.getObjectRadius() + food.getObjectRadius())) {
  // pakmac.openMouth();
  // //if (!eat.isPlaying()) {
  // //  eat.rewind();
  // //  eat.play();
  // //}
  //} else {
  // pakmac.closeMouth();
  //}
}

void checkCollisions() {
  for (int i = 0; i < gameObject.size(); i++) {
    GameObject player = gameObject.get(i);

    if (player instanceof Pakmac) {
      for (int j = gameObject.size() - 1; j >= 0; j--) {
        GameObject dot = gameObject.get(j);
        if (dot instanceof Dot) {
          if (player.pos.dist(dot.pos) < player.halfWidth + dot.halfWidth) {
            pakmac.openMouth();
            if (!eat.isPlaying()) {
              eat.rewind();
              eat.play();
            }

            if (player.pos.dist(dot.pos) <= 5) {
              ((Dot) dot).applyTo((Pakmac)player);
              gameObject.remove(dot);
              pakmac.closeMouth();
              println("remove");
            }
          } /*else {
           pakmac.closeMouth();
           }*/
        }

        if (dot instanceof Powerup) {
          if (player.pos.dist(dot.pos) < player.halfWidth + dot.halfWidth) {

            pakmac.openMouth();
              
            if (player.pos.dist(dot.pos) <= 5) {
              ((Powerup) dot).applyTo((Pakmac)player);
              gameObject.remove(dot);
              pakmac.closeMouth();
              println("remove");
            }
          }
        }
      }
    }
  }
}

void keyPressed() {
  keys[keyCode] = true;
}

void keyReleased() {
  keys[keyCode] = false;
}