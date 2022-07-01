// FALLING SPIDERS
//*//////////////////////////////////////////////////////////////////////

final int Num=10;    //How many spiders
final float minv=10; //The slightest movement of the spider
final float maxv=50; //What the greatest movement of the spider

float[] h=new float[Num]; //Vertical position
float[] x=new float[Num]; //Horizontal position
float[] v=new float[Num]; //Vertical speed in pixels per second!

float y0=0;      //Starting height = height/D;
final int FR=10; //How many frames per second

void setup()
{
  size(500,500);
  y0=height/20;
  
  noSmooth();
  frameRate(FR);
  stroke(255);
  fill(0);
    
  for(int i=0;i<Num;i++) //Initialize Positions and Speeds
  {
    h[i]=y0;  //Initial vertical position         
    x[i]=random(width); //Horizontal position
    v[i]=random(minv,maxv); //Vertical speed
  }
}
              
void draw()
{
  // Visualisation
  background(0,0,200); //rgB
  line(0,y0,width,y0); //horizontal "rope"
  
  for(int i=0;i<Num;i++) //Visualisation
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
  
  for(int i=0;i<Num;i++) //Change of positions
  {
    h[i]+=v[i]/FR; //Speed is in pixels per second!
  }
}

// https://github.com/borkowsk/bookProcessingEN
