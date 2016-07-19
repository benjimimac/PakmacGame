class Timer extends GameObject {

  int tenths; 
  long zeros;
  int tens;
  int hundreds;
  int thousands;
  long count;
  static final int FRIGHTENED_LIMIT = 420;
  boolean frightened;
  long pauseTimer;

  Timer() {
    super(0, 0, 0, 0, 0);
    tenths = 0;
    zeros = 0;
    tens = 0;
    hundreds = 0;
    thousands = 0;
    count = 0;

    frightened = false;
    pauseTimer = 0;
  }

  void render() {
    fill(255);
    textSize(40);

    text(zeros + ":" + tenths, width * 0.3f, height - tileWidth);
  }


  void update() {


    //if (count % 60 == 0) {
    //  zeros += 1;
    //}
    //if (count % 600 == 0) {
    //  tens += 1;
    //}
    //if (count % 3600 == 0) {
    //  hundreds += 1;
    //}

    //if (count % 36000 == 0) {
    //  thousands += 1;
    //}

    //if (tenths == 10) {
    //  tenths = 0;
    //}
    //if (zeros == 10) {
    //  zeros = 0;
    //}

    //if (tens == 6) {
    //  tens = 0;
    //}

    //if (hundreds == 10) {
    //  hundreds = 0;
    //}

    if (frightened) {
      pauseTimer++;
      if (pauseTimer == 420) {
        frightened = false;
        pauseTimer = 0;
        amount = 0;
        println("Pause timer has stopped");
      }
    } else {
      count++;
      if (count % 6 == 0) {
        tenths++;
        if (tenths == 10) {
          tenths = 0; 
          zeros++;
        }
      }
    }
  }
}