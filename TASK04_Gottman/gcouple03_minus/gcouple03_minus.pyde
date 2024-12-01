''' A General Systems Theory of Marriage: 
*    Nonlinear Difference Equation Modeling of Marital Interaction
*    John Gottman, Catherine Swanson, & Kristin Swanson
*    Wt+1 = IHW(Ht)  + r1Wt + a
*    Ht+1 = IWH(Wt+1)+ r2Ht + b
'''

##For model:
'''constant double'''
IHW=0.6001;IWH=0.4001   #Interaction values are properties of a human relationship 
'''constant double'''
a=-0.001;b=-0.001;r1=0.6;r2=0.4   #Values describe the characters of people

W=0.5
H=0.5

##For visualisation:
'''constant double'''
DOTSIZE=1
'''constant double'''
scale=1

size(1500,500)
line(0,height/2,width,height/2)  #Zero line

for i in range(0,width,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i,W,H   #Step states...
  #Visualisation:
  stroke(255,0,0)
  ellipse(i,height/2-W*scale/2*height,DOTSIZE,DOTSIZE)  #The wife is RED
  stroke(0,255,0)
  ellipse(i,height/2-H*scale/2*height,DOTSIZE,DOTSIZE)  #The husband is GREEN
  #MODEL:
  W=r1*W+a+IHW*H
  H=r2*H+b+IWH*W  # new value of W?


print "DONE",

##@date 2024-12-01 (https://github.com/borkowsk/bookProcessingEN)
