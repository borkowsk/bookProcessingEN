/** General cell population growth in window */
float X=2;   //Current state
float R=1.1; //Average number of mature descendants

// Settings:
size(210,800);
background(0);
fill(255);
stroke(128);

for(int i=0;i<=100;i++)
{
  println(i,X); //current state
  X=R*X;        //Calculate next state using R!
  ellipse(i*2,800-X,2,2); //visialisation!
}

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
