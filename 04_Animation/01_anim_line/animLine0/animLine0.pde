// ANIM "line()" in default configuration
////////////////////////////////////////////

int pos = 0;//GLOBAL variable!

void draw() //It is executed in an invisible loop
{
  background(128);//This library routine clears the window with color
  line(pos, 20, pos, 80);//This library routine draw a line
  pos++;//What happen here?
}

//https://github.com/borkowsk/bookProcessingEN
