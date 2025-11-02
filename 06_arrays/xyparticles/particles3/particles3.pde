/// RUNNING BUGS
/// @date 2025-10-30
//*//////////////////

final int   FR   = 10; //!< How many frames per second
final int   Num  = 50; //!< How many bugs

final float minv = 10.0; //!< The slightest movement of the spider
final float maxv = 50.0; //!< What the greatest movement of the spider

float y0=0.0; //!< Starting height = height/D;

float[] y=new float[Num]; //!< Vertical position
float[] x=new float[Num]; //!< Horizontal position

float[] vy=new float[Num]; //!< Vertical speed in pixels per second!
float[] vx=new float[Num]; //!< Vertical speed in pixels per second!

boolean[] in_collision=new boolean[Num]; //!< Is it involved in some kind of collision?
float DIAM=6; //!< Diameter of the "insect" as a circle.

void checkCollisions() //Naive collision detection (full of errors!)
{
  for(int i=0;i<Num;i++)
  {
    for(int j=0;j<Num;j++)
    {
      float distance=dist(x[i],y[i],x[j],y[j]);
      if(distance<DIAM) // A collision occurred when the distance is less than two radii.
        in_collision[i]=true;
    }
  }
  
}

void setup() // changes global y0,y,x,vx,vy
{
  size(500,500);
  y0=height/20;
  
  noSmooth();
  frameRate(FR);
  stroke(255);
  fill(0);
    
  for(int i=0;i<Num;i++) // Initialize Positions and Speeds
  {
    y[i]=y0;  // Initial vertical positions         
    x[i]=random(width); // Horizontal positions
    vy[i]=random(minv,maxv); // Vertical speeds
    vx[i]=random(-maxv/2,maxv/2); // Horisontal speeds could be negative.
  }
}
              
void draw() // changes global y,x,vx,vy
{
  // Visualisation
  background(0,0,200); // rgB

  for(int i=0;i<Num;i++) // Visualisation
  {
    if(in_collision[i]) fill(255);
    else fill(0);
    ellipse(x[i],y[i],DIAM,DIAM);
  }

  for(int i=0;i<Num;i++) // Change of positions
  {
    y[i]+=vy[i]/FR; // Vertical speed is in pixels per second!
    x[i]+=vx[i]/FR; // Horisontal speed is in pixels per second!
    
    // Checking the new positions    
    if(y[i]<height-3) // Still on the way
    {
      if(x[i] < 0 || width < x[i])
        vx[i]=-vx[i]; // Changes in the direction of the horisontal component of the velocity vector to the opposite
    }
    else // Target line achieved
    {
      vy[i]=0;
      vx[i]=0;
    }
  }
  
  checkCollisions();
}

// https://github.com/borkowsk/bookProcessingEN
