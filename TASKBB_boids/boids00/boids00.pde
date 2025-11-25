/// flock of birds
//-///////////////

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
    z=random(down_up);
  }
  
} //end_of_class

final int NORD_SOUTH=1000; ///< maximum distance from north to south
final int EAST_WEST=1000;  ///< maximum distance from east to west
final int MAX_CEIL=100;    ///< maximum flight ceiling
final int HM_BIRDS=20;     ///< how many birds

ArrayList<Bird> birds;     ///< all our birds in JAVA like container

void initBirds()
{
  birds=new ArrayList(HM_BIRDS); // Constructs an empty list with the specified initial capacity.
  for(int i=0;i<HM_BIRDS;i++)
    birds.add(new Bird(NORD_SOUTH,EAST_WEST,MAX_CEIL));
}

/// @note We assume that the birds are always properly sorted in terms of height.
void showBirds()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     float ZRatio=current.z/MAX_CEIL;
     fill(red(current.co),green(current.co),blue(current.co));
     circle(current.x,current.y,2+ZRatio*100); //any way of presenting the height for now
   }
}

void settings()
{
  size(EAST_WEST,NORD_SOUTH);
}

void setup()
{
  initBirds();
  sortBirds();
  showBirds();
}

/// @date 2025 (initial)
