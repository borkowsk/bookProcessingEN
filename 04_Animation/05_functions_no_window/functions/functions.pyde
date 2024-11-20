## Demonstration of functions with different parameters.
#*##=====================================================
# NOTE! This example is not so didactic. Translation from pde 
# is possible but function behave differently in Java than Python.
'''constant float'''
onef=1.0

'''constant int'''
onei=1

memory=0

def read_memory():
  '''What should this code below do?''' 
  return memory
  

def function_returning_int():
  '''What should this code below do?''' 
  return onei


def function_returning_float():
  '''What should this code below do?''' 
  return onef


def function_receiving_int_returning_int(x):
  '''What should this code below do?''' 
  return x*x


def function_receiving_int_returning_float(x):
  '''What should this code below do?''' 
  return sqrt(x)  # Square root of an integer


def function_receiving_float_returning_float(x):
  '''What should this code below do?''' 
  return sqrt(x)  # Square root of a floating point number


def setup(): # Is it any global variable used inside?
  '''What should this code below do?''' 
  noLoop()
  print   function_returning_int() 
  print   function_returning_float() 
  print   function_receiving_int_returning_int(2) 
  print   function_receiving_int_returning_float(2) 
  print   function_receiving_float_returning_float(2.) 
  print   X, Y  # What is this? Undocumented variables similar to `mouseX`?
  print  "booleans:",True,False #trueish is notrue


def draw(): # Is it any global variable used inside? # Console only applet!
  '''What should this code below do?''' 
  this.surface.setVisible(False)
  exit()


def exit(): # Is it any global variable used inside? # What should be done when window is closed?
  '''What should this code below do?''' 
  print "Thank You!"
  sys.exit()


# https://github.com/borkowsk/bookProcessingEN
