import ddf.minim.*;

ArrayList<GameObject> spriteObject = new ArrayList<GameObject>();
ArrayList<GameObject> foodObject = new ArrayList<GameObject>();
Pakmac pakmac;
Dot food;
Map maze;
int tileSize;
int infoBar;
int details;

boolean[] keys = new boolean[512];

AudioSnippet eat;
Minim minim;



float margin;
float tableH;
float tile;

int menuOption;

boolean loaded;

void setup() {
  size(500, 500);
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

  loaded = false; //If false load the new map data - true play game
}

void draw() {

  background(0);
  stroke(255);

  for (int i = 0; i <= 28; i++) {
    line(margin, margin + tile * i, margin + tableH, margin + tile * i);
  }
  for (int i = 0; i <= 28; i++) {
    line(margin + tile * i, margin, margin + tile * i, margin + tableH);
  }

  option();

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
  surface.setSize(800, 800);

  text("You are in the main menu", 100, 100);
}//end mainMenu()

void loadData() {
  println("You are in the loadData methd");            //Remove later
  //Resize the window for game play - 840 * 930
  surface.setSize(700, 750 + tileSize + details);
  
  pakmac = new Pakmac(100, 100, width * 0.05f, height * 0.05f, color(255, 255, 0));
  spriteObject.add(pakmac);
  food = new Dot(width * 0.5f, height * 0.5f, width * 0.01f, height * 0.01f, color(255));
  foodObject.add(food);
  
  //Create an ArrayList to store temp PVector references - these row and column references will be passed 
  //to the map object to create the map
  ArrayList<PVector> wallReference = new ArrayList<PVector>();
  
  //Load the map file
  String[] mapLines = loadStrings("stageTest3.csv");
  
  //Cycle through the mapLines array and create the map
  for(int i = 0; i < mapLines.length; i++){
    //Split the arrays based on ',' - commas
    String[] mapValues = mapLines[i].split(",");
    
    //Loop through each element of the mapValues array to retreive data
    for(int j = 0; j < mapValues.length; j++){
      //If an element equals "0" it's part of the wall
      if(mapValues[j].equals("0")){
        wallReference.add(new PVector(j, i));
      }//enf if()
    }//end for(j)
  }//end for(i)
  
  
  
  maze = new Map(wallReference);
  
  loaded = true;
}//end loadData()

void gamePlay() {
  //pakmac.render();
  //food.render();
  pakmac.update('W', 'S', 'A', 'D');
  //line(100, 140, 100 + pakmac.getObjectRadius(), 140);
  for (int i = 0; i < spriteObject.size(); i++) {
    spriteObject.get(i).render();
  }//end for()

  for (int i = 0; i < foodObject.size(); i++) {
    foodObject.get(i).render();
  }//end for()

  //println("Pac man radius = " + pakmac.getObjectRadius(), ", food radius = " + food.getObjectRadius() + ", combined is " + (pakmac.getObjectRadius() + food.getObjectRadius()));

  if (dist(pakmac.getPosX(), pakmac.getPosY(), food.getPosX(), food.getPosY()) <= (pakmac.getObjectRadius() + food.getObjectRadius())) {
    pakmac.openMouth();
    if (!eat.isPlaying()) {
      eat.rewind();
      eat.play();
    }
    println("Eaten");
  } else {
    pakmac.closeMouth();
    //println("Not eaten");
  }
}

void keyPressed() {
  keys[keyCode] = true;
}

void keyReleased() {
  keys[keyCode] = false;
}