'''  "Vertical" of Rafał Kosik. 
 The action of this SF novel takes place in a cylindrical world 
 after a conflict with "aliens". People live in steel cities, 
 climbing ropes, pursuing an undefined Goal.
 See: https:#www.goodreads.com/book/show/6615626-vertical
'''

N=10     # Number of cities
space=1  # Distance between cities
positions=[0.0]*(N)

def setup(): # Is it any global variable used inside? YES!!!
  global N,space,positions !!!!!!
  '''What should this code below do?''' 
  size(200,1000)
  frameRate(200)
  # Calculate space
  space=width/(N+1)
  print "space:",space
     
  # Initial positions
  for j in range(0,N,1): # 'j' keeps int
    positions[j]=height-1


def draw(): # Is it any global variable used inside? YES!!!
  global N,space,positions
  '''What should this code below do?''' 
  background(0,155,185)  # also clear the window!
  
  # ropes
  for i in range(0,width,5): # 'i' keeps int
    line(i,height,i,0)
    
  # cities
  for j in range(0,N,1): # 'j' keeps int
    # block: 
    ellipse((j+1)*space,positions[j],space,3)  # Visualisation
    
    positions[j]-=random(2.0)  # Random move
    
    if positions[j]<0 : # Checking if he has not passed the top
      positions[j]+=height
  


# https://github.com/borkowsk/bookProcessingEN
