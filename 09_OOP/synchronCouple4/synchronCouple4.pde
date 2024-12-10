// We defined a class, now we will use it. The most extensive example.
//-///////////////////////////////////////////////////////////////////////////////

final  float MinR=3.3; //two systems independent of each other 
final  float MaxR=3.8; //(3.5 to 4 because the sync. in chaos is the most interesting)
final  float DefaultAlpha=0.05; //by changing the alpha value we can change their synchronization

// Create new objects of type 'singiel' using the only available constructor
singiel_double First= new singiel_double(0.66, random(MinR,MaxR), 0);
singiel_double Second=new singiel_double(0.33, random(MinR,MaxR), 0);

int   runup=0;//200;

//For visualization
int N=0;          //counter of iteration steps
int lmargin=60;
int fSize=40;     //Font size
int Sf=400;       //Main scale factor
int Ws=400;       //Side of scatter plot
int Rs=400;       //Side or atractor reconstructions
int Tlh=50;       //Part hight for timelines

void setup() // uses global First,Second,N,lmargin,fSize,Sf,Ws,Rs,Tlh
{
  fullScreen(); //3*Ws , 2* Ws
  Ws=(width-lmargin)/3;
  Sf=Rs=height-Ws;
  Tlh=(Ws-2*fSize)/3;
  runup=int(Ws*0.66);
  frameRate(1000);
  ellipseMode(RADIUS); 
    
  //Scatter backround
  noStroke();
  fill(128);
  rect(lmargin,0,Ws*2,Ws);
  stroke(255);
  line(lmargin+runup,0,lmargin+runup,Tlh*3);
  fill(255);noStroke();
  rect(lmargin+2*Ws,0,Ws,Ws);
  rect(lmargin,Ws,Rs,Sf);
  rect(lmargin+Ws,Ws,Rs,Sf);
  
  // period and field name so we read field name or you can with method
  textSize(fSize*0.75);textAlign(LEFT,TOP);
  println("1st:",First.xPre()," R:",First.r," alpha:",First.alpha());
  fill(Red,0,0);text("1st.alpha:"+str(First.alpha())+" R:"+str(First.rCur())+" X:"+str(First.xPre()),lmargin,Ws-2*fSize);
  println("2st:",Second.xPre()," R:",Second.r," alpha:",Second.alpha());
  fill(0,0,Blu);text("2st.alpha:"+str(Second.alpha())+" R:"+str(Second.rCur())+" X:"+str(Second.xPre()),lmargin,Ws-fSize);
}

float scaleY(double X,float Sf)//Scaling function
{
  return Sf-(float)(X)*Sf;
}

float Gre=255;
float Blu=255;
float Red=255;

void draw() // uses global First,Second,N,lmargin,fSize,Sf,Ws,Rs,Tlh,Gre,Blu,Red
{
  next4couple(First,Second); //println("1st:",First.X1(),"\t2nd:",Second.X1());
  
  if(N<2*Ws)
  {
    stroke(Red,0,0);
    line(lmargin+N-1,scaleY(First.xPre(),Tlh),lmargin+N,scaleY(First.xCur(),Tlh));
    
    stroke(0,0,Blu);
    line(lmargin+N-1,Tlh+scaleY(Second.xPre(),Tlh),lmargin+N,Tlh+scaleY(Second.xCur(),Tlh));
    stroke(0,0,25);
  
    stroke(0,Gre,0);
    point(lmargin+N,2*Tlh+scaleY(abs(First.xCur()-Second.xCur()),Tlh));
    
    stroke(128);
    point(lmargin+N,scaleY(0,Tlh));
    point(lmargin+N,Tlh+scaleY(0,Tlh));
    point(lmargin+N,2*Tlh+scaleY(0,Tlh));
    
    if(N>runup)
    {
       noStroke();
       fill(Red,0,Blu);
       ellipse(lmargin+2*Ws+First.xCur()*Ws,scaleY(Second.xCur(),Ws),2.5,2.0);
       fill(Red,0,0);
       ellipse(lmargin+2*Ws+First.xCur()*Ws,scaleY(0,Ws),1.5,1.5);
       fill(0,0,Blu);
       ellipse(lmargin+2*Ws,scaleY(Second.xCur(),Ws),1.5,1.5);
       
       fill(Red,0,0);
       ellipse(lmargin+First.xPre()*Rs,Ws+scaleY(First.xCur(),Sf),2.5,2.5);
       ellipse(lmargin,Ws+scaleY(First.xCur(),Sf),1.5,1.5);
       ellipse(lmargin+First.xPre()*Rs,Ws+scaleY(1,Sf),1.5,1.5);
       
       fill(0,0,Blu);
       ellipse(lmargin+Ws+Second.xPre()*Rs,Ws+scaleY(Second.xCur(),Sf),2.5,2.5);
       ellipse(lmargin+Ws,Ws+scaleY(Second.xCur(),Sf),1.5,1.5);
       ellipse(lmargin+Ws+Second.xPre()*Rs,Ws+scaleY(1,Sf),1.5,1.5);
    }
    else
    {
       stroke(255,0,255);point(lmargin+2*Ws+First.xCur()*Ws,scaleY(Second.xCur(),Ws));
       stroke(255,0,0);point(lmargin+First.xPre()*Rs,Ws+scaleY(First.xCur(),Sf));
       stroke(0,0,255);point(lmargin+Ws+Second.xPre()*Rs,Ws+scaleY(Second.xCur(),Sf));
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
    First.set_alpha(DefaultAlpha);
    Second.set_alpha(DefaultAlpha); //Now coupled
    First.set_x(random(1.0));
    Second.set_x(random(1.0));
    
    Red=First.xCur()*255;  //Proportional to starting value of the First
    Blu=Second.xCur()*255; //Proportional to starting value of the Second
    Gre=abs(First.xCur()-Second.xCur())*255; //Proportional to difference
    
    // change backround???
    noStroke();
    fill(128,64);
    rect(lmargin,0,Ws*2,Ws);
    fill(255,64);
    rect(lmargin+2*Ws,0,Ws,Ws);
    rect(lmargin,Ws,Rs,Sf);
    rect(lmargin+Ws,Ws,Rs,Sf);    
    stroke(255);
    line(lmargin+runup,0,lmargin+runup,Tlh*3);
    stroke(0,Gre,0);fill(200);rect(lmargin,Ws-2*fSize,2*Ws-4,2*fSize-2);
    fill(Red,0,0);text("1st.alpha:"+str(First.alpha())+" R:"+nf((float)(First.r))+" X:"+str(First.xCur()),lmargin,Ws-2*fSize);
    fill(0,0,Blu);text("2st.alpha:"+str(Second.alpha())+" R:"+nf((float)(Second.r))+" X:"+str(Second.xCur()),lmargin,Ws-fSize);
    println("realFM:",frameRate,"\tX=",First.xPre(),Second.xPre());
  }

}

//https://github.com/borkowsk/bookProcessingEN
