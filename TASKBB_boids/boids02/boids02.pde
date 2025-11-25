/// flock of birds
//-///////////////

final int NORD_SOUTH=1000; ///< maximum distance from north to south
final int EAST_WEST=1000;  ///< maximum distance from east to west
final int MAX_CEIL=100;    ///< maximum flight ceiling
final int HM_BIRDS=1;      ///< how many birds

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
     fill(red(current.co),green(current.co),blue(current.co),128);
     circle(current.x,current.y,2+ZRatio*100); //any way of presenting the height for now
     stroke(red(current.co),green(current.co),blue(current.co));
     line(current.x,current.y,current.tx,current.ty);
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


/// @date 2025-11-25 (modified)
