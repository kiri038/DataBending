 /**
  Assignment: Data Bending
  Student: Kelly Gee
  Pasadena City College, Fall 2024
  Course Name: DMA60 Creative Coding
  Prof. George McKinney
  Project Description: This program changes data corruption values in a specific area through user input.
  Last Modified: October 14, 2024
  */

int r = color(255, 0, 0);
int g = color(0, 255, 0);
int b = color(0, 0, 255);
int y = color(255, 255, 0);
int w = color(255, 255, 255);
int black = color(0);
boolean ib = true, water = true;
int ibX, ibY, ibA, ibS;

PImage originalImg;
PImage img;
float corruptionRate = 0.1;
CustomSlider corruptionSlider;


void setup() {
  size(1920, 1080);
  originalImg = loadImage("pgr sun and bloody see.jpg");
  img = createImage(originalImg.width, originalImg.height, RGB);
  img.copy(originalImg, 0, 0, originalImg.width, originalImg.height, 0, 0, img.width, img.height);
  img.loadPixels();
  //allows corruption and de-corruption with two versions of the same image

  corruptionSlider = new CustomSlider(width / 2 - 100, height - 50, 200, 20, 0, 1);
  corruptionSlider.setValue(corruptionRate);
  //create slider
}


void draw() {
  background(0);
  image(img, 0, 0, width, height);
  
  if (water) {
    for (int i = 1150000; i< 2000000; i++) { //for (pixels in the bottom portion of the screen)

      color c = img.pixels[i];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      float a = alpha(c);
      //extract each color

      if (r >100 && g > 20 && b>85 ) { //if (specific color)
        img.pixels[i] = color((int) random(127, 230), (int) random(127, 230), (int) random(50, 255), 0);
        //then (randomly change color of pixels?)
      }
    }
  } else {
    img = loadImage("pgr sun and bloody see.jpg");
    //else (display original image)
  }

  corruptionSlider.update();
  corruptionSlider.display();
  //update and display slider

  fill(255);
  text("Corruption Rate", width / 2 - 80, height - 60);
  float newCorruptionRate = corruptionSlider.getValue();
  text(newCorruptionRate, width / 2 + 120, height - 60);

    pushMatrix();
    imageMode(CORNER);
    rotate(270);
    translate(-40,25);
    image(img, 0, 0);
    popMatrix();
    //rotate original image

  if (newCorruptionRate != corruptionRate) {
    dataCorruption(img, newCorruptionRate);
    corruptionRate = newCorruptionRate;
  }
}

void mousePressed() {
  corruptionSlider.mousePressed();
}

void mouseReleased() {
  corruptionSlider.mouseReleased();
}

void dataCorruption(PImage img, float rate) { //changes based on slider position/corruption value
  img.loadPixels();

  for (int i = 1100000; i< 2000000; i++) { //for (pixels in this area)
    if (random(1) < rate) {
      if (r >100 && g > 20 && b>80 ) //if (specific color)
        img.pixels[i] = color(random(255), random(255), random(255)); //change pixels randomly
    } else {
      int x = i % img.width;
      int y = i / img.width;
      img.pixels[i] = originalImg.get(x, y); //return to original image after corruption?
    }
  }
  img.updatePixels();
}
