/// A class describing a bird in a separate tab and file.
class Bird
{
  float x,y,z;     //!< position
  float vx,vy,vz;  //!< speed vector
  float tx,ty,tz;  //!< position of current goal
  color co; //!< we need color to distinguish birds
  
  Bird(float north_south,float east_west,float down_up)
  {
    co=color(random(256),random(256),random(256));
    vx=vy=vz=0; 
    tx=random(north_south);
    ty=random(east_west);
    tz=0;
    x=random(north_south);
    y=random(east_west);
    z=down_up/2+random(down_up/2);
  }
  
} //end_of_class

/// @date 2025-11-25 (modified)
