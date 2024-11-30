''' General cell population growth. But, what does 1/3 of a cell mean? '''

X=1   #Current state
R=2.5 #Average number of mature descendants

for i in range(0,10,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i,X   #generation and state
  #parts of the cells are not allowed here :-)
  X=int(R*X)   #Calculate next state using R


text("DONE!!!",0,height)

##@date 2024 (https://github.com/borkowsk/bookProcessingEN)
