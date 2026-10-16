## World is a one of two central class of each ABM model
##*##===========================================================
from adhoclib import * 
#from Sakoda0_0 import density TODO It does not work!!!

class World: #implements simulation_world interface later... #World:
  '''Purpose of the code block below is ...'''
  '''(int)(StepCounter)(=0)(If we had more worlds, each one must have their own timer!)'''

  #type v.name [][]<- marks of 2D array   
  '''(Agent[][])(agents)(; )(Two-dimensional array of agents)'''
  #But it could be one-dimensional,
  #Or even hexagonal!

  def  initializeModel(self,density): #Method 1### is an object method.
    #global density #NIE WIDZI GO!
    # block:
    for a in range(0,len(self.agents),1): # loop over variable "a" Patt#2 #for every row
      for b in range(0,len(self.agents[a]),1): # loop over variable "b" Patt#2 #for every column
        if random(1.0)<density : # Only some of the cells are occupied
          # block:
          curr = Agent.make_Agent0()  # We construct the agent#
          self.agents[a][b]=curr  # ... and put it in the array
        
  

  def  changeState(self): #Method 2### is an object method.
    # block:
    MCN=len(self.agents)*len(self.agents[0])  #number of M C draws
    for i in range(0,MCN,1): # loop over variable "i" Patt#2
      # block:
      a=int( random(0, len(self.agents)) ) #row ##MANUALLY!!!
      b=int( random(0, len(self.agents[a])) )  #column  ##MANUALLY!!!

      if (self.agents[a][b] != None)  :
        # block:
        #Check the stress on the agent
        strangers=0  #Number of foreign neighbors in von Neumann's neib.

        if ( 0 <= a-1 #when not reaching beyond the array
           and  self.agents[a-1][b]!=None #...and there is an agent in the cell
           and  self.agents[a-1][b].identity!=self.agents[a][b].identity):  ##MANUALLY!!!
          strangers+=1  #Remember the behavior of the operator  and !

        if (a+1 < len(self.agents) 
           and  self.agents[a+1][b]!=None 
           and  self.agents[a+1][b].identity!=self.agents[a][b].identity): ##MANUALLY!!!
          strangers+=1;  

        if (0 <= b-1 
           and  self.agents[a][b-1]!=None 
           and  self.agents[a][b-1].identity!=self.agents[a][b].identity): ##MANUALLY!!!
          strangers+=1

        if (b+1 < len(self.agents) 
           and  self.agents[a][b+1]!=None 
           and  self.agents[a][b+1].identity!=self.agents[a][b].identity): ##MANUALLY!!!
          strangers+=1;  

        self.agents[a][b].stress=strangers/4.0  #von Neumann neib.  

        #Attempting to migrate when the agent is under stress
        if ( self.agents[a][b].stress > 0  #Scheling model
           and  random(1.0)<self.agents[a][b].stress #"Not always" modification
          ):
          # block:
          tara=int(random(0, len(self.agents)))
          tarb=int(random(0, len(self.agents[a])))

          if self.agents[tara][tarb]==None : #There is an empty place
            # block:
            self.agents[tara][tarb]=self.agents[a][b]  #Moving to a new apartment
            self.agents[a][b]=None  #Check out from the old place
          
        
  def  makeStatistics(self): ### is an object method.
    # block:
    pass #... later on
  
  def __init__(self):
    self.StepCounter  =0  # If we had more worlds, each one must have their own timer! #int field 
    '''assumed list of list of Agent '''
    self.agents =[[]]    # Two-dimensional array of agents @FIELD_DECLARATION 
    # fc:2
    
  def  modelStep(self): #Method 3 using method 2 ## is an object method.
    # block:
    self.changeState()

    #Other every step actions
    self.makeStatistics()  #here without 'this'
    self.StepCounter=self.StepCounter+1
  
  @staticmethod
  def make_World0(side): #Constructor of the World##0 (INT SIDE)
    self = World() #make default.
    # block:
    #self.StepCounter  =0    
    self.agents=[[None for _x in range(side)] for _y in range(side)] #new Agent[side][side] ##MANUALLY!!!
    #of an array. Empty for now!
    return self

  #@END_OF_CLASS

##More alaborated functionalities may be defined as stand-alone functions
####=======================================================================

def visualizeModel(world,cwidth): # Is it any global variable modified inside?
  '''Purpose of the code block below is ...'''
  curr =[]  #tmp handle
  for a in range(0,len(world.agents),1): # loop over variable "a" Patt#2
    for b in range(0,len(world.agents[a]),1): # loop over variable "b" Patt#2
      # block:
      #Cell background. If there was no agent present here,
      noStroke()
      fill(200)  #the only background will remain
      rect(b*cwidth, a*cwidth, cwidth, cwidth)  #Remember, 'a' is vertical!

      #Drawing the agent only when it is in this array cell
      curr=world.agents[a][b] ##MANUALLY!!!
      if curr != None  : #None means "empty handle"
        # block:
        if curr.stress>0 : # Stress as the outline color
          stroke(curr.stress*255, 0, curr.stress*255)
        else :
          noStroke()

        # Filling The Circle Depends On 'Identity'   
        forFill=(curr.identity*255.0)/Number_of_identities
        fill(forFill, forFill, 0)
        rect(b*cwidth, a*cwidth, cwidth-2, cwidth-2)  #strokeWeight == 2 !
      
    


####===========================================================================================
##  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
##  https://github.com/borkowsk/bookProcessingEN
####===========================================================================================
## jigle.awk .pde classes preprocessing by borkowsk @ github.
## Translated by pde2pyde Thu, 02 Jan 2025 16:41:00 +0100
