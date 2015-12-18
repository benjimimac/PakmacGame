import ddf.minim.*;

ArrayList<GameObject> object = new ArrayList<GameObject>();
Pakmac pakmac;
GameObject food;

boolean[] keys = new boolean[512];

AudioSnippet eat;
Minim minim;



float margin;
float tableH;
float tile;



void setup() {
  size(800, 800);

  pakmac = new Pakmac(100, 100, width * 0.05f, height * 0.05f, color(255, 255, 0));
  object.add(pakmac);
  food = new Dot(width * 0.5f, height * 0.5f, width * 0.01f, height * 0.01f, color(255));
  object.add(food);

  minim = new Minim(this);
  eat = minim.loadSnippet("pakmac_chomp.wav");
  
   margin= width * 0.1f;
   tableH = height - margin * 2.0f;
   tile = tableH * 0.03571428f;
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

  gamePlay();
}

void gamePlay() {
  //pakmac.render();
  //food.render();
  pakmac.update('W', 'S', 'A', 'D');
  //line(100, 140, 100 + pakmac.getObjectRadius(), 140);
  for (int i = 0; i < object.size(); i++) {
    object.get(i).render();
  }

  println("Pac man radius = " + pakmac.getObjectRadius(), ", food radius = " + food.getObjectRadius() + ", combined is " + (pakmac.getObjectRadius() + food.getObjectRadius()));

  if (dist(pakmac.getPosX(), pakmac.getPosY(), food.getPosX(), food.getPosY()) <= (pakmac.getObjectRadius() + food.getObjectRadius())) {
    pakmac.openMouth();
    eat.rewind();
    eat.play();
    println("Eaten");
  } else {
    pakmac.closeMouth();
    println("Not eaten");
  }
}

void keyPressed() {
  keys[keyCode] = true;
}

void keyReleased() {
  keys[keyCode] = false;
}