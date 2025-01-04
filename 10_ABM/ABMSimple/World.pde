/// The world & its dynamics.
/// @date 2025-01-04 (begin)
//*/////////////////////////////////////////////////////////////////////////////

class World
{
  Agent[][]  plane=new Agent[WSide][WSide]; //!< the surface of the world where agents "live".
  
  void initialise() //!< pre-filling the world.
  {
    plane[WSide/2][WSide/2]=new Agent(); //!< Almost as simple as possible
  }
  
  void update() //!< Updating the state of the world, i.e. the simulation step.
  {
    // We will fill this in later.
  }
}

World theWorld=null; ///< A single variable representing the world is initialized during setup.
