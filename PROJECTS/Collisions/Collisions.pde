int circles = 50;
boolean torus=true;

boolean trace=false;
int diameter=25;
int radius=diameter/2;
float maxspeed=1;
int FRAMERATE=200;
int VISFREQ=4;//every N

float[] xpos = new float[circles];
float[] ypos = new float[circles];
float[] xspeed = new float[circles];
float[] yspeed = new float[circles];

boolean[] ischild = new boolean[circles];
float[] wellbeing = new float[circles];//Moving average of interactions results

//Parents - bounded confidence
//Children - wellbeing with treshold (?) const-diff(attitudes)   
//           Where const +-= confidence treshold
//


boolean[] circon = new boolean[circles];//??
color[] circolor = new color[circles];//Atitude?

boolean[] collision = new boolean[circles];//?

boolean freePosition(int i)
{
  for(int j=0;j<circles;j++)
      if( j!=i 
      && dist(xpos[i],ypos[i],xpos[j],ypos[j])<=diameter )
            return false;
  return true;
}

void setup(){
  size(1000,600);
  smooth();
  background(0);
  frameRate(FRAMERATE);
  strokeWeight(2);//not neded

  for(int i=0;i<circles;i++){
    do{
    xpos[i] = diameter/2+random(width-diameter);
    ypos[i] = diameter/2+random(height-diameter);
    }while(!freePosition(i));
    xspeed[i] = random(maxspeed*0.2,maxspeed)*(random(1.0)<0.5?-1:1);
    yspeed[i] = random(maxspeed*0.2,maxspeed)*(random(1.0)<0.5?-1:1);
    ischild[i] = random(1.0)<0.5;
    circon[i] = true;
    circolor[i] = color(255);
    collision[i] = false;
    wellbeing[i]= random(255);
  }
}

void visualisation()
{
  if(!trace) background(0);
  else { fill(0,1);rect(0,0,width,height);}
  for(int i=0;i<circles;i++){
    fill(circolor[i]);
    if(ischild[i]) stroke(wellbeing[i],wellbeing[i],0);
    else noStroke();
    ellipse(xpos[i],ypos[i],diameter,diameter);
  }
}

void movement()
{
  for(int i=0;i<circles;i++){
    ypos[i]+=yspeed[i];
    xpos[i]+=xspeed[i];
    
    if(torus)
    {
      if(xpos[i]<0) xpos[i]=width-xpos[i];
      else
      if(xpos[i]>width) xpos[i]-=width;
      
      if(ypos[i]<0) ypos[i]=height-ypos[i];
      else
      if(ypos[i]>height) ypos[i]-=height;
    }
    else //Borders detection should depend on circle radius!
    {
      if(ypos[i]>(height-radius) || ypos[i]<radius)
        yspeed[i]*=-1;
      
      if(xpos[i]>(width-radius) || xpos[i]<radius)
        xspeed[i]*=-1;
    }
  }  
}

void findcollisions()
//It detects collisions and triggers appropriate reaction procedures
{
    for(int i=0;i<(circles-1);i++){
     for(int j=(i+1);j<circles;j++){ 
      if( dist(xpos[i],ypos[i],xpos[j],ypos[j]) < diameter ){
          
          physicalCollision(i,j);
          
          if(ischild[i]) childReaction(i,j);
          else parentReaction(i,j);
          
          if(ischild[j]) childReaction(j,i);
          else parentReaction(j,i);
          
          //Prevent multiple reactions
          collision[i]=true;
          collision[j]=true;
      }
     }
    }
    
    for(int i=0;i<circles;i++) collision[i]=false;//Clear collisions
}

void physicalCollision(int i,int j)
//Elastic rebound, i.e. the physical reaction to collisions
{
  if(collision[i]==false){
     xspeed[i] *= -1;
     yspeed[i] *= -1;
  }
  
  if(collision[j]==false){
     xspeed[j] *= -1;
     yspeed[j] *= -1;
  }
}

void childReaction(int i,int j)
// i-th agent reacts, j-th agent supplies data only!
{
  if(collision[i]==false){
    //... YOUR CODE
    //eg.:
    circolor[i]=color(random(255),random(255),random(255));
  }
}

void parentReaction(int i,int j)
// i-th agent reacts, j-th agent supplies data only!
{
  if(collision[i]==false){
    //... YOUR CODE
    //eg.:
    circolor[i]=color(0.9*red(circolor[i])+0.1*red(circolor[j]),
                      0.9*green(circolor[i])+0.1*green(circolor[j]),
                      0.9*blue(circolor[i])+0.1*blue(circolor[j]));
  }
}

void draw(){
  if(frameCount%VISFREQ==0)visualisation();
  movement(); 
  findcollisions();
}
