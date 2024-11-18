# src: https://openprocessing.org/sketch/825836/

def setup():
     '''Is it any globals used inside a function?'''
     size(500,500)
     noStroke()
     frameRate(10)  # Test what happened when rate is small (1..3)
#END

def mousePressed():
     '''Is it any globals used inside a function?'''
     if mousePressed :
     #BEGIN
       if mouseButton == LEFT :
       #BEGIN
            fill(255,255,255)
       #END  
       else : 
       #BEGIN
            fill(128,128,128)
       #END
       
       ellipse(mouseX,mouseY,50,50)
     #END
#END

def draw():
  '''Is it any globals used inside a function?'''
  # Only this one procedure put drawing to screen!
#END
