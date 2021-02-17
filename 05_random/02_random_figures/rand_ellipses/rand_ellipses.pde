// Transparent Random Circles
float W;//global variable

void setup()
{
  size(800,600);  //window size
  frameRate(100); //animation speed
  noStroke();     //no contours
  //Once you know what dimensions of the window are, 
  W=width/16;//we can calculate 'W'
}

//Our own function
int diameter()
{
  return int( random(W) );//convert from float to int
}

//visualisation
void draw()
{
  float alfa=random(128);//With random opacity of the fill
  fill(random(255),random(255),random(255),alfa);
  float d=diameter();//Diameter of a circle
  ellipse(random(width),random(height),d,d);
}

//https://github.com/borkowsk/bookProcessingEN
//https://github.com/borkowsk/bookProcessingPL
