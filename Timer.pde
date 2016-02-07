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
  }

  void render() {
    fill(255);
    textSize(40);
    text(thousands + "" + hundreds + ":" + tens + "" + zeros + ":" + tenths, width * 0.3f, height - tileSize);
  }
  void update() {
    if(!mode[2]){
     ghostTimer++; 
     frightened = 0;
     if(mode[0]){
       lastMode = 0;
     }else{
      lastMode = 1; 
     }
    }else{
     frightened++;
     println(frightened);
     
     if(frightened == 480){
       for(int i = 0; i < mode.length; i++){
         mode[i] = false;
       }
       mode[lastMode] = true;
       for(int i = gameObject.size() - 1; i >= 0; i--){
         GameObject ghost = gameObject.get(i);
         if(ghost instanceof Ghost){
          ((Ghost) ghost).scared = false;
          //((Ghost) ghost).frightened = false; 
         }
       }
     }
    }
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
  }

  long getGhostTimer() {
    return ghostTimer;
  }
}