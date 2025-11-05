// Using mouse position with event handler
// src: https://openprocessing.org/sketch/825836/

void setup()
{
     size(500,500);
     noStroke();
     frameRate(10); // Test what happened when rate is small (1..3)
}

void mousePressed()
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

void draw()
{
  // Only this one procedure put drawing to screen!
}


// https://github.com/borkowsk/bookProcessingEN
