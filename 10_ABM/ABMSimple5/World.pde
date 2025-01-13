/// The world & its dynamics.
/// @date 2025-01-13 (modification)
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
         
         // Requested move.
         int dcol,drow;
         switch( plane[row][col].direction ){
            case N:       dcol= 0; drow=-1; break;
            case NE:      dcol=+1; drow=-1; break;
            case E:       dcol=+1; drow= 0; break;
            case SE:      dcol=+1; drow=+1; break;
            case S:       dcol= 0; drow=+1; break;
            case SW:      dcol=-1; drow=+1; break;
            case W:       dcol=-1; drow= 0; break;
            case NW:      dcol=-1; drow=-1; break;
            case UNKNOWN: 
            default: dcol= 0; drow= 0; break;
            }
         
         // Requested position
         int ncol=(WSide+col+dcol)%WSide;
         int nrow=(WSide+row+drow)%WSide;
         
         // The action depends on the empty space in the new position.
         if(plane[nrow][ncol]==null)
         {
           plane[nrow][ncol]=plane[row][col]; // To a new place.
           plane[row][col]=null; // Very important: The normal world does not allow bilocation!
         }
         else
         {
           plane[row][col].interactionA(plane[nrow][ncol]);
         }
      }
    }  
  }
}

World theWorld=null; ///< A single variable representing the world is initialized during setup.
