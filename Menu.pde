class Menu {
  //Menu fields
  private int noOfButtons;
  private String title;
  Button button;
  boolean pressed;

  //Constructor methods
  Menu(int noOfButtons, String buttonLabel, String title) {
    this.title = title;
    pressed = false;

    this.noOfButtons = noOfButtons;
    
    button = new Button(buttonLabel, width * 0.5f, height * 0.5f);
  }

  void update() {
    pressed = button.checkPressed();
    if(pressed){
     menuOption = 1; 
    }
    
    println(pressed);
  }

  //render method
  void renderMenu() {
    fill(127, 127, 127);
    stroke(255);
    textAlign(CENTER);
    textSize(30);
    text(title, width * 0.5f, height * 0.1f);
    button.renderButton();    
  }
}