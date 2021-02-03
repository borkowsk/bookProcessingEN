// RGB color model (red, green, blue)
// https://en.wikipedia.org/wiki/RGB
noStroke();

colorMode(RGB, 100);//100 - default size of Processing window

// Note the different style of inserting the curly braces
for (int i = 0; i < 100; i++) {
  for (int j = 0; j < 100; j++) {
    stroke(i, j, 0);
    point(i, j);
  }
}

//http://processingwedukacji.blogspot.com
