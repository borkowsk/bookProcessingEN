//Logistic iteration - bars in color
final float R=3.87;
float X=0.3333333;//Range 0..1!

final int interspace=2;//spacing between the beginnings of the bars

size(800,200);
background(255);

for(int i=0;i<width;i+=interspace)
{
  println(i/interspace,X);
  stroke(0,X*255,(1-X)*255);//green-blue mix
  line(i,height,i,height-X*height);//Visualise as a vertical line
  X=R*X*(1-X);//Calculate next iteration
}

fill(128,0,0);textSize(24);
text("R="+R,0,height);

//https://github.com/borkowsk/bookProcessingEN
