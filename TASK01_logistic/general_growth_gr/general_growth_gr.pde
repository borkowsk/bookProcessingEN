// Settings
size(210,800);
background(0);
fill(255);
stroke(128);

//General cell population growth
float X=2;   //Current state
float R=1.1; //Average number of mature descendants

for(int i=0;i<=100;i++)
{
  println(i,X);//generation and state
  X=R*X;//Calculate next state using R
  ellipse(i*2,800-X,2,2);
}

// https://github.com/borkowsk/bookProcessingEN
