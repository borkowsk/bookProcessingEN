## An example of using a class (complex user type)
## @date 2025-03-17 (last modification)
##-##==================================================
## TODO comments clean!
from adhoclib import * 

'''constant double'''
DefaultR=3.66
'''constant int'''
FR=5

## Construction of the class object.
## Ex. `singiel TheSingiel=new singiel(0.55,DefaultR,0);`
## using `singiel(float iX,iR,iAlpha);`
TheSingiel = singiel.make_singiel3(random(1.0),DefaultR+random(0.5),0) #


def setup(): # Any globals modified?
  '''block:'''
  size(701,501)
  frameRate(FR)
  # Access to attributes - dot notation. But "TS.Alpha:",TheSingiel.alpha()  is not important here
  print    "TS.x:",TheSingiel.x1,"TS.R:",TheSingiel.r  



def draw(): # Any globals modified?
  '''block:'''
  #background(200)
  #Object of type 'singiel' used as parameter.
  view(TheSingiel, width/2,height/2,min(width/2,height/2))
  TheSingiel.next()  # Method call - dot notation again


## https://github.com/borkowsk/bookProcessingEN/
## Translated by pde2pyde Tue, 10 Dec 2024 18:08:23 +0100
