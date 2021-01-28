//Logistic iteration - first attempt
final float R=3.45;
float X=0.3333333;//Range 0..1!
size(900,300);

for(int i=0;i<width;i++)//Default width == 100
{
  println(i,X);
  point(i,height-X*height);//Visualise as a point
  X=R*X*(1-X);//Calculate next iteration
}

text("R="+R,0,height);
