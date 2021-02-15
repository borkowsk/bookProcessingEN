//Logistic iteration - first attempt
final float R=2.5;
float X=0.3333333;

for(int i=0;i<100;i++)//Default width == 100
{
  println(i,X);
  X=R*X*(1-X);//Calculate next iteration
}
