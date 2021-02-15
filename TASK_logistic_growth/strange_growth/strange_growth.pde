//General cell population growth - what does 1/3 of a cell mean?

int   X=1;//Current state
float R=2.5;//Average number of mature descendants

for(int i=0;i<10;i++)
{
  println(i,X);//generation and state
  //parts of the cells are not allowed :-)
  X=int(R*X);//Calculate next state using R
}

//https://github.com/borkowsk/bookProcessingEN
