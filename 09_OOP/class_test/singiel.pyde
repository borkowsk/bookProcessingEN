## Chaotic oscillator class.
## An example of a class - user-defined type.
##-##=============================================

class singiel 
  # block: ## FIELDS / ATTRIBUTES:
  r      ##!< Control parameter.
  al     ##!< Coupling parameter
  x1,x2  ##!< Current and previous states
  
  ## Constructor(s):
  ##-##============
  ## each class has at least one method called as 
  ## the class name, has no return type and is used 
  ## to create a class object - the "instance".
  
  
  singiel(float iX,iR,iAlpha)    
    # block:
    x1=x2=iX;r=iR;al=iAlpha
  
  
  ## METHODS:
  ##-##======
  
  def alpha(): # Should return float ##!< R / O Access to the field 'al' 
    # block:             ##!< under a different name. 
    return al   ##!< The so-called accessory
  
  
  
  def next(): # Is it any global variable modified inside?  ##!<  Method to change state of object.
    # block:          
    x1=x2
    x2=x1*r*(1-x1)  ##This is an iteration without a pair
  
   
  ##Closing the class. May be ';' but it doesn't have to.


## viewer - procedure external to the class because 
## it can be in various variants, created as needed.
def view(singiel S,v,h,rad): # Is it any global variable modified inside?   
  '''What should this code below do?'''
   ellipseMode(RADIUS); 
   ellipse(v,h,round(S.x1*rad),round(S.x2*rad))


## Pair iteration routine
## Declared outside the class for symmetry reasons
def next4couple(singiel F,singiel S): # Is it any global variable modified inside? 
  '''What should this code below do?'''
  ## The interaction of the oscillators
  F.x2=F.x2*(1-F.al)+S.x2*F.al
  S.x2=S.x2*(1-S.al)+F.x2*S.al
  
  ## Real state change
  F.next()
  S.next()


## https://github.com/borkowsk/bookProcessingEN/
## @date 2024-11-29 (revived)
