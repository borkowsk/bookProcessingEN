/// The world statistics.
/// @date 2025-01-04 (begin)
//*/////////////////////////////////////////////////////////////////////////////

int[] allCounts=null; ///< pedestrian/walkers direction counters.

void census(World currWorld)
{
  // Preparation...
  if(allCounts==null)
  {
    allCounts=new int[allDirs.length]; // We need new one.
  }
  else
  {
    for(int i=0;i<allCounts.length;i++) // we just reset the counters.
      allCounts[i]=0;
  }
    
  // Real counting:
  for(int row=0;row<WSide;row++)
    for(int col=0;col<WSide;col++)
      if(currWorld.plane[row][col]!=null)
      {
         Dirs tmp=currWorld.plane[row][col].direction;
         int  ind=tmp.ordinal(); // which one direction in order
         allCounts[ind]++;
      }
      
  // Simplest presentation:    
  for(int i=0;i<allCounts.length;i++)
    print("\t",allCounts[i]);
   
  println(" ----- Step:",nf(frameCount,9),"-----");  
}
