/// flock of birds
//-///////////////

final int     NORD_SOUTH=800; ///< maximum distance from north to south
final int     WEST_EAST=800;  ///< maximum distance from east to west
final int     MAX_CEIL=200;    ///< maximum flight ceiling
final int     HM_BIRDS=60;    ///< how many birds
final boolean TARGETED=false;  ///< Do they get their goals as part of initialization?
final boolean VIEW_TARGETING=true; ///< Show lines for current targets?

// Boids algorith parameters (see: https://people.ece.cornell.edu/land/courses/ece4760/labs/s2021/Boids/Boids.html)
final float   protectedRange=min(NORD_SOUTH,WEST_EAST)/30.0; ///< "Range where they fly away from others"
final float   protectedRangeSquared=protectedRange*protectedRange;
final float   visualRange=min(NORD_SOUTH,WEST_EAST)/15.0;   ///< "Range where they tend tooward center of mass"
final float   visualRangeSquared=visualRange*visualRange;
final float   avoidFactor=0.04;
final float   matchingFactor=0.05;
final float   centeringFactor=0.005;
final float   turnFactor=0.02;
final float   maxSpeed=10;
final float   minSpeed=6;
final float   margin=80;
final float   westMargin=margin;
final float   eastMargin=WEST_EAST-margin;
final float   nordMargin=margin;
final float   southMargin=NORD_SOUTH-margin;
final float   groundMargin=max(protectedRange,MAX_CEIL*0.05);
final float   ceilMargin=MAX_CEIL*0.95;

ArrayList<Bird> birds;         ///< all our birds in JAVA like container

void initBirds()
{
  birds=new ArrayList(HM_BIRDS); // Constructs an empty list with the specified initial capacity.
  for(int i=0;i<HM_BIRDS;i++)
    birds.add(new Bird(NORD_SOUTH,WEST_EAST,MAX_CEIL,TARGETED));
}

/// @note We assume that the birds are always properly sorted in terms of height.
void showBirds()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     float ZRatio=current.z/MAX_CEIL;
     current.showBird(2+ZRatio*25); //any way of presenting the height for now
     if(VIEW_TARGETING && current.isTargeted())
     {
       stroke(red(current.co)/2,green(current.co)/2,blue(current.co)/2);
       line(current.x,current.y,current.tx,current.ty);
     }
   }
}

void settings()
{
  size(WEST_EAST,NORD_SOUTH);
}

void setup()
{
  background(32);
  initBirds();
  sortBirds();
  showBirds();
  decisions();
  frameRate(25); // Slowly at first
  println("protectedRange:",protectedRange,"visualRange:",visualRange);
  // Comment out the two lines below if you do not need the video.
  initVideoExport(this,"boids.mp4",25);
  FirstVideoFrame();
}

void draw()
{
  moveBirds();
  sortBirds();
  background(32);
  showBirds();
  decisions();
  fill(255);
  //text(str(frameRate)+" frm/sec",10,height-10);
  //saveFrame("boids-######.png");
  NextVideoFrame();
}

void exit()
{
  noLoop();          //For to be sure...
  delay(100);        // it is possible to close window when draw() is still working!
    
  if(videoExportEnabled) CloseVideo();    //Finalise of Video export
  
  println("Thank You!");
  super.exit();       //What library superclass have to do at exit()
}

/// @date 2026-06-16 (modified)
