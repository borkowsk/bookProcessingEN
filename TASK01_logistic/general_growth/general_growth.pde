/** General cell population growth */

float X=1.0; //Current state
float R=2.5; //Average number of mature descendants

for(int i=0;i<10;i++)
{
  println(i,X); //printing generation and state
  X=R*X;        //Calculate next state using R!
}

text("DONE",30,55); //For default window 100x100

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
