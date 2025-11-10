/** Logistic iteration with bars visialisation */

final float R=3.22;   
float X=0.3333333;    // State. Range 0..1!

final int interspace=2; //Visual spacing between the beginnings of the bars.

size(800,200);
background(255);

for(int i=0;i<width;i+=interspace)
{
  println(i/interspace,X);
  line(i,height,i,height-X*height); //Visualise as a vertical line!
  X=R*X*(1-X); //Calculate next iteration state.
}

fill(128);textSize(24);
text("R="+R,0,height);

/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
