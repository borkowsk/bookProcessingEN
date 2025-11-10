/** Logistic iteration - first attempt */

final float R=2.5; //immutable parameter
float X=0.3333333; //changing state

for(int i=0;i<100;i++)
{
  println(i,X);
  X=R*X*(1-X);   //Calculate next iteration
}

text("DONE",30,55); //For default window 100x100

/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
