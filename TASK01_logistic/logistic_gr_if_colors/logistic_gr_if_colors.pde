/** Logistic iteration - almost everything possible without procedures */

float R=3.575;  //Range from 0..4
float X=0.99;   //Range 0..1!

size(1000,300);

//checking the range of R
if( R >= 4.0 ) { 
  R=4.0; println("R is too big!"); 
}

if( R <= 0.0 ) { 
  R=0.0; println("R is too small!"); 
}

println("Current R=",R);
   
if( X > 1.0 ) println("X is too big!");
if( X < 0.0 ) println("X is too small!");

stroke(255,0,0); //In RED!

for(int i=0;i<width;i++)
{
  //println(i,X);
  ellipse(i,height-X*height,2,2);
  //point(i,height-X*height); //Visualise as a point
  X=R*X*(1-X); //Calculate next iteration
}

text("R="+R,0,height-10);

/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
