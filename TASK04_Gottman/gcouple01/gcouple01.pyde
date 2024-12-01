''' A General Systems Theory of Marriage: 
 *  Nonlinear Difference Equation Modeling of Marital Interaction 
 *  by John Gottman, Catherine Swanson, & Kristin Swanson
 *    Wt+1 = IHW(Ht)  + r1Wt + a
 *    Ht+1 = IWH(Wt+1)+ r2Ht + b
''' 

##For model:
IHW=[];IWH=[]  #We will use it later
'''constant double'''
a=1.1;b=0.9;r1=0.1;r2=0.1  #Values describe the characters of people
W=0.5
H=0.5

##For visualisation:
'''constant double'''
scale=0.5

size(600,200)

for i in range(0,width,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i,W,H 
  #Visualisation:
  stroke(255,0,0)
  point(i,height-W*scale*height)
  stroke(0,255,0)
  point(i,height-H*scale*height)
  #Model initial stage. NO INTERACTION!
  W=r1*W+a  #+IHW*H
  H=r2*H+b  #+IWH*W


print   "DONE" 

##@date 2024-12-01 (https://github.com/borkowsk/bookProcessingEN)
