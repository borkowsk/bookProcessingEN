//Processing program in mode 2 - with visible subroutines
//////////////////////////////////////////////////////////
void setup() //Jest wykonywane raz - po uruchomieniu
{
  size(500,500);
  background(0,0,200);//rgB
  noSmooth();//Bez wygładzania lini 
  ellipse(250, 250, 205, 205);
}

//for(int i=0;i<inf;i+=10)
int i=0;
void draw() //Jest wykonywane w niewidocznej pętli
{
  if(i>255)
    i=0;
  fill(0,i,0);//rGb
  arc(250, 250, 200, 200, radians(i-10),radians(i));
  i+=10;
}