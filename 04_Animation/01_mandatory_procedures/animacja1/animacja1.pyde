# Processing program in "mode" 2 - with functions.
#*#===============================================

def setup(): # Is it any global variable used inside? # It is executed once - upon startup.
  '''What should this code below do?'''
  size(500,500)
  background(0,0,200) # rgB
  noSmooth()
  ellipse(250, 250, 200, 200)

 
i=0

def draw(): # It is executed in an invisible loop.
  '''
  What should this code below do?
  Is it any global variable used inside?
  Of course! The variable 'i' !
  So we have to declare it as "global".
  '''
  global i
  fill(0,i,0)  # rGb
  arc(250, 250, 200, 200, radians(i-10),radians(i))
  i+=10 # incrementation of "i"
