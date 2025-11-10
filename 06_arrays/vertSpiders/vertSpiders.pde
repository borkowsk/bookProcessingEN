/// FALLING SPIDERS.
//*/////////////////

final int   FR   = 10; // How many frames per second
final int   Num  = 10; // How many spiders

final float minv = 10.0; // The slightest movement of the spider
final float maxv = 50.0; // What the greatest movement of the spider

float y0=0.0; // Starting height = height/D;

float[] h=new float[Num]; // Vertical position
float[] x=new float[Num]; // Horizontal position
float[] v=new float[Num]; // Vertical speed in pixels per second!

void setup() // changes global y0,h,x,v
{
  size(500,500);
  y0=height/20;
  
  noSmooth();
  frameRate(FR);
  stroke(255);
  fill(0);
    
  for(int i=0;i<Num;i++) // Initialize Positions and Speeds
  {
    h[i]=y0;  // Initial vertical positions         
    x[i]=random(width); // Horizontal positions
    v[i]=random(minv,maxv); // Vertical speeds
  }
}
              
void draw() // global h,x,v
{
  // Visualisation
  background(0,0,200); // rgB
  line(0,y0,width,y0); // horizontal "rope"
  
  for(int i=0;i<Num;i++) // Visualisation
    if(h[i]<height-3)
    {
      line(x[i],y0,x[i],h[i]);
      ellipse(x[i],h[i],5,5);
    }
    else
    {
      ellipse(x[i],h[i],7,3);
      v[i]=0;
    }
  
  for(int i=0;i<Num;i++) // Change of positions
  {
    h[i]+=v[i]/FR; // Speed is in pixels per second!
  }
}

/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
