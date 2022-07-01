// RGB color model (red, green, blue)
// https://en.wikipedia.org/wiki/RGB

// RGB color model. Range for all color elements will be 0..99
colorMode(RGB, 100); //100 - default size of Processing window

// Note the different style of inserting the curly braces
for (int i = 0; i < 100; i++) {
  for (int j = 0; j < 100; j++) {
    stroke(i, 0, j); //RED-BLUE gradient
    point(i, j);
  }
}

// https://github.com/borkowsk/bookProcessingEN
