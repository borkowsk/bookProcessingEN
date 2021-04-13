/*
A code trying to attempt to model trans-youth individuals' acceptance while interacting with others (adults) in an environment. 

Adults acceptance (non-trans individuals) would have an acceptance label of 'full' or maximum, possibly represented by a color value (ie. 255), where their views of acceptance towards trans-individuals are either completely unaccepting, intermediate, or fully accepting.

We are having circles colliding and changing color upon collision but there are some issues:

1. We are having trouble getting the circles to collide with no overlap.
2. Assigning a 'circle within a circle' or a thick outline around each adults' circle 
   (the colored outline differing from inside would represent adult opinion)... and a 
   colored outline around trans youth circles representing wellbeing
3. Assigning values to each circle (ie. if blue circle with a neutral color outline of wellbeing (trans youth) collides with a red/non accepting adult outline (different color inside to represent adult)... the well being (neutral color of trans youth outline) will change to represent a lower well being... and so on.

I have pasted the code below so you have an idea of where we are at, I just wanted to see if you had any insight on how to code for this.

Best,
Brittany
*/
boolean trace=false;
int circles = 50;

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
    xpos[i] = diameter/2+random(width-diameter);//(i+3)*60;//WB: Why?
    ypos[i] = diameter/2+random(height-diameter);//(i+5)*5;//WB: Why?
    }while(!freePosition(i));
    xspeed[i] = random(-maxspeed,maxspeed);//WB --> Have to be bidirectional!
    yspeed[i] = random(maxspeed*0.2,maxspeed)*(random(1.0)<0.5?-1:1);//WB: alternative method
    ischild[i] = random(1.0)<0.5;
    circon[i] = true;
    circolor[i] = color(255);
    collision[i] = false;
    wellbeing[i]= random(255);//WB
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
    ellipse(xpos[i],ypos[i],diameter,diameter);//WB --> diameter
  }
}

void movement()
{
  for(int i=0;i<circles;i++){
    ypos[i]+=yspeed[i];
    xpos[i]+=xspeed[i];
    //WB: Borders detection should depend on circle diameters!
    if(ypos[i]>(height-radius) || ypos[i]<radius){
      yspeed[i]*=-1;
    }
    if(xpos[i]>(width-radius) || xpos[i]<radius){
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
  findcollisions();// or ...
  //findcollisionsOld();
}


void findCollisionsOld()
{
  //WB: Comment all actions below!
  for(int i=0;i<(circles-1);i++){
    for(int j=(i+1);j<circles;j++){ 
      if((dist(xpos[i],ypos[i],xpos[j],ypos[j])<=diameter) //WB --> diameter
      && collision[i]==false && collision[j]==false){
        collision[i]=true;
        collision[j]=true;
        
        if(circon[i]==true){
          circon[i]=false;
          circolor[i] = color(255,255,0);
        }
        else if(circon[i]==false){
          circon[i]=true;
          circolor[i] = color(255);
        }
        
        if(circon[j]==true){
          circon[j]=false;
          circolor[j] = color(255,255,0);
        }
        else if(circon[j]==false){
          circon[j]=true;
          circolor[j] = color(255);
        }
        
      }
      else                             
      if((dist(xpos[i],ypos[i],xpos[j],ypos[j])>diameter) //WB --> diameter
      && collision[i]==true && collision[j]==true){
        collision[i]=false;
        collision[j]=false;
      }
      if(collision[i]==true && collision[j]==true){
        if((xspeed[i] > 0 && xspeed[j] < 0) || (xspeed[i] < 0 && xspeed[j] > 0)){
            xspeed[i] *= -1;
            xspeed[j] *= -1;
          }
          if((yspeed[i] > 0 && yspeed[j] < 0) || (yspeed[i] < 0 && yspeed[j] > 0)){
            yspeed[i] *= -1;
            yspeed[j] *= -1;
        }
      }
    }
  }
}
