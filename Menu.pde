class Menu {
  //Menu fields
  private int noOfButtons;
  private String title;
  Button button;
  //ArrayList<Button>button;
  boolean pressed;

  //Constructor methods
  Menu(int noOfButtons, String buttonLabel, String title) {
    this.title = title;
    pressed = false;

    this.noOfButtons = noOfButtons;
    
    button = new Button(buttonLabel, width * 0.5f, height * 0.5f);
    //button = new ArrayList<Button>();
    //Button temp;
    //for (int i = 0; i < noOfButtons; i++) {
    //  temp = new Button(buttonLabel[i], width * 0.5f, height * 0.5f);
    //  button.add(temp);
    //}
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
    //background(0, 0, 255);
    //Button button = new Button();
    //button.setButtonX(width / 2.0f);
    //int tempCount = 0;
    //textSize(30);
    //text(title, width / 2.0f, height * 0.1f);
    //textSize(12);
    //for (int i = -noOfButtons + 1; i < noOfButtons; i++) {

    //  if (noOfButtons % 2 == 0) {
    //    if (i % 2 == 1 || i % 2 == -1) {
    //      button.setButtonY(((height + 100) / 2) + button.getButtonH() * i);
    //      button.setLabel(buttonLabel[tempCount]);
    //      button.renderButton();
    //      boolean buttonSelected = button.checkPressed();
    //      tempCount++;
    //      if (buttonSelected) {
    //        pressed = true;
    //        if (menuOption == 0) {
    //          menuOption = tempCount;
    //          subOption1 = 0;
    //        } else if(subOption1 == 0){
    //          subOption1 = tempCount;
    //          subOption2 = 0;
    //        }else{
    //         subOption2 = tempCount; 
    //        }
    //      }
    //    }
    //  } else {
    //    if (i % 2 == 0) {
    //      button.setButtonY((height / 2) + button.getButtonH() * i);
    //      button.setLabel(buttonLabel[tempCount]);
    //      button.renderButton();
    //      boolean buttonSelected = button.checkPressed();
    //      tempCount++;
    //      if (buttonSelected) {
    //        pressed = true;
    //        if (menuOption == 0) {
    //          menuOption = tempCount;
    //          subOption1 = 0;
    //        } else if(subOption1 == 0){
    //          subOption1 = tempCount;
    //          subOption2 = 0;
    //        }else{
    //         subOption2 = tempCount; 
    //        }
    //      }
    //    }
    //  }
    //}
    //if (menuOption != 0) {
    //  Button returnButton = new Button();
    //  returnButton.setButtonX(width / 2.0f);
    //  returnButton.setButtonY(height - 30.0f);
    //  returnButton.setLabel("Return");
    //  returnButton.renderButton();
    //  boolean backOne = returnButton.checkPressed();
    //  if (backOne) {
    //    if(subOption2 != 0){
    //      subOption2 = 0;
    //      pressed = true;
    //    }else if (subOption1 != 0) {
    //      subOption1 = 0;
    //      pressed = true;
    //    } else {
    //      menuOption = 0;
    //      pressed = true;
    //    }
    //  }
    //}
  }
}