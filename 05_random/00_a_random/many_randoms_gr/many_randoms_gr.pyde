## Random() example with variable:
#*##==============================

a=1.0  # This variable is outside loop
       # But in fact is local, in invisible 
       # setup subroutine!

for i in range( 0,100,1): # "i" should be int
  '''What should this code below do?''' 
  print a    # Printed on the console - why first?
  line(0,i,a*100,i)
  a=random(1.0)  # A new random number in the range 0..1

 
# https://github.com/borkowsk/bookProcessingEN
