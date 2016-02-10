class Button {
  //Fields
  protected float x1, x2, x3;
  protected float y1, y2, y3;
  protected color colour;
  private String label;
  protected float buttonW;
  protected float buttonH; 
  PShape button;
  PVector pos;

  //Constructor method
  Button(String label, float x, float y) {
    buttonW = width / 3.0f;
    buttonH = 40.0f;
    this.label = label;
    pos = new PVector(x, y);
    fill(127, 127, 127);
    stroke(255);
    rectMode(CENTER);
    button = createShape(RECT, 0, 0, buttonW, buttonH);
  }

  void renderButton() {

    fill(127, 127, 127);
    stroke(255);
    pushMatrix();
    translate(pos.x, pos.y);
    shape(button);
    popMatrix();
    stroke(0);
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text(label, pos.x, pos.y);
  }

  boolean checkPressed() {
    if ((currentX > pos.x - (buttonW * 0.5f)) && (currentX < pos.x + (buttonW * 0.5f)) && (currentY > pos.y - (buttonH * 0.5f)) && (currentY < pos.y + (buttonH * 0.5f))) {
      currentX = 0;
      currentY = 0;
      return true;
    }
    return false;
  }
  //void renderButton(/*int index*/) {
  //  rectMode(CENTER);
  //  textAlign(CENTER, CENTER);
  //  fill(227, 227, 227);
  //  rect(x1, y1, buttonW, buttonH);
  //  fill(0);
  //  textSize(20);
  //  text(label, x1, y1);
  //  textSize(12);
  //}

  //boolean checkPressed() {
  //  if ((currentX > x1 - (buttonW / 2.0f)) && (currentX < x1 + (buttonW / 2.0f)) && (currentY > y1 - (buttonH / 2.0f)) && (currentY < y1 + (buttonH / 2.0f))) {
  //    currentX = 0;
  //    currentY = 0;
  //    return true;
  //  }
  //  return false;
  //}

  ////Getters and setters
  //float getButtonW() {
  //  return buttonW;
  //}

  //float getButtonH() {
  //  return buttonH;
  //}

  //void setLabel(String label) {
  //  this.label = label;
  //}

  //void setButtonX(float x) {
  //  x1 = x;
  //}

  //void setButtonY(float y) {
  //  y1 = y;
  //}
}