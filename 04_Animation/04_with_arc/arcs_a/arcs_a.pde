//Processing program in mode 2 - with visible subroutines
//////////////////////////////////////////////////////////

void setup() ////It is executed once - after starting
{
  size(500,500);
  background(0,0,200);//rgB
  noSmooth();//Bez wygładzania lini 
  ellipse(250, 250, 205, 205);
}

//for(int i=0;i<inf;i+=10)
int i=0;
void draw() //It is executed in an invisible loop
{
  fill(0,i,0);//rGb
  //'arc' expects an account in radians. 
  //Angles in degrees have to be convert with the function 'radians'
  arc(250, 250, 200, 200, radians(i-10),radians(i));
  i+=10;
}

//https://github.com/borkowsk/bookProcessingEN
