## Chaotic oscillator class.
## An example of a class - user-defined type.
##-##========================================
# THIS IS TRANSLATED MANUALLY:
    
class singiel :
  ## Basic constructor. See also: https://www.geeksforgeeks.org/operator-overloading-in-python/
  def __INIT__(self) :
    # block: ## FIELDS / ATTRIBUTES:
    self.r=0.0;  ##!< Control parameter.
    self.al=0.0  ##!< Coupling parameter
    self.x1=0.0
    self.x2=0.0  ##!< Current and previous states
  
  ## Creator(s) - static pseudo constructor(s):
  ##-##===========================================
  ## each class has at least one method called as 
  ## the class name, has no return type and is used 
  ## to create a class object - the "instance".
  
  @staticmethod
  def create4(iX,iR,iAlpha) :  
    # block:
    Ret=singiel();    
    Ret.x1=Ret.x2=iX
    Ret.r=iR;Ret.al=iAlpha
    return Ret

  @staticmethod  # Note! There are no function oeverloading in Python (2.7)
  def create0():
    # block:
    Ret=singiel();    
    return Ret


  ## METHODS:
  ##-##======
  
  def alpha(self) :  # Should return float ##!< R / O Access to the field 'al' 
    # block:         ##!< under a different name. 
    return self.al   ##!< The so-called accessory
  
  
  def next(self) : # Is it any global variable modified inside?  ##!<  Method to change state of object.
    # block:          
    self.x1=self.x2
    self.x2=self.x1*self.r*(1-self.x1)  ##This is an iteration without a pair
  
   
##Closing the class. May be ';' but it doesn't have to.


## viewer - procedure external to the class because 
## it can be in various variants, created as needed.
def view(S,v,h,rad): # Is it any global variable modified inside?   
  '''What should this code below do?'''
  ellipseMode(RADIUS); 
  ellipse(v,h,round(S.x1*rad),round(S.x2*rad))


## Pair iteration routine
## Declared outside the class for symmetry reasons
def next4couple(F,S): # Is it any global variable modified inside? 
  '''What should this code below do?'''
  ## The interaction of the oscillators
  F.x2=F.x2*(1-F.al)+S.x2*F.al
  S.x2=S.x2*(1-S.al)+F.x2*S.al
  
  ## Real state change
  F.next()
  S.next()


## https://github.com/borkowsk/bookProcessingEN/
## @date 2024-12-03 (revived)
