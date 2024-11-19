/// reverse countdown "for" loop.
//*//////////////////////////////

size(500,500);
//noSmooth();
             
for(int i=255;i>=0;i--) // REPEAT 256 times (counting backwards)
{
  stroke(i); // Only the brightness changes unless something goes wrong :-)
  line(i,0,128,500); // only x changes, y==0
}

// https://github.com/borkowsk/bookProcessingEN
