// We defined a class, now we will use it. The most extensive example.
//-///////////////////////////////////////////////////////////////////////////////

final  float MinR=3.3;          //two systems independent of each other 
final  float MaxR=3.99;         //(3.5 to 4 because the sync. in chaos is the most interesting)
final  float DefaultAlpha=0.00; //by changing the alpha value we can change their mutual synchronization

int   runup=0; //200?;

singiel First, Second; // object handles

//For visualization
int N=0;        //counter of iteration steps
int lmargin=60; //for visualisation
int fSize=40;   //Font size
int Sf=400;     //Scale factor for time lines
int Ws=400;     //Side of scatter plot
int Rs=400;     //Side or atractor reconstructions

void setup() // modifies global First,Second,N,Ws,lmargin,fSize,Sf,Rs
{
  fullScreen(); //3*Ws , 2* Ws
  Ws=(width-lmargin)/3;
  Sf=Rs=height-Ws;
  runup=int(Ws*0.66);
  frameRate(1000);
  ellipseMode(RADIUS); 
  
  // Create new objects of type 'singiel' using the only available constructor
  // The handles catch whatever is created there
  First= new singiel(0.66, random(MinR,MaxR), DefaultAlpha);
  Second=new singiel(0.33, random(MinR,MaxR), DefaultAlpha);
  
  //Scatter backround
  line(lmargin+runup,0,lmargin+runup,Sf);
  fill(255);noStroke();
  rect(lmargin+2*Ws,0,Ws,Ws);
  rect(lmargin,Ws,Rs,Sf);
  rect(lmargin+Ws,Ws,Rs,Sf);
  
  // period and field name so we read field name or you can with method
  textSize(fSize*0.75);textAlign(LEFT,TOP);
  println("1st:",First.x1," R:",First.r," alpha:",First.alpha());
  fill(Red,0,0);text("1st.alpha:"+str(First.alpha())+" R:"+str(First.r)+" X:"+str(First.x1),lmargin,Ws-2*fSize);
  println("2st:",Second.x1," R:",Second.r," alpha:",Second.alpha());
  fill(0,0,Blu);text("2st.alpha:"+str(Second.alpha())+" R:"+str(Second.r)+" X:"+str(Second.x1),lmargin,Ws-fSize);
}

float scaleY(double X,float Sf) //Scaling function
{
  return Sf-(float)(X)*Sf;
}

float Gre=255;
float Blu=255;
float Red=255;

void draw() // uses global Gre,Blu,Red,N,Ws,lmargin,fSize,Sf,Rs
{
  next4couple(First,Second); //println("1st:",First.x1,"\t2nd:",Second.x1);
  
  if(N<2*Ws)
  {
    stroke(Red,0,0,25);
    line(lmargin+N-1,scaleY(First.x1,Sf),lmargin+N,scaleY(First.x2,Sf));
    
    stroke(0,0,Blu,25);
    line(lmargin+N-1,scaleY(Second.x1,Sf),lmargin+N,scaleY(Second.x2,Sf));
    stroke(0,0,25);
  
    stroke(0,Gre,0);
    point(lmargin+N,scaleY(abs(First.x2-Second.x2),Sf));
    
    stroke(128);
    point(lmargin+N,scaleY(0,Sf));
    
    stroke(0,255,0);
    point(lmargin+2*Ws+First.x2*Ws,scaleY(Second.x2,Ws));
    
    if(N>runup)
    {
       noStroke();
       fill(Red,0,Blu); ellipse(lmargin+2*Ws+First.x2*Ws,scaleY(Second.x2,Ws),2.5,2.0);
       fill(Red,0,0); ellipse(lmargin+2*Ws+First.x2*Ws,scaleY(0,Ws),1.5,1.5);
       fill(0,0,Blu); ellipse(lmargin+2*Ws,scaleY(Second.x2,Ws),1.5,1.5);
       
       fill(Red,0,0); 
       ellipse(lmargin+First.x1*Rs,Ws+scaleY(First.x2,Sf),2.5,2.5);
       ellipse(lmargin,Ws+scaleY(First.x2,Sf),1.5,1.5);
       ellipse(lmargin+First.x1*Rs,Ws+scaleY(1,Sf),1.5,1.5);
       fill(0,0,Blu);
       ellipse(lmargin+Ws+Second.x1*Rs,Ws+scaleY(Second.x2,Sf),2.5,2.5);
       ellipse(lmargin+Ws,Ws+scaleY(Second.x2,Sf),1.5,1.5);
       ellipse(lmargin+Ws+Second.x1*Rs,Ws+scaleY(1,Sf),1.5,1.5);
    }
    
    stroke(0,Gre,0);
    fill(Red,0,0,25);
    view(First,width-Ws/2,height-Rs/2, 100);
    fill(0,0,Blu,25);
    view(Second,width-Ws/2+200,height-Rs/2, 100);
    
    N++; // here we finish drawing
  }
  else
  {
    N=0;
    First.x1=First.x2=random(1.0);
    Second.x1=Second.x2=random(1.0);
    Gre=abs(First.x2-Second.x2)*255;Red=First.x2*255;Blu=Second.x2*255;
    println("realFM:",frameRate,"\tX=",First.x1,Second.x1);
    stroke(0,Gre,0);fill(200);rect(lmargin,Ws-2*fSize,2*Ws-4,2*fSize-2);
    fill(Red,0,0);text("1st.alpha:"+str(First.alpha())+" R:"+str(First.r)+" X:"+str(First.x1),lmargin,Ws-2*fSize);
    fill(0,0,Blu);text("2st.alpha:"+str(Second.alpha())+" R:"+str(Second.r)+" X:"+str(Second.x1),lmargin,Ws-fSize);
  }

}

/// @date 2025-11-24 (https://github.com/borkowsk/bookProcessingEN)
