# 150 ellipses -> cone.
#*#===================

size(500,500)
background(0,0,128)  # Dark blue background.
stroke(200)

for i in range(0,150,1): # "i" should be int # REPEAT 150 times
   #What this code below should do?
   stroke(i,0,0)  # from black to dark red
   ellipse(100+i,100+i,1+i,1+i)

# https://github.com/borkowsk/bookProcessingEN
