/** Logistic iteration - with procedures */

float R=3.575;  //Range from 0..4
float X=0.99;   //Range 0..1!

void setup() // modifies global R,X
{
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
  
  text("R="+R,10,height-5);
  stroke(255,0,0); //In RED!
}


int t=0; ///< 't' means "time". Is global because value should be kept between `draw` calls.

void draw() // uses global t,X
{
  if(t>width) return; //Nothing more to do!
  
  println(t,X);
  //point(t,height-X*height); //Visualise as a point
  ellipse(t,height-X*height,2,2);
  X=R*X*(1-X); //Calculate next iteration

  t++; //INCREMENTATION!!!
}

/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
