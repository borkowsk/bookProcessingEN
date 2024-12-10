## Chaotic oscillator class - complex type
## An example of a class - user-defined type
####=============================================
from adhoclib import * 


##The second partner adapts to the state already changed 
##in the first one, or they operate in strict parallel.
_GottmanMode4double=True
  
class singiel_double: #singiel_double:
  # block: # FIELDS / ATTRIBUTES:
  
  #Constructor(s):
  # each class has at least one method called as 
  # the class name, has no return type and is used 
  # to create a class object - the instance
  
  @staticmethod
  def make_singiel_double0(): #parameterless constructor##0 ()
    self = singiel_double() #make default.
    # block:
    self.x1=self.x2=0.5;self.r=3;self.al=0
    return self
  
  
  @staticmethod
  def make_singiel_double2(iX,iR): #Alpha-less constructor##2 (DOUBLE IX,DOUBLE IR)
    self = singiel_double() #make default.
    # block:
    self.x1=self.x2=iX;self.r=iR;self.al=0
    return self
  
  
  @staticmethod
  def make_singiel_double3(iX,iR,iAlpha): #other constructor    #3 (DOUBLE IX,DOUBLE IR,DOUBLE IALPHA)
    self = singiel_double() #make default.
    # block:
    self.x1=self.x2=iX;self.r=iR;self.al=iAlpha
    return self
  
  
  # METHODS:
  def  alpha(self): #R/O Access to the field 'al' ("getter")### is an object method.
    # block:             #under a different name. 
    return (float)(self.al)  #The so-called accessory
  
  
  def  xPre(self): #R/O Access to the field 'x1' ("getter")### is an object method.
    # block:
    return (float)(self.x1)
  
  
  def  xCur(self): #R/O Access to the field 'x1' ("getter")### is an object method.
    # block:
    return (float)(self.x2)
  
  
  def  rCur(self):  #R/O Access to the field 'x1' ("getter")### is an object method.
    # block:
    return (float)(self.r)
  
  
  # Methods to change state of object
  
  def  set_alpha(self,iAl): # "setter" for 'al'### is an object method.
    # block:
    if 0<=iAl  and  iAl<=1 :
      self.al=iAl
    else : 
      print   "Invalid 'alpha' value:",iAl 
  
  
  def  set_x(self,iX): # "setter" for x1 & x2### is an object method.
    # block:
    if 0<=iX  and  iX<=1 :
      self.x1=self.x2=iX
    else : 
      print   "Invalid state value:",iX 
  
  
  def  next(self): #Next iteration of this logistic equation### is an object method.
    # block:          
    self.x1=self.x2
    self.x2=self.x1*self.r*(1-self.x1)  #This is an iteration without a pair
  
   
  def __INIT__(self):
    self.r  =0.0   ##double field 
    self.al  =0.0   ##double field 
    self.x1  =0.0   ##double field 
    self.x2  =0.0   ##double field 
    # fc:4

  #Closing the class.  #@END_OF_CLASS


## viewer - procedure external to the class 
def view(S,v,h,baseLength): # Is it any global variable modified inside?   
  '''Purpose of the code block below is ...'''
  ellipse(v,h,round(S.xPre()*baseLength),round(S.xCur()*baseLength))


## Pair iteration routine
## Declared outside the class for symmetry reasons
def next4couple(F,S): # Is it any global variable modified inside? 
  '''Purpose of the code block below is ...'''
  # The interaction of the oscillators
  if _GottmanMode4double :
    # block:
    F.x2=F.x2*(1-F.al)+S.x2*F.al  #He adopts first
    S.x2=S.x2*(1-S.al)+F.x2*S.al
  
  else :
    # block:
    Xold=F.x2
    F.x2=F.x2*(1-F.al)+S.x2*F.al
    S.x2=S.x2*(1-S.al)+Xold*S.al
  
  
  # New states of partners
  F.next()
  S.next()


##https://github.com/borkowsk/bookProcessingEN/
## jigle.awk .pde classes preprocessing by borkowsk @ github.
## Translated by pde2pyde Wed, 11 Dec 2024 00:13:23 +0100
