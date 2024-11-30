/** General cell population COLLAPSE. */

size(210,800);
background(0);
fill(255);
stroke(128);

float X=400;  //Current state
float R=0.95; //Average number of mature descendants

for(int i=0;i<=100;i++)
{
  println(i,X); //printing generation and state
  X=R*X;        //Calculate next state using R!
  ellipse(i*2,800-X,7,7); //visualization.
}

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
