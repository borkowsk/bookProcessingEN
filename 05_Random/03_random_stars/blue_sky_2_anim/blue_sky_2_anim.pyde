## Stars in the sky of any size - animated.
#*##=======================================

N=0;i=0  # 'N' and 'i' must be global!

def setup(): # Is it any global variable used inside? YES
  global N,i
  '''What should this code below do?''' 
  size(1000,700)
  background(0,0,25)
  frameRate(300)
  #noSmooth()#It looks much better with the smooth effect
  # Global 'N' and 'i' are set below:
  N=(height*width)/100  #number of stars to draw
  i=0  #Counter


def draw(): # Is it any global variable used inside? YES
  global N,i
  '''What should this code below do?''' 
  if i<N :
    # block: 
    R=55+random(200)  # Stars with a minimum brightness of 55
    G=55+random(200)  # <=> random(55,255)
    B=55+random(200)  # ---//---
    stroke(R,G,B)            # Different colors of the stars
    strokeWeight(random(2))  # Different sizes of stars
    
    point(random(width),
          random(height))  # Different positions
    i+=1
  


# https://github.com/borkowsk/bookProcessingEN
