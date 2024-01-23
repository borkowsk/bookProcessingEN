// src: https://openprocessing.org/sketch/825836/

void setup()
{
     size(500,500);
     noStroke();
}

void draw()
{     
     if(mousePressed)
     {
       if(mouseButton == LEFT)
       {
            fill(255,255,255);
       }  
       else 
       {
            fill(128,128,128);
       }
       
       ellipse(mouseX,mouseY,50,50);
		 }
}
