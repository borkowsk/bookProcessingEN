''' Logistic iteration - Python always calculates on doubles '''

'''constant double'''
R=3.45
X=0.3333333 #Range 0..1!

size(1600,600)

for i in range(0,width,1): # loop over variable "i" #Whole window width.
  '''Purpose of the code block below is ...'''
  print   i,X 
  #When use double in calculation, result is double
  point(i, (int)(height-X*height) ) # so can convert result into float or int
  X=R*X*(1-X) #Calculate next iteration - in Python ALWAYS with double precision.


text("R="+str(R),5,height-10) # R has double precision but `str` cuts not important part off.

## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
