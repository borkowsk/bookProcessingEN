//General cell population growth
float X=1.0;//Current state
float R=2.5;//Average number of mature descendants

for(int i=0;i<10;i++)
{
  println(i,X);//generation and state
  X=R*X;//Calculate next state using R
}
