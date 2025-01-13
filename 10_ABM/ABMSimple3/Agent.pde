/// The agent: its atributes, random initialisation and methods
/// @date 2025-01-13 (modification)
//*/////////////////////////////////////////////////////////////////////////////

enum Dirs { UNKNOWN, N, NE, E, SE, S, SW, W, NW }; ///< all directions of the world.

Dirs[] allDirs={ Dirs.UNKNOWN,Dirs.N,Dirs.NE,Dirs.E,Dirs.SE,Dirs.S,Dirs.SW,Dirs.W,Dirs.NW };

color dirs2color(Dirs direction) //!< second version of colorisation
{
  switch(direction){
  case N:       return color(  0,  0,255);
  case NE:      return color(  0,255,255);
  case E:       return color(  0,255,  0);
  case SE:      return color(255,255,  0);
  case S:       return color(255,  0,  0);
  case SW:      return color(255,  0,120);
  case W:       return color(255,  0,255);
  case NW:      return color(120,  0,255);
  case UNKNOWN: 
  default: return color(255,255,255);
  }
}

class Agent
{
  Dirs direction=Dirs.UNKNOWN;  //!< It needs to know his walking direction.
  
  color getColor()
  {
    return dirs2color(direction);
  }
  
  void update()
  {
    if( direction==Dirs.UNKNOWN && random(1.0)<0.01 ) // Within approximately 100 steps, everyone will choose a direction
      direction=allDirs[int(random(1,allDirs.length))];
  }
  
  void interactionA(Agent other) //!< Asymmetric interaction.
  {
    other.direction=this.direction;
  }
  
  void interactionS(Agent other) //!< Symmetric interaction.
  {
    Dirs newdirection=allDirs[int(random(1,allDirs.length))]; // Agents "establish" a new common direction.
    this.direction=newdirection;
    other.direction=newdirection;
  }
} 
