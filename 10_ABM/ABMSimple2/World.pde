/// The world & its dynamics.
/// @date 2025-01-04 (modification)
//*/////////////////////////////////////////////////////////////////////////////

class World
{
  Agent[][]  plane=new Agent[WSide][WSide]; //!< the surface of the world where agents "live".
  int        numberOfAgents=0;              //!< actual number of agents.
  
  void initialise() //!< pre-filling the world
  {
    for(int row=0;row<WSide;row++)
     for(int col=0;col<WSide;col++)
      if(random(1.0)<Density) // Agents are only in certain places.
      {
        plane[row][col]=new Agent();
        numberOfAgents++;
      }
  }
  
  void update() //!< Monte Carlo update of the world, i.e. the simulation step.
  {
    int square=WSide*WSide;
    for(int i=0;i<square;i++)
    {
      int col=int(random(0,WSide));
      int row=int(random(0,WSide));
      if(plane[row][col]!=null)
      {
         plane[row][col].update();
         // Moves & interactions later on.
      }
    }  
  }
}

World theWorld=null; ///< A single variable representing the world is initialized during setup.
