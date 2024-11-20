/// Processing program in mode 2 - with visible subroutines.
//*/////////////////////////////////////////////////////////

void setup()
{
  size(500,500);
  background(0,0,200); // rgB
  noSmooth(); // no antialiasing
  ellipse(250, 250, 205, 205);
}

int i=0; // global variable used inside `draw()`

void draw() // use global i
{
  if(i>255) i=0; // "one line if".
  fill(0,i,0);   // rGb
  arc(250, 250, 200, 200, radians(i-10),radians(i));
  i+=10;
}

// https://github.com/borkowsk/bookProcessingEN
