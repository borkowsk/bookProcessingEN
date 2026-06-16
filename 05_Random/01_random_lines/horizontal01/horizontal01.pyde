## Random lines along the horizontal axis.
#*##======================================

size(300,200)

for i in range(0,300,1): # "i" should be int
  '''What should this code below do?''' 
  a=random(200)    # A number in the range 0..200
  #line(i,0,i,a)        # down
  line(i,200,i,200-a)    # up


# https://github.com/borkowsk/bookProcessingEN
