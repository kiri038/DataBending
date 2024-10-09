class CustomSlider {
  float x, y, w, h;
  float minValue, maxValue;
  float value;
  boolean dragging = false;

  CustomSlider(float x, float y, float w, float h, float minValue, float maxValue) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.minValue = minValue;
    this.maxValue = maxValue;
    this.value = minValue;
  }

  void display() {
    rectMode(CORNER);
    stroke(0);
    fill(150);
    rect(x, y, w, h);

    float sliderX = map(value, minValue, maxValue, x, x + w);
    fill(0);
    rect(sliderX - 5, y, 10, h);
  }

  boolean isMouseOver() {
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }

  void update() {
    if (dragging) {
      float newValue = map(constrain(mouseX, x, x + w), x, x + w, minValue, maxValue);
      value = newValue;
    }
  }

  void mousePressed() {
    if (isMouseOver()) {
      dragging = true;
    }
  }

  void mouseReleased() {
    dragging = false;
  }

  void setValue(float newValue) {
    value = constrain(newValue, minValue, maxValue);
  }

  float getValue() {
    return value;
  }
}