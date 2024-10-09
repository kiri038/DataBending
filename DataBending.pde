// int r = color(255, 0, 0);
// int g = color(0, 255, 0);
// int b = color(0, 0, 255);
// int y = color(255, 255, 0);
// int w = color(255, 255, 255);
// int black = color(0);
// boolean ib = true, water = true;
// int ibX, ibY, ibA, ibS;

PImage originalImg; 
PImage img;
PImage backgrnd
float corruptionRate = 0.1; 
CustomSlider corruptionSlider;

void setup() {
  size(1920,1080); 
  originalImg = loadImage("pgr sun and bloody sea.jpg"); 
  img = createImage(originalImg.width, originalImg.height, RGB);
  img.copy(originalImg, 0, 0, originalImg.width, originalImg.height, 0, 0, img.width, img.height);
  img.loadPixels();

  corruptionSlider = new CustomSlider(width / 2 - 100, height - 50, 200, 20, 0, 1);
  corruptionSlider.setValue(corruptionRate);
}

void draw() {
  background(0);

  image(img, 0, 0, width, height);

  corruptionSlider.update();
  corruptionSlider.display();

  fill(0);
  text("Corruption Rate", width / 2 - 80, height - 60);
  float newCorruptionRate = corruptionSlider.getValue();
  text(newCorruptionRate, width / 2 + 120, height - 60);

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

void dataCorruption(PImage img, float rate) {
  img.loadPixels();
      for (int i = 1250000; i< 2000000; i++) {
        if (random(1) < rate) {
          img.pixels[i] = color(random(255), random(255), random(255));
           } else {
            int x = i % img.width;
            int y = i / img.width;
            img.pixels[i] = originalImg.get(x, y);
    }
  }
  
  img.updatePixels();
}