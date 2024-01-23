// infinite line animation
//*////////////////////////////

void setup() 
{
  size(300,200);
  frameRate(60);
}

int pos = 0;

void draw() 
{
  background(204);
  line(pos, 20, pos, height-20 );
  pos++;
  
  if (pos > width) //already outside the window?
    pos = 0; //go back to initial position!
}

// https://github.com/borkowsk/bookProcessingEN
