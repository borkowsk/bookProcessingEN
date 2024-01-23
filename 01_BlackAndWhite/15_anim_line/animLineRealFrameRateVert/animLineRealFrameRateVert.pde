// infinite line animation
//*//////////////////////////////

void setup() 
{
  size(400,300);
  frameRate(9999); // high frame rate!
  stroke(255);
}

int pos = 0;

void draw() 
{
  background(0); // what happens when this line is commented out?
  stroke(random(255));
  line(0,pos,width, pos);
  pos++;
  if (pos > height) //already outside the window?
  {
    pos = 0; //go back to initial position!
    println(frameRate); //Real frame rate in last cycle
  }
}

// https://github.com/borkowsk/bookProcessingEN
