/** General cell population growth. But, what does 1/3 of a cell mean? */

int   X=1;   //Current state
float R=2.5; //Average number of mature descendants

for(int i=0;i<10;i++)
{
  println(i,X);  //generation and state
  //parts of the cells are not allowed here :-)
  X=int(R*X);   //Calculate next state using R
}

text("DONE!!!",0,height);

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
