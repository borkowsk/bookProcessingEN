/** Bacterial population. */

int X=1; //Current state

for(int i=0;i<10;i++)
{
  println(i,X); //Note! `print` inserts a space in place of a comma
  X=2*X;        //Calculate next state!
}

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
