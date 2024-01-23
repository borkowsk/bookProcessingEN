// src: https://openprocessing.org/sketch/825836/

void setup()
{
     size(400,400);
}

void draw()
{
     //background(200);
     
     if(mouseX<=width/2)
     {
          fill(255);
     }  
     else 
     {
          fill(0);
     }
		 
     ellipse(mouseX,mouseY,50,50);
}
