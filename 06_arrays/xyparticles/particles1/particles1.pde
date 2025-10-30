/// RUNNING BUGS
/// @date 2025-10-30
//*//////////////////

final int   FR   = 10; //!< How many frames per second
final int   Num  = 10; //!< How many bugs

final float minv = 10.0; //!< The slightest movement of the spider
final float maxv = 50.0; //!< What the greatest movement of the spider

float y0=0.0; //!< Starting height = height/D;

float[] y=new float[Num]; //!< Vertical position
float[] x=new float[Num]; //!< Horizontal position

float[] vy=new float[Num]; //!< Vertical speed in pixels per second!
float[] vx=new float[Num]; //!< Vertical speed in pixels per second!

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
              
void draw() // global h,x,v
{
  // Visualisation
  background(0,0,200); // rgB

  for(int i=0;i<Num;i++) // Visualisation
    if(y[i]<height-3) // Still on the way
    {
      ellipse(x[i],y[i],5,5);
    }
    else // Target line achieved
    {
      ellipse(x[i],y[i],7,3);
      vy[i]=0;
      vx[i]=0;
    }
  
  for(int i=0;i<Num;i++) // Change of positions
  {
    y[i]+=vy[i]/FR; // Vertical speed is in pixels per second!
    x[i]+=vx[i]/FR; // Horisontal speed is in pixels per second!
  }
}

// https://github.com/borkowsk/bookProcessingEN
