/// RUNNING BUGS
/// @date 2025-11-03
//*//////////////////

final int   FR   = 100; //!< How many frames per second
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

//Working collision detection (It can still be done better)
void checkCollisions() //changes in_collision
{
  for(int i=0;i<Num;i++) // We clear the array before updating.
     in_collision[i]=false;
     
  for(int i=0;i<Num;i++)
  {
    for(int j=0;j<Num;j++)
    if(i!=j) // is always in collision with itself!
    {
      float distance=dist(x[i],y[i],x[j],y[j]);
      if(distance<DIAM) // A collision occurred when the distance is less than two radii.
        in_collision[i]=true; //where need we clear this?  
    }
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
    // Checking the new positions    
    if(y[i]<height-3) // Still on the way
    {
      if(x[i] < 0 || width < x[i] || in_collision[i])
        vx[i]=-vx[i]; // Changes in the direction of the X component of the velocity
    }
    else // Target line achieved
    {
      vy[i]=0;
      vx[i]=0;
    }
    
    y[i]+=vy[i]/FR; // Vertical speed is in pixels per second!
    x[i]+=vx[i]/FR; // Horisontal speed is in pixels per second!
  }
  
  checkCollisions();
}

void setup() // changes global y0,y,x,vx,vy
{
  size(500,500);
  y0=height/20;
  
  noSmooth();
  frameRate(FR);
  stroke(255);
  fill(0);
  float a=width/(Num+1.0); // Distance between starting positions
  for(int i=0;i<Num;i++) // Initialize positions and speeds
  {
    y[i]=y0;     
    x[i]=i*a+a/2; // a/2 prevents starting on the edge
    vy[i]=random(minv,maxv); // Y speeds
    vx[i]=random(-maxv/2,maxv/2); // X speeds could be negative.
  }
}

// https://github.com/borkowsk/bookProcessingEN
