## Chaotic oscillator class.
## An example of a class - user-defined type.
##-##=============================================

class singiel:  ##singiel:
  '''block:''' # FIELDS / ATTRIBUTES:
  
## static and final object members are not supported yet!!!
  '''constant double'''
  max_r=4.0
  
  # Constructor(s):
  #-####===========
  # each class has at least one method called as 
  # the class name, has no return type and is used 
  # to create a class object - the "instance".
  
  
  def make_singiel(iX,iR,iAlpha):    #1
    self=singiel() #make default.
    '''block:'''
    tmp=[]  #TEST
    x1=x2=iX;r=iR;al=iAlpha
    return self
  
  
  # METHODS:
  #-####///
  
  def  alpha(self) #!< R / O Access to the field 'al' ## is an object method.
    '''block:'''             #!< under a different name. 
    tmp=[]  #TEST
    return al   #!< The so-called accessory
  
  
  
  def  next(self)  #!<  Method to change state of object.### is an object method.
    '''block:'''          
    x1=x2
    x2=x1*r*(1-x1)  #This is an iteration without a pair
  
   
  def __INIT__(self)
    self.r  =0.0  #!< Control parameter.     ##float field 
    self.al  =0.0  #!< Coupling parameter     ##float field 
    self.x2  =0  #!< Current and previous states   ##float field 
    self.x1  =0.0  #!< Current and previous states   ##float field 
    # fc:4

  #Closing the class. In JAVA syntax may be ';' but it doesn't have to. #@END_OF_CLASS


## viewer - procedure external to the class because 
## it can be in various variants, created as needed.
def view(singiel S,v,h,rad): # Any globals modified?   
  '''block:'''
   ellipseMode(RADIUS); 
   ellipse(v,h,round(S.x1*rad),round(S.x2*rad))


## Pair iteration routine
## Declared outside the class for symmetry reasons
def next4couple(singiel F,singiel S): # Any globals modified? 
  '''block:'''
  # The interaction of the oscillators
  F.x2=F.x2*(1-F.al)+S.x2*F.al
  S.x2=S.x2*(1-S.al)+F.x2*S.al
  
  # Real state change
  F.next()
  S.next()


tmp=0  #test!

## https://github.com/borkowsk/bookProcessingEN/
## @date 2024-12-09 (revived)

## Finally, level is 0,infunction is 0, inclass is 0 (global)
