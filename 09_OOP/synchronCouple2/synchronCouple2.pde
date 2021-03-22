// We defined a class, now we will use it. The most extensive example.
/////////////////////////////////////////////////////////////////////////////////

final  float DefaultR=3.5;//two systems independent of each other (3.5 to 4 because the sync. in chaos is the most interesting)
final  float DefaultAlpha=0.1;//by changing the alpha value we can change their mutual synchronization
final  int   runup=200;

singiel First, Second;// object handles

int Ws=400;                      
void setup()
{
  size(1200,800);//3*Ws , 2* Ws
  frameRate(1000);
  
  // Create new objects of type 'singiel' using the only available constructor
  // The handles catch whatever is created there
  First= new singiel(random(1.0), DefaultR+random(0.5), DefaultAlpha);
  Second=new singiel(random(1.0), DefaultR+random(0.5), DefaultAlpha);
  
  // period and field name so we read field name or you can with method
  println("1st:",First.x1+" "+First.r+" alfa:"+First.alpha());
  println("2st:",Second.x1+" "+Second.r+" alfa:"+Second.alpha());
}

//For visualization
int N=0;//counter of iteration steps
int Sf=400;//Scale factor

float scaleY(double X)//Scaling function
{
  return Sf-(float)X*Sf;
}

float Gre=255;
float Blu=255;
float Red=255;

void draw()
{
  next4couple(First,Second); //println("1st:",First.x1,"\t2nd:",Second.x1);
  
  if(N<2*Ws)
  {
    stroke(Red,0,0,25);
    line(N-1,scaleY(First.x1),N,scaleY(First.x2));
    
    stroke(0,0,Blu,25);
    line(N-1,scaleY(Second.x1),N,scaleY(Second.x2));
    stroke(0,0,25);
  
    stroke(255);
    point(N,scaleY(abs(First.x2-Second.x2)));
    
    stroke(0,255,0);
    point(2*Ws+First.x2*Ws,scaleY(Second.x2));
    
    if(N>runup)
    {
       noStroke();
       fill(0,Gre,0);ellipse(2*Ws+First.x2*Ws,scaleY(Second.x2),2.5,2.0);
       fill(Red,0,0);ellipse(First.x1*Ws,Ws+scaleY(First.x2),2.5,2.0);
       fill(0,0,Blu);ellipse(Ws+Second.x1*Ws,Ws+scaleY(Second.x2),2.5,2.0);
    }
    
    stroke(255);
    fill(Red,0,0,25);
    view(First,width-Ws/2,height-Ws/2, 50);
    fill(0,0,Blu,25);
    view(Second,width-Ws/2+100,height-Ws/2, 50);
    
    N++; // here we finish drawing
  }
  else
  {
    N=0;
    First.x2=random(1.0);
    Second.x2=random(1.0);
    Gre=random(255);Blu=random(255);Red=random(255);
    println("realFM:",frameRate,"\tX=",First.x1,Second.x1);
  }

}
