/// Circle sectors.
//*////////////////

size(500,500);
background(0,0,200); // rgB - BLUE
noSmooth(); // No line smoothing

ellipse(250, 250, 200, 200); // The ellipse underneath
for(int i=0;i<256;i+=10) // Repeat every 10
{
  fill(0,i,0); // rGb - GREEN
  arc(250, 250, 200, 200, radians(i-10),radians(i)); // Sectors
}

// http://processingwedukacji.blogspot.com
// https://github.com/borkowsk/bookProcessingEN
