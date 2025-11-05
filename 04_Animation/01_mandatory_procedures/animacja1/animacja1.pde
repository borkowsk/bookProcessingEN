/// Processing program in "mode" 2 - with functions.
//*/////////////////////////////////////////////////

void setup() // It is executed once - upon startup.
{
  size(500,500);
  background(0,0,200); // rgB
  noSmooth();
  ellipse(250, 250, 200, 200);
}


int i=0;

void draw() // It is executed in an invisible loop.
{
  fill(0,i,0); // rGb
  arc(250, 250, 200, 200, radians(i-10),radians(i));
  i+=10; // incrementation of "i"
}

// https://github.com/borkowsk/bookProcessingEN
