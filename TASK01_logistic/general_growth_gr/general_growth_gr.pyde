''' General cell population growth in window '''

X=2   #Current state
R=1.1 #Average number of mature descendants

## Settings:
size(210,800)
background(0)
fill(255)
stroke(128)

for i in range(0,100+1,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i,X  #current state
  X=R*X        #Calculate next state using R!
  ellipse(i*2,800-X,2,2) #visialisation!


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
