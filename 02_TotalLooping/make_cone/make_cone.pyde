#  150 ellipses make the cone.
#*# ==========================

size(500,500)
background(0)  # Black background (0 brightness)
stroke(200)

for i in range(0,150): # "i" should be int # REPEAT 150 times
   ellipse(100+i,100+i,1+i,1+i)  # "i" modifies every parameter of ellipse.
 
# https://github.com/borkowsk/bookProcessingEN
