''' Chlorella population. '''

X=1  #Current state
R=4  #Number of descendants of the cell 2,4,8 even 16

for i in range(0,10,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i,X  #printing generation and state
  X=R*X        #Calculate next state using R


text("DONE",30,55) #For default window 100x100

##@date 2024 (https://github.com/borkowsk/bookProcessingEN)
 
