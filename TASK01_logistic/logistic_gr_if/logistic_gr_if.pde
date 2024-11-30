/** Logistic iteration - with range checking */

float R=3.5;  //Range from 0..4
float X=0.99; //Range 0..1!

size(1000,300);

//checking the range of R & X
if( R > 4.0 ) println("R is too big!");
if( R < 0.0 ) println("R is too small!");

if( X > 1.0 ) println("X is too big!");
if( X < 0.0 ) println("X is too small!");

for(int i=0;i<width;i++)
{
  //println(i,X);
  ellipse(i,height-X*height,2,2);
  //point(i,height-X*height); //Visualise as a point
  X=R*X*(1-X); //It calculates next iteration.
}

text("R="+R,5,height-5);

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
