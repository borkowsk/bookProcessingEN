''' General cell population COLLAPSE. '''

size(210,800)
background(0)
fill(255)
stroke(128)

X=400  #Current state
R=0.95 #Average number of mature descendants

for i in range(0,100+1,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i,X  #printing generation and state
  X=R*X        #Calculate next state using R!
  ellipse(i*2,800-X,7,7) #visualization.


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
