int r = color(255, 0, 0);
int g = color(0, 255, 0);
int b = color(0, 0, 255);
int y = color(255, 255, 0);
int w = color(255, 255, 255);
int black = color(0);
boolean ib = true, water = true;
int ibX, ibY, ibA, ibS;

PImage img;
PImage backgrnd;
float corruptionRate = 0.1; // Initial corruption rate
CustomSlider corruptionSlider;

void setup() {
  size(1920, 1080);
  img = loadImage("pgr sun and bloody sea.jpg");
  frameRate(25);
  backgrnd = loadImage("pgr sun and bloody sea.jpg");
  background(0);
  backgrnd.loadPixels();
  corruptionSlider = new CustomSlider(width / 2 - 100, height - 50, 200, 20, 0, 1);
  corruptionSlider.setValue(corruptionRate);
}


void draw() {
  corruptionSlider.update();
  corruptionSlider.display();
  fill(0);
  float newCorruptionRate = corruptionSlider.getValue();

  if (newCorruptionRate != corruptionRate) {
    corruptionRate = newCorruptionRate;
  }
  if (water) {
    if (frameCount % 9  ==0) {//slow down the flicker
      for (int i = 1250000; i< 2000000; i++) {
        //look at these pixels which are the water and for the shiny ones make them flicker

        color c = backgrnd.pixels[i];
        float r = red(c);
        float g = green(c);
        float b = blue(c);
        float a = alpha(c);

        if (r >100 && g > 20 && b>80 ) {
          backgrnd.pixels[i] = color((int) random(127, 230), (int) random(127, 230), (int) random(50, 255), 0);
        }
      }
    }
  } else {
    backgrnd = loadImage("pgr sun and bloody sea.jpg");
  }

  backgrnd.updatePixels();
  image(backgrnd, 0, 0, width, height);
}