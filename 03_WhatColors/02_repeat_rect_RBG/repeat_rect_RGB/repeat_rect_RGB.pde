//Red cards

size(500,500);
background(0,0,200);//rgB - BLUE BACKGROUND

smooth();//With line smoothing ("anti-aliasing")
rectMode(CORNERS);//Set rectMode to CORNERS

for(int i=0;i<256;i+=10) //REPEAT EVERY TEN TIMES!
{//REPEATED ACTION BEGIN
  fill(i,0,0);//Rgb - "cards" will be in shades of red
  rect(i,i,0,500); //And draw a "card"!
}//END OF THE REPEATED ACTION

//https://www.facebook.com/ProcessingWEdukacji/
//http://processingwedukacji.blogspot.com

