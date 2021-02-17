float a=random(1.0);//This variable is outside loop
                    //But in fact is local, in invisible 
                    //setup subroutine!
for(int i=0;i<100;i++)
{
  println(a);   //Printed on the console - why first?
  a=random(1.0);//A new random number in the range 0..1
  point(i,a*100);
}  

//https://github.com/borkowsk/bookProcessingEN
