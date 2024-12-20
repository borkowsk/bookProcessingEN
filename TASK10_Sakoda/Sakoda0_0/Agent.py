## Agent is a one of two central class of each ABM model
## HERE: Agent for simplified Sakoda model
##*##==========================================================================
from adhoclib import * 


Number_of_identities=3  # How many mutually exclusive identities are there?

class Agent: #Agent:
  '''Purpose of the code block below is ...'''

  # Constructor of the Agent.
  @staticmethod
  def make_Agent0(): #0 ()
    self = Agent() #make default.
    # block:      
    self.identity=int(random(1, Number_of_identities+1))  #Simple way
    self.stress=0
    return self
  
  def __INIT__(self):
    self.identity  =0.0  # [1..Number_of_identities]      ##float field 
    self.stress  =0.0  #Stress in the current position [0..1]  ##float field 
    # fc:2

  #@END_OF_CLASS

##*##=======================================================================================
## AGENT OF (simplified) SAKODA MODEL
## https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM EXAMPLE 
## https://github.com/borkowsk/bookProcessingEN
##*##=======================================================================================
 
## jigle.awk .pde classes preprocessing by borkowsk @ github.
## Translated by pde2pyde Fri, 20 Dec 2024 21:01:07 +0100
