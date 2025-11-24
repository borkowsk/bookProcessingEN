## We defined a class, now we will use it. The most extensive example.
##-##============================================================================
from adhoclib import * 


'''constant double'''
DefaultR=3.5      #two systems independent of each other (3.5 to 4 because the sync. in chaos is the most interesting)
'''constant double'''
DefaultAlpha=0.1  #by changing the alpha value we can change their mutual synchronization
'''constant int'''
runup=200

First =[]; Second=[]  # object handles

Ws=400;      

def setup(): # Is it any global variable modified inside? 
  global First,Second
  '''Purpose of the code block below is ...'''
  size(1200,800)  #3*Ws , 2* Ws
  frameRate(1000)
  
  # Create new objects of type 'singiel' using the only available constructor
  # The handles catch whatever is created there
  First=  singiel.make_singiel3(random(1.0), DefaultR+random(0.5), DefaultAlpha) #
  Second= singiel.make_singiel3(random(1.0), DefaultR+random(0.5), DefaultAlpha) #
  
  # period and field name so we read field name or you can with method
  print   "1st:",First.x1," R:",First.r," alfa:",First.alpha() 
  print   "2st:",Second.x1," R:",Second.r," alfa:",Second.alpha() 


##For visualization
N=0  #counter of iteration steps
Sf=400  #Scale factor

def scaleY(X): # Should return float #Scaling function
  '''Purpose of the code block below is ...'''
  return Sf-(float)(X)*Sf


Gre=255
Blu=255
Red=255

def draw(): # Is it any global variable modified inside? 
  global Ws,N,Sf,Gre,Blu,Red
  '''Purpose of the code block below is ...'''
  next4couple(First,Second)
  
  if N<2*Ws :
    # block:
    stroke(Red,0,0,25)
    line(N-1,scaleY(First.x1),N,scaleY(First.x2))
    
    stroke(0,0,Blu,25)
    line(N-1,scaleY(Second.x1),N,scaleY(Second.x2))
    stroke(0,0,25)
  
    stroke(255)
    point(N,scaleY(abs(First.x2-Second.x2)))
    
    stroke(0,255,0)
    point(2*Ws+First.x2*Ws,scaleY(Second.x2))
    
    if N>runup :
      # block:
       noStroke()
       fill(0,Gre,0);ellipse(2*Ws+First.x2*Ws,scaleY(Second.x2),2.5,2.0)
       fill(Red,0,0);ellipse(First.x1*Ws,Ws+scaleY(First.x2),2.5,2.0)
       fill(0,0,Blu);ellipse(Ws+Second.x1*Ws,Ws+scaleY(Second.x2),2.5,2.0)
    
    
    stroke(255)
    fill(Red,0,0,25)
    view(First,width-Ws/2,height-Ws/2, 50)
    fill(0,0,Blu,25)
    view(Second,width-Ws/2+100,height-Ws/2, 50)
    
    N+=1  # here we finish drawing
  
  else :
    # block:
    N=0
    First.x2=random(1.0)
    Second.x2=random(1.0)
    Gre=random(255);Blu=random(255);Red=random(255)
    print   "realFM:",frameRate,"\tX=",First.x1,Second.x1 
  



## @date 2025-11-24 (https://github.com/borkowsk/bookProcessingEN)
