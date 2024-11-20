// Loop in the loop in the hidden INFINITE loop.
//*/////////////////////////////////////////////

void setup()
{
  size(256,256);
  frameRate(100);
}

int k=0; ///< global scpoe.

void draw()
{ // external k  
  if(k<256)
  {
    for(int i=0;i<256;i++)
    {
      for(int j=0;j<256;j++)
      { 
        //stroke(k,j,i);
        //stroke(j,k,i);
        stroke(i,j,k);
        point(j,255-i); // 2D gradient of colors
      }
    }
    println(k);
  }
  
  if(k==256)
  {
    println(frameRate,"fps");
  }
  
  k++; // Incrementation of "k" at the end of each call of `draw()`
}

// https://github.com/borkowsk/bookProcessingEN
