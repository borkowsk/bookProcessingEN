# Bigger CD image ;-) example.
#*#===========================

size(300,300)
background(0)  # Change background!
noFill()       # Only the contours of the ellipses.
#noSmooth()

for i in range(250,30,-2): # "i" should be int # REPEAT BACKWARD every two times <=> i=i-2
   #Before run, think this code below should do?
   stroke(i)   # More sophisticated color
   ellipse(width/2,height/2,i,i)  # In the center of a window

# https://github.com/borkowsk/bookProcessingEN
