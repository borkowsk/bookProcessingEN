// Infinite line animation.
//*/////////////////////////

void setup() 
{
  size(300,200);
  frameRate(9999); //Unrealistic :-)
}

int pos = 0; ///< GLOBAL VARIABLE

void draw() 
{ //extern pos; //used global variable `pos`.
  background(0);
  stroke(255);
  line(pos, 20, pos, height-20 );
  pos++;
  
  if (pos > width) // already outside the window?
  {
    pos = 0; // go back to initial position!
    println(frameRate); // Real frame rate in last cycle
  }
}

// https://github.com/borkowsk/bookProcessingEN
