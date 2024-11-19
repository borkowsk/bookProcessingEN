#  Loop in loop with use of inequalities.
#*# =====================================

#noStroke() # ellipses without outlines

for i in range(0,10): # "i" should be int
  for j in range(0,10): # "j" should be int
    if  i+j > 5 : # Print only when the condition is met.
      print i,j # Console printout
      ellipse(i*10,j*10,4,4)  # "Dots" on window

# https://github.com/borkowsk/bookProcessingEN
