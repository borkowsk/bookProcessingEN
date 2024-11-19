# CD image ;-) example.
#*#====================

size(300,300)
background(0)  # Black background (0 brightness)
noFill()       # The contours of the ellipses themselves
#noSmooth()  # Try with or without smoothing.
stroke(255)    # White outline

for i in range(150,30,-2): # "i" should be int # REPEAT every other time <=> i=1-2
#BEGIN What this code below should do?
   ellipse(100,100,i,i)
#END # Multi-instruction block is not needed here.

#Second plate, more pytonish...
stroke(128)
for i in range(150,30,-2):
   ellipse(200,200,i,i)

# https://github.com/borkowsk/bookProcessingEN
