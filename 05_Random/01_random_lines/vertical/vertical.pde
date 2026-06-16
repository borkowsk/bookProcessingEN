/// Random lines along the Y axis.
//*///////////////////////////////

size(200,300);

for(int i=0;i<300;i++)
{
  float a=random(200); // Number in the range <0..200)
  line(0,i,a,i);
}

// https://github.com/borkowsk/bookProcessingEN
