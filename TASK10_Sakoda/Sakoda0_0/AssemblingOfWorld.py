## World is a one of two central class of each ABM model
##*##===========================================================
from adhoclib import * 


class World: #implements simulation_world interface later... #World:
  '''Purpose of the code block below is ...'''
  #each one must have their own timer!

  #type v.name [][]<- marks of 2D array   
  '''assumed list of list of Agent '''
  agents=[[]]  #Two-dimensional array of agents
  #But it could be one-dimensional,
  #Or even hexagonal!

  @staticmethod
  def make_World0(side): #Constructor of the World##0 (INT SIDE)
    self = World() #make default.
    # block:
<< ERROR! Empty field name on the list. >>
    agents=new Agent[side][side]  #We guarantee the creation 
<< ERROR! Empty field name on the list. >>
    #of an array. Empty for now!
    return self
  

  def  initializeModel(self): #Method 1### is an object method.
    # block:
<< ERROR! Empty field name on the list. >>
    for a in range(0,len(agents),1): # loop over variable "a" Patt#2 #for every row
<< ERROR! Empty field name on the list. >>
      for b in range(0,agents[a].length,1): # loop over variable "b" Patt#2 #for every column
<< ERROR! Empty field name on the list. >>
        if random(1.0)<density : # Only some of the cells are occupied
          # block:
          curr = Agent.make_Agent0()  # We construct the agent#
<< ERROR! Empty field name on the list. >>
          agents[a][b]=curr  # ... and put it in the array
        
  

  def  changeState(self): #Method 2### is an object method.
    # block:
    MCN=len(agents)*agents[0].length  #number of M C draws
<< ERROR! Empty field name on the list. >>
    for i in range(0,MCN,1): # loop over variable "i" Patt#2
      # block:
      a=(int)random(0, len(agents))  #row
      b=(int)random(0, agents[a].length)  #column
<< ERROR! Empty field name on the list. >>

<< ERROR! Empty field name on the list. >>
      if agents[a][b] != null  :
        # block:
<< ERROR! Empty field name on the list. >>
        #Check the stress on the agent
        strangers=0  #Number of foreign neighbors in von Neumann's neib.
<< ERROR! Empty field name on the list. >>

<< ERROR! Empty field name on the list. >>
        if ( 0 <= a-1 #when not reaching beyond the array
<< ERROR! Empty field name on the list. >>
           and  agents[a-1][b]!=null #...and there is an agent in the cell
<< ERROR! Empty field name on the list. >>
           and  agents[a-1][b].identity!=agents[a][b].identity) #...and is different
<< ERROR! Empty field name on the list. >>
          strangers+=1  #Remember the behavior of the operator  and !
<< ERROR! Empty field name on the list. >>

<< ERROR! Empty field name on the list. >>
        if (a+1 < len(agents) 
<< ERROR! Empty field name on the list. >>
           and  agents[a+1][b]!=null 
<< ERROR! Empty field name on the list. >>
           and  agents[a+1][b].identity!=agents[a][b].identity)
<< ERROR! Empty field name on the list. >>
          strangers+=1;  
<< ERROR! Empty field name on the list. >>

<< ERROR! Empty field name on the list. >>
        if (0 <= b-1 
<< ERROR! Empty field name on the list. >>
           and  agents[a][b-1]!=null 
<< ERROR! Empty field name on the list. >>
           and  agents[a][b-1].identity!=agents[a][b].identity)
<< ERROR! Empty field name on the list. >>
          strangers+=1
<< ERROR! Empty field name on the list. >>

<< ERROR! Empty field name on the list. >>
        if (b+1 < len(agents) 
<< ERROR! Empty field name on the list. >>
           and  agents[a][b+1]!=null 
<< ERROR! Empty field name on the list. >>
           and  agents[a][b+1].identity!=agents[a][b].identity)
<< ERROR! Empty field name on the list. >>
          strangers+=1;  
<< ERROR! Empty field name on the list. >>

<< ERROR! Empty field name on the list. >>
        agents[a][b].stress=strangers/4.0  #von Neumann neib.  
<< ERROR! Empty field name on the list. >>

<< ERROR! Empty field name on the list. >>
        #Attempting to migrate when the agent is under stress
<< ERROR! Empty field name on the list. >>
        if ( agents[a][b].stress > 0  #Scheling model
<< ERROR! Empty field name on the list. >>
           and  random(1.0)<agents[a][b].stress #"Not always" modification
<< ERROR! Empty field name on the list. >>
          )
          # block:
          tara=(int)random(0, len(agents))
          tarb=(int)random(0, agents[a].length)
<< ERROR! Empty field name on the list. >>

<< ERROR! Empty field name on the list. >>
          if agents[tara][tarb]==null : #There is an empty place
            # block:
<< ERROR! Empty field name on the list. >>
            agents[tara][tarb]=agents[a][b]  #Moving to a new apartment
<< ERROR! Empty field name on the list. >>
            agents[a][b]=null  #Check out from the old place
          
        
      
    
  

  def  makeStatistics(self):### is an object method.
    # block:
<< ERROR! Empty field name on the list. >>
    #... later on
  

  def  modelStep(self): #Method 3 using method 2 ## is an object method.
    # block:
<< ERROR! Empty field name on the list. >>
    #self.
<< ERROR! Empty field name on the list. >>
    changeState()  #'this' is redundant here. For example only.
<< ERROR! Empty field name on the list. >>

<< ERROR! Empty field name on the list. >>
    #Other every step actions
<< ERROR! Empty field name on the list. >>
    makeStatistics()  #here without 'this'
<< ERROR! Empty field name on the list. >>

<< ERROR! Empty field name on the list. >>
    self.StepCounter+=1
  
  def __INIT__(self):
    self.StepCounter  =0  #If we had more worlds,   ##int field 
    int  =0  #If we had more worlds,   #@FIELD_DECLARATION 
    # fc:2

  #@END_OF_CLASS

##More alaborated functionalities may be defined as stand-alone functions
####=======================================================================

def visualizeModel(world): # Is it any global variable modified inside?
  '''Purpose of the code block below is ...'''
  curr =[]  #tmp handle
  for a in range(0,world.len(agents),1): # loop over variable "a" Patt#2
    for b in range(0,world.agents[a].length,1): # loop over variable "b" Patt#2
      # block:
      #Cell background. If there was no agent present here,
      noStroke()
      fill(200)  #the only background will remain
      rect(b*cwidth, a*cwidth, cwidth, cwidth)  #Remember, 'a' is vertical!

      #Drawing the agent only when it is in this array cell
      if (curr=world.agents[a][b]) != null  : #null means "empty handle"
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
## Translated by pde2pyde Fri, 20 Dec 2024 21:00:47 +0100
