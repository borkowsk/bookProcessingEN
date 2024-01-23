// draw() only
//*/////////////////

int i=0; //Global variable are available inside draw()

void draw() //It is executed in an invisible loop
{
  strokeWeight(3);
  stroke(255,0,255);
  fill(i,0,0);
  ellipse(50,50,99,99);
  i++; //Increment i
}

// https://github.com/borkowsk/bookProcessingEN
