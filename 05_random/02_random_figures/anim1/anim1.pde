//Animation example

void setup()  
{
  size(500,200);      //We set the size of the window,
  background(0,0,128);//its background color 
  stroke(255,255,0);  //and the color of the points
}

void draw()
{
  point(random(width),random(height));
}

//https://github.com/borkowsk/bookProcessingEN

