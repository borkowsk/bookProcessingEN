// Transparent random squares
float W;//global variable

void setup()
{
  size(800,600);  //window size
  frameRate(200); //animation speed
  //Once you know what dimensions of the window are, 
  W=width/8;//We can calculate 'W'
}

//Our own function
int side()
{
  return int( random(W) );
}

//visualisation
void draw()
{
  float alfa=128+random(128);//random opacity (local variable)
  stroke(random(255),random(255),random(255),alfa);//same opacity
  fill(random(255),random(255),random(255),alfa);//for stroke & fill
  float s=side();//side of the square (local variable)
  rect(random(width-s),random(height-s),s,s);//why "-s" ?
}

//https://github.com/borkowsk/bookProcessingEN
//https://github.com/borkowsk/bookProcessingPL
