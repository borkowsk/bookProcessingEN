''' Logistic iteration - first attempt '''

'''constant double'''
R=2.5 #immutable parameter
X=0.3333333 #changing state

for i in range(0,100,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i,X 
  X=R*X*(1-X)   #Calculate next iteration


text("DONE",30,55) #For default window 100x100

## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
