//CD image ;-) example

size(300,300);
//noSmooth();
background(0);//Black background (0 brightness)
noFill();//The contours of the ellipses themselves
stroke(255);//White outline

for(int i=150;i>30;i=i-2) //REPEAT every other time <=> i-=2
{
   ellipse(100,100,i,i);
}//Curly brackets redundant here

//https://github.com/borkowsk/bookProcessingEN
