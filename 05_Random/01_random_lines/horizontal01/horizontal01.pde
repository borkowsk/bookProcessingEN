/// Random lines along the horizontal axis.
//*////////////////////////////////////////

size(300,200);

for(int i=0;i<300;i++)
{
  float a=random(200);   // A number in the range 0..200
  //line(i,0,i,a);       // down
  line(i,200,i,200-a);   // up
}

// https://github.com/borkowsk/bookProcessingEN
