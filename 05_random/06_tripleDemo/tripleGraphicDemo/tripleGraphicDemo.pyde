## Processing has its own specific application structure which makes it a bit difficult 
## to create sequence programs, which usually are graphical demos. 
## But there is a way around this ...
#*##==============================================================

W=0  # global variable W

def setup(): # Is it any global variable used inside? YES
  global W
  '''What should this code below do?''' 
  size(600,600)
  W=width  # Initialisation


def radius(D): # Should return int # A function that draws a fraction from the size of the window
  global W
  '''What should this code below do?''' 
  return int( random(W/D) )  # float to int conversion


def draw1(): # Is it any global variable used inside? NO
  '''What should this code below do?''' 
  fill(random(255),random(255),random(255),random(255))    # RGB+opacity
  stroke(random(255),random(255),random(255),random(255))  # RGB+opacity
  r=radius(10)
  ellipse(random(W),random(W),r,r)


def draw2(): # Is it any global variable used inside? NO
  '''What should this code below do?''' 
  fill(random(255),random(255),random(255),random(255))  # RGB+opacity
  s=radius(10)
  rect(random(W-s),random(W-s),s,s)


i=0
R=0

def draw3(): # Is it any global variable used inside? YES!
  global i,R
  '''What should this code below do?''' 
  if R==0 : # Only the first time
    # block: 
      R=10+radius(2)
      noStroke()
  
  fill(0,i%256,0,25)  # GREEN + opacity
  arc(W/2,W/2, R, R, radians(i-10),radians(i))
  i+=10
  R+=0.1


frame=0

def draw(): # Is it any global variable used inside?
  global frame
  '''What should this code below do?''' 
  if frame<500 :
    draw1()
  else : 
    if(frame<999) :
        draw2()
    else : draw3(); 
  
  frame+=1


# https://github.com/borkowsk/bookProcessingEN
