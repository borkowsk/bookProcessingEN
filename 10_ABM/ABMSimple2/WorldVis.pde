/// The world visualisation.
/// @date 2025-01-04 (modification)
//*/////////////////////////////////////////////////////////////////////////////

void visualise(World currWorld)
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
}
