PImage originalImg; // Store the original image
PImage img;
float corruptionRate = 0.1; // Initial corruption rate
CustomSlider corruptionSlider; // Declare the slider as a global variable

void setup() {
  size(2388,912); //add the actual dimensions of your image
  originalImg = loadImage("your_image.jpg"); // Replace with the image's file path
  img = createImage(originalImg.width, originalImg.height, RGB); // Create a copy of the original image
  img.copy(originalImg, 0, 0, originalImg.width, originalImg.height, 0, 0, img.width, img.height);
  img.loadPixels();

  // Create a slider to control the corruption rate
  corruptionSlider = new CustomSlider(width / 2 - 100, height - 50, 200, 20, 0, 1);
  corruptionSlider.setValue(corruptionRate);
}

void draw() {
  background(255);

  // Display the image
  image(img, 0, 0, width, height);

  // Update the slider's position based on the mouse
  corruptionSlider.update();

  // Display the slider
  corruptionSlider.display();

  fill(0);
  text("Corruption Rate", width / 2 - 80, height - 60);
  float newCorruptionRate = corruptionSlider.getValue();
  text(newCorruptionRate, width / 2 + 120, height - 60);

  // Check if the corruption rate has changed
  if (newCorruptionRate != corruptionRate) {
    // Apply data corruption based on the slider value
    dataCorruption(img, newCorruptionRate);
    corruptionRate = newCorruptionRate; // Update the corruption rate
  }
}

void mousePressed() {
  // Call the mousePressed method of the slider
  corruptionSlider.mousePressed();
}

void mouseReleased() {
  // Call the mouseReleased method of the slider
  corruptionSlider.mouseReleased();
}

void dataCorruption(PImage img, float rate) {
  img.loadPixels();

  for (int i = 0; i < img.pixels.length; i++) {
    // Apply data corruption with a rate determined by the slider
    if (random(1) < rate) {
      img.pixels[i] = color(random(255), random(255), random(255));
    } else {
      // Restore the original pixel value from originalImg
      int x = i % img.width;
      int y = i / img.width;
      img.pixels[i] = originalImg.get(x, y);
    }
  }

  img.updatePixels();
}