## Chaotic oscillator class - complex type
## An example of a class - user-defined type
####=============================================
from adhoclib import * 

  
##The second partner adapts to the state already changed 
##in the first one, or they operate in strict parallel.
_GottmanMode=False  #Important "refactoring"!

class singiel:  #singiel:
  # block: # FIELDS / ATTRIBUTES:
  # private - it does not work in processing because of its relation to JAVA. 
  
  # Constructor/creato
  # It creates a class object - the instance.
  @staticmethod
  def make_singiel3(iX,iR,iAlpha):    #3 (FLOAT IX,FLOAT IR,FLOAT IALPHA)
    self = singiel() #make default.
    # block:
    self.x1=self.x2=iX;self.r=iR;self.al=iAlpha     #substitution(s) in method line: 4
    return self
  
  
  # METHODS:
  def  alpha(self): #R / O Access to the field 'al' ## is an object method.
    # block:             #under a different name. 
    return self.al   #The so-called accessory    #substitution(s) in method line: 1
  
  
  def  next(self): # Method to change state of object.### is an object method.
    # block:          
    self.x1=self.x2     #substitution(s) in method line: 2
    self.x2=self.x1*self.r*(1-self.x1)  #This is an iteration without a pair    #substitution(s) in method line: 4
  
   
  def __INIT__(self):
    self.r  =0.0   ##float field 
    self.al  =0.0   ##float field 
    self.x1  =0.0   ##float field 
    self.x2  =0.0   ##float field 
    # fc:4

 #Closing the class. #@END_OF_CLASS


## viewer - procedure external to the class
def view(S,v,h,rad): # Is it any global variable modified inside?   
  # block:  #Actually this is a visualization of the oscillator 
   #transition between states
   rad*=2  #some other "refactoring"
   ellipse(v,h,round(S.x1*rad),round(S.x2*rad))


## Pair iteration routine
## Declared outside the class for symmetry reasons
def next4couple(F,S): # Is it any global variable modified inside? #Some "refactoring" done
  '''Purpose of the code block below is ...'''
  # The interaction of the oscillators
  if _GottmanMode :
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
## Translated by pde2pyde Tue, 10 Dec 2024 20:28:40 +0100
