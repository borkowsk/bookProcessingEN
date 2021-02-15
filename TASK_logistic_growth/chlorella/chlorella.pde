//Chlorella population
int X=1;//Current state
int R=4;//Number of descendants of the cell 2,4,8 even 16

for(int i=0;i<10;i++)
{
  println(i,X);//generation and state
  X=R*X;//Calculate next state using R
}
