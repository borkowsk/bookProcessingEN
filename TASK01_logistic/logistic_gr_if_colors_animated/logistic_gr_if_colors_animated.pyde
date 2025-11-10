''' Logistic iteration - with procedures '''

R=3.575  #Range from 0..4
X=0.99   #Range 0..1!

def setup(): # Is it any global variable modified inside? YES
  global R,X
  '''Purpose of the code block below is ...'''
  size(1000,300)
  
  #checking the range of R
  if R >= 4.0  :  
    R=4.0; println("R is too big!"); 
  
  if R <= 0.0  :  
    R=0.0; println("R is too small!"); 
  
  print   "Current R=",R 
     
  if X > 1.0  : println("X is too big!")
  if X < 0.0  : println("X is too small!")
  
  text("R="+str(R),10,height-5)
  stroke(255,0,0) #In RED!



t=0 #< 't' means "time". Is global because value should be kept between `draw` calls.

def draw(): # Is it any global variable modified inside? YES
  global t,X
  '''Purpose of the code block below is ...'''
  if t>width : return #Nothing more to do!
  
  print   t,X 
  #point(t,height-X*height) #Visualise as a point
  ellipse(t,height-X*height,2,2)
  X=R*X*(1-X) #Calculate next iteration

  t+=1 #INCREMENTATION!!!


## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
