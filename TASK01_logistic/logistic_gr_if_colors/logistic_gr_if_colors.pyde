''' Logistic iteration - almost everything possible without procedures '''

R=3.575  #Range from 0..4
X=0.99   #Range 0..1!

size(1000,300)

##checking the range of R
if R >= 4.0  :  
  R=4.0; println("R is too big!"); 


if R <= 0.0  :  
  R=0.0; println("R is too small!"); 


print   "Current R=",R 
   
if X > 1.0  : println("X is too big!")
if X < 0.0  : println("X is too small!")

stroke(255,0,0) #In RED!

for i in range(0,width,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  #println(i,X)
  ellipse(i,height-X*height,2,2)
  #point(i,height-X*height) #Visualise as a point
  X=R*X*(1-X) #Calculate next iteration


text("R="+str(R),0,height-10)

## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
