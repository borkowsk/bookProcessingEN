//Processing program in mode 2 - with visible subroutines
//////////////////////////////////////////////////////////
void setup() //It is executed once - after starting
{
  size(500,500);
  background(0,0,200);//rgB - color the window only once
  noSmooth();//without line smoothing
  ellipse(250, 250, 205, 205);//white ellipse in the background
}

float i=0;//for(int i=0;i<inf;i+=10)

void draw() //It is executed in an invisible loop
{
  fill(0,i,0);//rGb
  arc(250, 250, 200, 200, i,i+1);//What wrong with "i"? READ MANUAL!
  i+=1;
}
