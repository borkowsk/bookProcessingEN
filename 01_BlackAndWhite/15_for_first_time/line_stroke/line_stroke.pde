/// Two statement inside a loop.
//*/////////////////////////////

size(500,500); // Larger window size needed
noSmooth();    // Without smoothing outlines

for(int i=0;i<256;i++) // REPEAT 256 TIMES
{ // code block START
  stroke(i);  // Sets the stroke (outline) color using the current value of 'i' (grayscale)
  line(i*2,i*2,0,500); // Draws a line from (i*2, i*2) to (0, 500)
} // code block END

// https://github.com/borkowsk/bookProcessingEN
