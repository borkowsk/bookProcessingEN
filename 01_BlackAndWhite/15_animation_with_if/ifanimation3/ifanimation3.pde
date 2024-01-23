// src: https://openprocessing.org/sketch/825836/

void setup()
{
     size(500,500);
}

void draw()
{
     //background(200);
     
     if(mouseX<=width/2)
     {
          fill(255,255,255,128);
     }  
     else 
     {
          //fill(128,128);
          fill(128,(mouseX*1.0/width)*255);
     }
		 
     ellipse(mouseX,mouseY,50,50);
}
