/** "Vertical" of Rafał Kosik. 
 The action of this SF novel takes place in a cylindrical world 
 after a conflict with "aliens". People live in steel cities, 
 climbing ropes, pursuing an undefined Goal.
 See: https://www.goodreads.com/book/show/6615626-vertical
*/

int N=10;    // Number of cities
int space=1; // Distance between cities
float[] positions=new float[N];

void setup() // uses global N,space,positions !!!!!!
{
  size(200,1000);
  frameRate(200);
  // Calculate space
  space=width/(N+1);
  println("space:",space);
     
  // Initial positions
  for(int j=0;j<N;j++)
    positions[j]=height-1;
}

void draw() // uses global N,space,positions
{
  background(0,155,185); // also clear the window!
  
  // ropes
  for(int i=0;i<width;i+=5)
    line(i,height,i,0);
    
  // cities
  for(int j=0;j<N;j++)
  {
    ellipse((j+1)*space,positions[j],space,3); // Visualisation
    
    positions[j]-=random(2.0); // Random move
    
    if(positions[j]<0) // Checking if he has not passed the top
      positions[j]+=height;
  }
}

// https://github.com/borkowsk/bookProcessingEN
