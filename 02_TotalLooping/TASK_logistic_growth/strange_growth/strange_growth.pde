//General cell population growth
int   X=1;//Current state
float R=2.5;//Average number of mature descendants

for(int i=0;i<10;i++)
{
  println(i,X);//generation and state
  X=int(R*X);//Calculate next state using R
}
