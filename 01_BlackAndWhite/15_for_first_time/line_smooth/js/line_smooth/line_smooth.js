/// A simple example of a "for" loop of smooth lines.
//*//////////////////////////////////////////////////

function setup() {
  createCanvas(500, 500); // Creates the drawing canvas with the specified width and height
  smooth(); // Enables smooth rendering (anti-aliasing) for lines and shapes
  // noSmooth(); // You can uncomment the line above and comment out this one to disable smoothing
}

function draw() {
  // We don't need background() in this specific example,
  // as we are only drawing lines that don't obscure previous ones.

  for (let i = 0; i < 150; i++) { // REPEAT 150 TIMES
    line(i, i, 500, 150);      // SINGLE ACTION: Draws a line from (i, i) to (500, 150)
  }
}

// https://github.com/borkowsk/bookProcessingEN
