''' A General Systems Theory of Marriage: 
 *   Nonlinear Difference Equation Modeling of Marital Interaction
 *   John Gottman, Catherine Swanson, & Kristin Swanson
 *     Wt+1 = IHW(Ht)  + r1Wt + a
 *     Ht+1 = IWH(Wt+1)+ r2Ht + b
 '''

## For model:
'''constant double'''
IHW=0.6001;IWH=0.4001  #< Interaction values are properties of a human relationship 
'''constant double'''
a=-0.001;b=-0.001;r1=0.6;r2=0.4  #< Values describe the characters of people

W=0.5
H=0.5

## For visualisation:
'''constant double'''
DOTSIZE=2  #WARNING! DOTSIZE below 2 not work with ellipses! pr2c TODO!
'''constant double'''
scale=1

def setup(): # Is it any global variable modified inside?
  '''Purpose of the code block below is ...'''
  size(1500,500)
  line(0,height/2,width,height/2)  #Zero line


t=0  # 't' need to be global, and keep value in between of draw() calls. 

def draw(): # Is it any global variable modified inside? 
  global t,W,H
  '''Purpose of the code block below is ...'''
  if t>=width : return  #Now nothing to do more
  
  print   t,W,H 
  
  # Visualisation
  stroke(255,0,0)
  rect(t,height/2-W*scale/2*height,DOTSIZE,DOTSIZE)  #The wife is RED
  stroke(0,255,0)
  ellipse(t,height/2-H*scale/2*height,DOTSIZE,DOTSIZE)  #The husband is GREEN
  
  t+=1  #incrementation of 't'
  
  # MODEL
  W=r1*W+a+IHW*H
  H=r2*H+b+IWH*W  # Wait!? We use NEW value of W. Is this what the author of the model had in mind?



##@date 2024-12-01 (https://github.com/borkowsk/bookProcessingEN)
