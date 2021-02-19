// Stars in the sky of any size - animated
int N,i;//'N' and 'i' must be global!

void setup()
{
  size(1000,700);
  background(0,0,25);
  frameRate(300);
  //noSmooth();//It looks much better with the smooth effect
  //Global 'N' and 'i' are set below:
  N=(height*width)/100;//number of stars to draw
  i=0; //Counter
}

void draw()
{
  if(i<N)
  {
    float R=55+random(200);//Stars with a minimum brightness of 55
    float G=55+random(200);//<=> random(55,255);
    float B=55+random(200);// ---//---
    stroke(R,G,B);//Different colors of the stars
    strokeWeight(random(2));//Different sizes of stars
    
    point(random(width),
          random(height));//Different positions
    i++;
  }
}

//https://github.com/borkowsk/bookProcessingEN
