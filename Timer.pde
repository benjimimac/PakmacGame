class Timer extends GameObject {
  int tenths; 
  int zeros;
  int tens;
  int hundreds;
  int thousands;
  long count;
  long ghostTimer;
  int frightened;
  int lastMode;
  int pauseTimer;
  long levelStart;
  boolean beginLevel;
  boolean gamePause;
  int eatGhost;
  int mouthOpen;

  public Timer() {
    super(0, 0, 0, 0, 0, 0);
    tenths = 0;
    zeros = 0;
    tens = 0;
    hundreds = 0;
    thousands = 0;
    count = 0;
    ghostTimer = 0;
    frightened = 0;
    lastMode = 0;
    pauseTimer = 0;
    beginLevel = false;
    levelStart = 0;
    gamePause = false;
    eatGhost = 0;
    mouthOpen = 0;
  }

  void render() {
    fill(255);
    textSize(40);
    text(thousands + "" + hundreds + ":" + tens + "" + zeros + ":" + tenths, width * 0.3f, height - tileSize);
  if(!gameOver){
    levelStart += 1;
    if (levelStart == 180) {
      beginLevel = true;
    }

    if (gamePause) {
      eatGhost += 1;
      if (eatGhost == 60) {
        gamePause = false;
      }
    }
  }
  }
  void update() {
    if (!mode[2]) {
      ghostTimer++; 
      frightened = 0;
      if (mode[0]) {
        lastMode = 0;
      } else {
        lastMode = 1;
      }
    } else {
      frightened++;

      if (frightened == 480) {
        for (int i = 0; i < mode.length; i++) {
          mode[i] = false;
        }
        mode[lastMode] = true;
        for (int i = gameObject.size() - 1; i >= 0; i--) {
          GameObject ghost = gameObject.get(i);
          if (ghost instanceof Ghost) {
            ((Ghost) ghost).scared = false;
            //((Ghost) ghost).frightened = false;
          }
        }
      }
    }

    //if (!pakmac.died) {
    count++;
    if (count % 6 == 0) {
      tenths += 1;
    }
    if (count % 60 == 0) {
      zeros += 1;
    }
    if (count % 600 == 0) {
      tens += 1;
    }
    if (count % 3600 == 0) {
      hundreds += 1;
    }

    if (count % 36000 == 0) {
      thousands += 1;
    }

    if (tenths == 10) {
      tenths = 0;
    }
    if (zeros == 10) {
      zeros = 0;
    }

    if (tens == 6) {
      tens = 0;
    }

    if (hundreds == 10) {
      hundreds = 0;
    }

    //if (pakmac.eating) {
    //  mouthOpen += 1;
    //}else{
    // mouthOpen = 0; 
    //}

    // } else{//(pakmac.died){

    //}
  }

  long getGhostTimer() {
    return ghostTimer;
  }
}