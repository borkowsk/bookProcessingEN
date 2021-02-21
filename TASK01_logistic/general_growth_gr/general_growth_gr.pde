//General cell population growth
float X=1;//Current state
float R=1.5;//Average number of mature descendants
size(500,500);
for(int i=0;i<16;i++)
{
  println(i,X);//generation and state
  X=R*X;//Calculate next state using R
  ellipse(i,500-X,2,2);
}
