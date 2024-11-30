''' Logistic iteration with graphics '''

'''constant double'''
R=3.69  #Range from 0..4
X=0.99  #Range 0..1!
size(1000,300)

for i in range(0,width,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  print   i,X 
  ellipse(i,height-X*height,2,2) #Visualise as a circle
  #point(i,height-X*height)      #Visualise as a point
  X=R*X*(1-X)                    #Calculate next iteration


text("R="+str(R),10,height-10)

##@date 2024 (https://github.com/borkowsk/bookProcessingEN)
