## Random colored lines along the horizontal axis.
#*##==============================================

size(750,250)

for i in range(0,width,1): # 'i' should be int
  '''What should this code below do?''' 
  a=random(height)     # A number in the range 0..height
  stroke( random(256) , random(256), random(256) )
  line(i,height,i,height-a)  # up


# https://github.com/borkowsk/bookProcessingEN
