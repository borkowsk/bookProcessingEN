/// Random lines along the horizontal axis.
//*////////////////////////////////////////

size(500,250);

for(int i=0;i<width;i++)
{
  float a=random(height);    //A number in the range 0..height
  line(i,0,i,a);           //down
  //line(i,height,i,height-a); //up
}

// https://github.com/borkowsk/bookProcessingEN
