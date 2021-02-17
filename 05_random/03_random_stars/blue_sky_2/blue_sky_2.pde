// Stars in the sky of any size
size(1000,700);
background(0,0,25);
//noSmooth();//It looks much better with the smooth effect

//STARS:
int N=(height*width)/100;//Number of stars

for(int i=0;i<N;i++)
{
  float R=55+random(200);//Stars with a minimum brightness of 55
  float G=55+random(200);
  float B=55+random(200);
  stroke(R,G,B);//Different colors of the stars
  
  strokeWeight(random(2));//Different sizes of stars
  point(random(width),
        random(height));//Position adjusted to the size of the window
                            
}

//https://github.com/borkowsk/bookProcessingEN
