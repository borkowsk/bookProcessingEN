/// flock of birds
//-///////////////

final int     NORD_SOUTH=1000; ///< maximum distance from north to south
final int     EAST_WEST=1000;  ///< maximum distance from east to west
final int     MAX_CEIL=100;    ///< maximum flight ceiling
final int     HM_BIRDS=100;    ///< how many birds
final boolean targeted=false;  ///< Do they get their goals as part of initialization?

// Boids algorith parameters (see: https://people.ece.cornell.edu/land/courses/ece4760/labs/s2021/Boids/Boids.html)
final float   privateRange=min(NORD_SOUTH,EAST_WEST)/100.0; ///< "Range where they fly away from others"
final float   visualRange=min(NORD_SOUTH,EAST_WEST)/10.0;   ///< "Range where they tend ttoward center of mass"
final float   avoidfactor=0.03;
final float   matchingfactor=0.05;
final float   centeringfactor=0.001;
final float   turnfactor=0.2;
final float   maxspeed=4;
final float   minspeed=2;

ArrayList<Bird> birds;         ///< all our birds in JAVA like container

void initBirds()
{
  birds=new ArrayList(HM_BIRDS); // Constructs an empty list with the specified initial capacity.
  for(int i=0;i<HM_BIRDS;i++)
    birds.add(new Bird(NORD_SOUTH,EAST_WEST,MAX_CEIL,targeted));
}

/// @note We assume that the birds are always properly sorted in terms of height.
void showBirds()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     float ZRatio=current.z/MAX_CEIL;
     current.showBird(2+ZRatio*50); //any way of presenting the height for now
     if(current.isTargeted())
     {
       stroke(red(current.co),green(current.co),blue(current.co));
       line(current.x,current.y,current.tx,current.ty);
     }
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
  decisions();
  frameRate(20); // Slowly at first
}

void draw()
{
  moveBirds();
  sortBirds();
  background(64);
  showBirds();
  decisions();
}

/// @date 2025-12-10 (modified)