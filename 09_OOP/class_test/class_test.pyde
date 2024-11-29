## TODO comments clean!
## An example of using a class (complex user type)
##-##==================================================

'''constant float'''
DefaultR=3.66
'''constant int'''
FR=5

## Construction of the class object.
## Ex. `singiel TheSingiel=new singiel(0.55,DefaultR,0) ##singiel(float iX,iR,iAlpha);`
singiel TheSingiel=new singiel(random(1.0),DefaultR+random(0.5),0)


def setup(): # Is it any global variable modified inside?
  '''What should this code below do?'''
  size(701,501)
  frameRate(FR)
  ## Access to attributes - dot notation
  println("TS.x:",TheSingiel.x1,"TS.R:",TheSingiel.r
          ##," TS.Alpha:",TheSingiel.alpha() #not important here
          )



def draw(): # Is it any global variable modified inside?
  # block: ##Object of type 'singiel' used as parameter
  ##background(200)
  view(TheSingiel, width/2,height/2,min(width/2,height/2)) ##view(singiel S,v,h,rad)
  TheSingiel.next() ## Method call - dot notation


## https://github.com/borkowsk/bookProcessingEN/
## @date 2024-11-29 (revived)
