//ANIM "line()"  
//////////////////

void setup() //It is executed only once
{
  frameRate(16);//How many call of draw() per second
}

int pos = 0;

void draw() //It is executed in an invisible loop
{
  background(204);//This library routine clears the window
  line(pos, 20, pos, 80);//This draw line in the 'pos'-ition
  pos++;// pos=pos + 1; - so here 'pos' is incremented.
}

//https://github.com/borkowsk/bookProcessingEN
