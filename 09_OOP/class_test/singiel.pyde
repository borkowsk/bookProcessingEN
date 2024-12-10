## Chaotic oscillator class.
## An example of a class - user-defined type.
##-##=============================================

from adhoclib import * 

class singiel:  ##singiel:
  '''block:''' # FIELDS / ATTRIBUTES:
  
  # static and final object members are not supported yet!!!
  '''constant double'''
  max_r=4.0
  
  # Constructor(s):
  #-####=============
  # each class has at least one method called as 
  # the class name, has no return type and is used 
  # to create a class object - the "instance".
  
  
  @staticmethod
  def make_singiel3(iX,iR,iAlpha):    #3 (FLOAT IX,FLOAT IR,FLOAT IALPHA)
    self=singiel() #make default.
    '''block:'''
    tmp=[]  #TEST
    self.x1=self.x2=iX;self.r=iR;self.al=iAlpha     #substitution(s) in method line: 4
    return self
  
  
  # METHODS:
  #-####====
  
  def  alpha(self): #!< R / O Access to the field 'al' ## is an object method.
    '''block:'''             #!< under a different name. 
    tmp=[]  #TEST
    return self.al   #!< The so-called accessory    #substitution(s) in method line: 1
  
  
  
  def  next(self):  #!<  Method to change state of object.### is an object method.
    '''block:'''          
    self.x1=self.x2     #substitution(s) in method line: 2
    self.x2=self.x1*self.r*(1-self.x1)  #This is an iteration without a pair    #substitution(s) in method line: 4
  
   
  def __INIT__(self):
    self.r  =0.0  #!< Control parameter.     ##float field 
    self.al  =0.0  #!< Coupling parameter     ##float field 
    self.x1  =0.0  #!< Current and previous states   ##float field 
    self.x2  =0  #!< Current and previous states   ##float field 
    # fc:4

  #Closing the class. In JAVA syntax may be ';' but it doesn't have to. #@END_OF_CLASS


## viewer - procedure external to the class because 
## it can be in various variants, created as needed.
def view(S,v,h,rad): # Any globals modified?   
  '''block:'''
  ellipseMode(RADIUS); 
  ellipse(v,h,round(S.x1*rad),round(S.x2*rad))


## Pair iteration routine
## Declared outside the class for symmetry reasons
def next4couple(F,S): # Any globals modified? 
  '''block:'''
  # The interaction of the oscillators
  F.x2=F.x2*(1-F.al)+S.x2*F.al
  S.x2=S.x2*(1-S.al)+F.x2*S.al
  
  # Real state change
  F.next()
  S.next()


tmp=0  #test!

## https://github.com/borkowsk/bookProcessingEN/
## @date 2024-12-10 (revived)
## jigle.awk .pde classes preprocessing by borkowsk @ github.
## Tranlated by pde2pyde Tue, 10 Dec 2024 16:28:55 +0100
