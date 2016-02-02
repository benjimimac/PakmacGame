import ddf.minim.*;

ArrayList<GameObject> spriteObject = new ArrayList<GameObject>();
ArrayList<GameObject> foodObject = new ArrayList<GameObject>();
ArrayList<Ghost> enemyObject = new ArrayList<Ghost>();
Pakmac pakmac;
Ghost blinky;
Ghost pinky;
Ghost inky;
Ghost clyde;
Dot food;
Map maze;
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
  mode[0] = true;  //Scatter mode
  mode[1] = false;  //Chase mode
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

  //println("Pakmac: " + pakmac.getLocation() + ", Blinky: " + blinky.getLocation());

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
      maze.render();
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

  pakmac = new Pakmac(width * 0.5f, tileSize + (tileSize * 23) + (tileSize * 0.5f), tileSize * 1.6, tileSize * 1.6, color(255, 255, 0));
  spriteObject.add(pakmac);
  for (int i = 0; i < 20; i ++) {
    food = new Dot(width * 0.5f, height * 0.5f, width * 0.01f, height * 0.01f, color(255));
    foodObject.add(food);
  }

  //Add ghost sprites
  blinky = new Ghost(width * 0.5f, (tileSize * 12) + (tileSize * 0.5f), (tileSize * 2) * 0.85, tileSize * 0.85, color(255, 0, 0), new PVector(-1, 24), PI, false);
  spriteObject.add(blinky);
  enemyObject.add(blinky);
  pinky = new Ghost(width * 0.5f, (tileSize * 12)/*(tileSize * 15)*/ + (tileSize * 0.5f), (tileSize * 2) * 0.85, tileSize * 0.85, color(255, 184, 222), new PVector(-1, 6), PI/*HALF_PI*/, false);
  //pinky = new Ghost(width * 0.5f, (tileSize * 12) + (tileSize * 0.5f), (tileSize * 2) * 0.85, tileSize * 0.85, color(255, 184, 222), new PVector(-1, 6), PI, false);
  spriteObject.add(pinky);
  enemyObject.add(pinky);
  inky = new Ghost(width * 0.5f, (tileSize * 12)/*(tileSize * 15)*/ + (tileSize * 0.5f), (tileSize * 2) * 0.85, tileSize * 0.85, color(0, 255, 223), new PVector(32, 18), PI/*HALF_PI*/, false);
  spriteObject.add(inky);
  enemyObject.add(inky);
  clyde = new Ghost(width * 0.5f, (tileSize * 12)/*(tileSize * 15)*/ + (tileSize * 0.5f), (tileSize * 2) * 0.85, tileSize * 0.85, color(255, 160, 0), new PVector(32, 1), PI/*HALF_PI*/, false);
  spriteObject.add(clyde);
  enemyObject.add(clyde);
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
        //blankReference.add(new PVector(j, i));
      }//end if()
    }//end for(j)
  }//end for(i)

  maze = new Map(wallReference, path);

  loaded = true;


  //testing
  for (int i = 0; i < 31; i++) {
    for (int j = 0; j < 28; j++) {
      print(maze.path.path[i][j] + ", ");
    }
    println();
  }
}//end loadData()

void gamePlay() {
  //pakmac.render();
  //food.render();
  PVector target;
  float targetTheta;

  for (int i = 0; i < spriteObject.size(); i++) {
    spriteObject.get(i).render();
    //println(i);
  }//end for()

  for (int i = 0; i < foodObject.size(); i++) {
    foodObject.get(i).render();
  }//end for()

  if (mode[0]) {
    //Set Blinky's target
    target = blinky.homeTile;
    blinky.setTarget(target);
    println("Blinky target: " + target);
    
    //set Pinkys target
    target = pinky.homeTile;
    pinky.setTarget(target);
    println("Pinky target: " + target);
    
    //Set Inkys target
    target = inky.homeTile;
    inky.setTarget(target);
    
    //Set Clydes target
    target = clyde.homeTile;
    clyde.setTarget(target);
  } else if (mode[1]) {
    target = pakmac.getLocation();
    blinky.setTarget(target);
    println(target);
    
    targetTheta = pakmac.getTheta();    
    target = pakmac.getLocation();
    if(targetTheta == 0){
      target.y += 4;
    }else if(targetTheta == HALF_PI){
      target.x += 4;
    }else if(targetTheta == PI){
      target.y -= 4;
    }else{
     target.x -= 4; 
    }
    pinky.setTarget(target);
    println(target);
  }

  pakmac.update('W', 'S', 'A', 'D');
  //blinky.update();//'I', 'K', 'J', 'L');
  for(int i = 0; i < enemyObject.size(); i++){
    enemyObject.get(i).update();
  }
  //line(100, 140, 100 + pakmac.getObjectRadius(), 140);


  if (dist(pakmac.getPosX(), pakmac.getPosY(), food.getPosX(), food.getPosY()) <= (pakmac.getObjectRadius() + food.getObjectRadius())) {
    pakmac.openMouth();
    if (!eat.isPlaying()) {
      eat.rewind();
      eat.play();
    }
    println("Eaten");
  } else {
    pakmac.closeMouth();
  }
}

void keyPressed() {
  keys[keyCode] = true;
}

void keyReleased() {
  keys[keyCode] = false;
}