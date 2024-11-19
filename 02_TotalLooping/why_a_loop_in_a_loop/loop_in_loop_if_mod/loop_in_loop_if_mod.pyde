# Loop in loop - using the remainder from division.
#*#================================================

#noStroke() #ellipses without outlines

for i in range(0,10): # "i" should be int
  for j in range(0,10): # "j" should be int
    if  (i+j)%2 == 1  :
        print i,j # Console printout
        ellipse(i*10,j*10,4,4)  # "Dots" on window


# https://github.com/borkowsk/bookProcessingEN
