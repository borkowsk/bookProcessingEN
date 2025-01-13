/// The world visualisation.
/// @date 2025-01-13 (modification)
//*/////////////////////////////////////////////////////////////////////////////

void visualise(World currWorld) //< There is ones more hard-to-find bug in this simulation procedure. Big plus for the finder!
{
  float CSide=width/WSide;
  float HSide=CSide/2.0;
  
  for(int row=0;row<WSide;row++)
    for(int col=0;col<WSide;col++)
      if(currWorld.plane[row][col]!=null)
      {
        fill(currWorld.plane[row][col].getColor()); 
        noStroke();
        ellipse(col*CSide-HSide,row*CSide-HSide,CSide,CSide);
      }
      else
      {
        noFill(); stroke(0);
        rect(col*CSide,row*CSide,CSide,CSide);
      }
      
   // When we finish drawing on the agent, the graphic is left with the noStroke option, which is not the default.   
   stroke(0); // This is the better solution.    
}
