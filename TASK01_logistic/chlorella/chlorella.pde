/** Chlorella population. */

int X=1;  //Current state
int R=4;  //Number of descendants of the cell 2,4,8 even 16

for(int i=0;i<10;i++)
{
  println(i,X); //printing generation and state
  X=R*X;        //Calculate next state using R
}

text("DONE",30,55); //For default window 100x100

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
 
