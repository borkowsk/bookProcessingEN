/// CD image ;-) example.
//*///////////////////////

size(300,300);
background(0); // Black background (0 brightness)
noFill();      // The contours of the ellipses themselves
//noSmooth();  // Try with or without smoothing.
stroke(255);   // White outline

for(int i=150;i>30;i-=2) // REPEAT every other time <=> i=1-2
{
   ellipse(100,100,i,i);
} // Multi-instruction block is not needed here.

// Second plate...
stroke(128);
for(int i=150;i>30;i-=2)
   ellipse(200,200,i,i);

// https://github.com/borkowsk/bookProcessingEN
