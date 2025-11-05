/// HOMEWORK from the picture example.
//*///////////////////////////////////

size(500,500);
smooth();           // With line smoothing ("anti-aliasing")
rectMode(CORNERS);  // Set rectMode to CORNERS

for(int i=0;i<=300;i+=10) // REPEAT EVERY TENTH!
{
  fill(i,0,i);
  rect(i,i,0,500); // And draw a "card"!
}

for(int i=300;i>=0;i-=10) // REPEAT EVERY TENTH BACKWARD!
{
  fill(0,i,i);
  ellipse(355,150,i,i); // And draw the "disc"
  ellipse(i,i,10,10);   // ...  and "tails".
}

// http://processingwedukacji.blogspot.com
// https://github.com/borkowsk/bookProcessingEN
