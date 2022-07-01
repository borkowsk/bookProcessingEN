// Random colored lines along the horizontal axis
size(750,250);

for(int i=0;i<width;i++)
{
  float a=random(height);    //A number in the range 0..height
  stroke( random(256) , random(256), random(256) );
  line(i,height,i,height-a); //up
}

// https://github.com/borkowsk/bookProcessingEN
