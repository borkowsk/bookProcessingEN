/// flock of birds
//-///////////////

final int     NORD_SOUTH=1000; ///< maximum distance from north to south
final int     EAST_WEST=1000;  ///< maximum distance from east to west
final int     MAX_CEIL=100;    ///< maximum flight ceiling
final int     HM_BIRDS=100;    ///< how many birds
final boolean targeted=false;  ///< Do they get their goals as part of initialization?

// Boids algorith parameters (see: https://people.ece.cornell.edu/land/courses/ece4760/labs/s2021/Boids/Boids.html)
final float   protectedRange=min(NORD_SOUTH,EAST_WEST)/50.0; ///< "Range where they fly away from others"
final float   protectedRangeSquared=protectedRange*protectedRange;
final float   visualRange=min(NORD_SOUTH,EAST_WEST)/15.0;   ///< "Range where they tend ttoward center of mass"
final float   visual_range_squared=visualRange*visualRange;
final float   avoidfactor=0.04;
final float   matchingfactor=0.05;
final float   centeringfactor=0.005;
final float   turnfactor=0.02;
final float   maxspeed=4;
final float   minspeed=2;
final float   margin=100;
final float   leftmargin=margin;
final float   rightmargin=EAST_WEST-margin;
final float   topmargin=margin;
final float   bottommargin=NORD_SOUTH-margin;

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
     current.showBird(2+ZRatio*20); //any way of presenting the height for now
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
  background(32);
  showBirds();
  decisions();
}

/// @date 2026-01-15 (modified)
