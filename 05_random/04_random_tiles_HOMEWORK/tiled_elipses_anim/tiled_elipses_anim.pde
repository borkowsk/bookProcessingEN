/// Random tiled circles.
//*//////////////////////

void setup()
{
  size(500,500);
  frameRate(2);
  background(0,200,255);
  //clear(); //Strange black background, see manual
}

void draw()
{
  for(int i=0;i<10;i++)
  {
     for(int j=0;j<10;j++)
     {
        fill( random(256),random(256),random(256));
        ellipse(i*50+25,j*50+25,50,50);
     }
  }
}

// https://github.com/borkowsk/bookProcessingEN/tree/main/05_random
