//Bigger CD image ;-) example

size(300,300);
//noSmooth();
background(0);//Black background (0 brightness)
noFill();//The contours of the ellipses themselves

for(int i=250;i>30;i=i-2) //REPEAT every other time <=> i-=2
{
   stroke(100+i%4*50);//More sophisticated outline
   ellipse(width/2,height/2,i,i);//In the center of a window
}

//https://github.com/borkowsk/bookProcessingEN

