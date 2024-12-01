''' A General Systems Theory of Marriage: Nonlinear Difference 
 *  Equation Modeling of Marital Interaction
 *  John Gottman, Catherine Swanson, & Kristin Swanson
 *  Wt+1 = IHW(Ht)  + r1Wt + a
 *  Ht+1 = IWH(Wt+1)+ r2Ht + b
'''
'''constant double'''
a=1.1;b=0.9;r1=0.1;r2=0.1

W=0.5
H=0.5

IHW=[];IWH=[]  #?

for i in range(0,width,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i,W,H 
  W=r1*W+a  #+IHW*H
  H=r2*H+b  #+IWH*W


text("DONE",30,50)

##@date 2024-12-01 (https://github.com/borkowsk/bookProcessingEN)
