''' General cell population growth '''

X=1.0 #Current state
R=2.5 #Average number of mature descendants

for i in range(0,10,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i,X  #printing generation and state
  X=R*X        #Calculate next state using R!


text("DONE",30,55) #For default window 100x100

##@date 2024 (https://github.com/borkowsk/bookProcessingEN)
