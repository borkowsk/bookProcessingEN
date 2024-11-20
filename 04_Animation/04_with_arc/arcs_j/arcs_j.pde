/// Processing program in mode 2 - with visible subroutines.
//*/////////////////////////////////////////////////////////

void setup() //It is executed once - after starting
{
  size(500,500);
  background(0,0,200); // rgB
  noSmooth(); 
  ellipse(250, 250, 200, 200);
}

int i=0,j=0; ///< two global variable.

void draw() // use external i,j
{
  if(i>255) i=0; 
  fill(0,i,0); //rGb
  arc(250, 250, 200, 200, radians(j-13),radians(j));
  i+=10;
  j+=13;
}

// https://github.com/borkowsk/bookProcessingEN
