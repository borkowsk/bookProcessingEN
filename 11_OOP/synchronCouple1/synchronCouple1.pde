// Another example of using the same class 'singiel'
// we defined a class, now we will use it
//-//////////////////////////////////////////////////

final  float DefaultR=3.5;     //two systems independent of each other (3.5 to 4 because the sync. in chaos is the most interesting)
final  float DefaultAlpha=0.1; //by changing the alpha value we can change their mutual synchronization
final  int   runup=100;

singiel First;  // These are object handles, the fact that we declare them 
singiel Second; // doesn't mean that the objects exist!
                // Objects will be built further
                       
                     
void setup() // modifies global First,Second
{
  size(1200,400);
  frameRate(300);
  
  // Create new objects of type 'singiel' using the only available constructor
  // The handles catch whatever is created there
  First =new singiel(random(1.0), DefaultR+random(0.5), DefaultAlpha);
  Second=new singiel(random(1.0), DefaultR+random(0.5), DefaultAlpha);
   
  // period and field name so we read field name or you can with method
  println("1st:",First.x1," r:",First.r," alfa:"+str(First.alpha()));
  println("2st:",Second.x1," r:",Second.r," alfa:"+str(Second.alpha()));
}

// For visualization
int N=0;      //counter of iteration steps
int Sf=400;   //Scale factor

float scaleY(double X) //Scaling function
{
  return Sf-(float)(X)*Sf;
}

float Gre=255;
float Blu=255;
float Red=255;

void draw() // uses global N,Sf,Gre,Blu,Red
{
  First.next();
  Second.next();   // println("1st:",First.x1,"\t2nd:",Second.x1); //Control printout
  
  if(N<2*Sf)
  {
    stroke(Red,0,0,25);
    line(N-1,scaleY(First.x1),N,scaleY(First.x2));
    
    stroke(0,0,Blu,25);
    line(N-1,scaleY(Second.x1),N,scaleY(Second.x2));
    
    stroke(0,Gre,0);
    point(N,scaleY(abs(First.x2-Second.x2))); //difference between partners
    
    if(N>runup)//atractor
    {
       ellipse(2*Sf+First.x2*Sf,scaleY(Second.x2),4.0,4.0);       
    }
    else point(2*Sf+First.x2*Sf,scaleY(Second.x2)); //route to the attractor
    
    N++;
  }
  else
  {
    N=0; //We start the iteration from scratch with different starting values
    First.x2=random(1.0);
    Second.x2=random(1.0);
    Gre=random(255);Blu=random(255);Red=random(255);
    println("realFM:",frameRate,"\tX=",First.x1,Second.x1);
  }

}

/// @date 2025-11-24 (https://github.com/borkowsk/bookProcessingEN)
