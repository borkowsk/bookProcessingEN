/// Bigger CD image ;-) example.
//*//////////////////////////////

size(300,300);
background(0); // Change background!
noFill();      // Only the contours of the ellipses.
//noSmooth();

for(int i=250;i>30;i-=2) // REPEAT BACKWARD every two times <=> i=i-2
{  // Before run, try to guess what this code below does!
   stroke(i);   // More sophisticated color
   ellipse(width/2,height/2,i,i); // In the center of a window
}

// https://github.com/borkowsk/bookProcessingEN
