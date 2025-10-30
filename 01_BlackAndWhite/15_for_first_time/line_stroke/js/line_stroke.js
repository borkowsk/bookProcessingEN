/// Two statement inside a loop.
//*/////////////////////////////

function setup() {
  createCanvas(500, 500); // Creates a larger drawing canvas with the specified width and height
  noSmooth(); // Disables smoothing (anti-aliasing) for outlines
}

function draw() {
  // We don't need background() here as the lines will be drawn over each other.
  // If you want a clean background in each frame (for animation), you would add background().

  for (let i = 0; i < 256; i++) { // REPEAT 256 TIMES
    stroke(i); // Sets the stroke (outline) color using the current value of 'i' (grayscale)
    line(i * 2, i * 2, 0, 500); // Draws a line from (i*2, i*2) to (0, 500)
  }
}
