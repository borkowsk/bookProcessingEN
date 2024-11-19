#  150 ellipses -> perspective cylinder.
#*# ====================================

size(500,500)
background(0)  # Black background (0 brightness)
stroke(200)

for i in range(0,250): # "i" should be int # REPEAT 250 times
   ellipse(100+i,100+i,100+0.1*i,100+0.1*i)  # "i" modifies every parameter.
 
# https://github.com/borkowsk/bookProcessingEN
