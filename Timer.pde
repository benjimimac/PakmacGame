class Timer extends GameObject {
  int tenths; 
  int zeros;
  int tens;
  int hundreds;
  int thousands;
  int count;

  public Timer() {
    super(0, 0, 0, 0, 0, 0);
    tenths = 0;
    zeros = 0;
    tens = 0;
    hundreds = 0;
    thousands = 0;
    count = 0;
  }

  void render() {
    fill(255);
    textSize(40);
    text(thousands + "" + hundreds + ":" + tens + "" + zeros + ":" + tenths, 100, height - tileSize);
  }
  void update() {
    count += 1;
    if (count % 6 == 0) {
      tenths += 1;
    }
    if (count % 60 == 0) {
      zeros += 1;
    }
    if (count % 600 == 0){
      tens += 1;
    }
    if (count % 3600 == 0) {
      hundreds += 1;
    }
    
    if(count % 36000 == 0){
      thousands += 1;
    }
    
    if (tenths == 10) {
      tenths = 0;
    }
    if (zeros == 10) {
      zeros = 0;
    }
    
    if(tens == 6){
      tens = 0;
    }
    
    if(hundreds == 10){
      hundreds = 0;
    }
    
    
  }
}