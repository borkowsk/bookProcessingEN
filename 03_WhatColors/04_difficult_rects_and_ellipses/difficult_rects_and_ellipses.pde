//HOMEWORK - see picture

size(500,500);
smooth();          // antyaliasing
rectMode(CORNERS); // Set rectMode to CORNERS

for(int i=0;i<=300;i+=10)
{
  fill(i,0,i);
  rect(i,i,0,500); 
}

for(int i=300;i>=0;i-=10)
{
  fill(0,i,i);
  ellipse(355,150,i,i);// Print "disc"
  ellipse(i,i,10,10);  // and  "tails"
}

//https://www.facebook.com/ProcessingWEdukacji/
//http://processingwedukacji.blogspot.com
//https://github.com/borkowsk/bookProcessingEN

