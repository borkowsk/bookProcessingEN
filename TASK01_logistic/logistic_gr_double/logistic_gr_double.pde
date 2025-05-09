/** Logistic iteration - calculation on doubles */

final double R=3.45;
double X=0.3333333; //Range 0..1!

size(1600,600);

for(int i=0;i<width;i++) //Whole window width.
{
  println(i,X);
  //When use double in calculation, result is double, but point() expected floats
  point(i, (float)(height-X*height) ); // so we use so called "cast" into float.
  X=R*X*(1-X); //Calculate next iteration
}

text("R="+str((float)(R)),5,height-10); //Change precision to float because `str` does not accepts double.

//@date 2024 https://github.com/borkowsk/bookProcessingEN
