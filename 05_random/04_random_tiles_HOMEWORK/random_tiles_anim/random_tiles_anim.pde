//Random tiles
void setup()
{
  size(500,500);
  frameRate(5);
}

void draw()
{
  for(int i=0;i<10;i++)
  {
     for(int j=0;j<10;j++)
     {
        fill( random(256),random(256),random(256));
        rect(i*50,j*50,50,50);
     }
  }
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/05_random

