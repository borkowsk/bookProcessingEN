''' A General Systems Theory of Marriage: 
 * Nonlinear Difference Equation Modeling of Marital Interaction
 * John Gottman, Catherine Swanson, and Kristin Swanson
 * Wt+1 = IHW(Ht)  + r1Wt + a
 * Ht+1 = IWH(Wt+1)+ r2Ht + b
 '''

##For model:
'''constant double'''
IHW=0.600;IWH=0.400  #Interaction values are properties of a human relationship 
'''constant double'''
a=-0.002;b=0.002;r1=0.6;r2=0.4  #Values describe the characters of people

W=0.75
H=0.25

##For visualisation:
'''constant double'''
DOTSIZE=2  #bigger points
'''constant double'''
scale=1

size(500,200)

for i in range(0,width,DOTSIZE+1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i,W,H 
  #Visualisation
  stroke(255,0,0)  #The wife is RED
  ellipse(i,height-W*scale*height,DOTSIZE,DOTSIZE)
  stroke(0,255,0)  #The husband is GREEN
  ellipse(i,height-H*scale*height,DOTSIZE,DOTSIZE)
  #NEW MODEL STATE:
  W=r1*W+a+IHW*H
  H=r2*H+b+IWH*W


print "DONE",

##@date 2024-12-01 (https://github.com/borkowsk/bookProcessingEN)
