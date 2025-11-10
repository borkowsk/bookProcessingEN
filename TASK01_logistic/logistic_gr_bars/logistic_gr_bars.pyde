''' Logistic iteration with bars visialisation '''

'''constant double'''
R=3.22;   
X=0.3333333    # State. Range 0..1!

'''constant int'''
interspace=2 #Visual spacing between the beginnings of the bars.

size(800,200)
background(255)

for i in range(0,width,interspace): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i/interspace,X 
  line(i,height,i,height-X*height) #Visualise as a vertical line!
  X=R*X*(1-X) #Calculate next iteration state.


fill(128);textSize(24)
text("R="+str(R),0,height)

## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
