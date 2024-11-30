/** Logistic iteration with graphics */

final float R=3.69;  //Range from 0..4
float X=0.99;  //Range 0..1!
size(1000,300);

for(int i=0;i<width;i++)
{
  println(i,X);
  ellipse(i,height-X*height,2,2); //Visualise as a circle
  //point(i,height-X*height);     //Visualise as a point
  X=R*X*(1-X);                    //Calculate next iteration
}

text("R="+R,10,height-10);

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
