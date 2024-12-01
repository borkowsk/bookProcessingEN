## "Min-Opt-Max neighbors": Not too many neighbors, but not too few, but OPTIMAL!
## TWO-dimensional, (A)SYNCHRONOUS, vonNeuman/Moore, deterministic cellular automaton
##-##=================================================================================
## See 233 (Conways Game of Life) or 123 & 234 - much more "biological"

'''constant int'''
WorldSide=501   #How many cells do we want in one line?
'''constant boolean'''
sync=True       #Synchronous or asynchronous update    !!!!!!!

'''constant double'''
Dens=100.00     #When >=1, simetric horizontal line is created
'''constant int'''
MinN=2          #Minimal number of neighbors required
'''constant int'''
OptN=3          #The number of neighbors needed to revive the cell
'''constant int'''
MaxN=3          #Maximal number of neighbors required
'''constant boolean'''
withM=True      #With Moore neighbors

'''constant boolean'''
traceVA=True  #virgin areas trace ON/OFF
FR=100

'''assumed list of list of int (inefficient!)'''
WorldOld=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  #We need two arrays for the old  
'''assumed list of list of int (inefficient!)'''
WorldNew=[[0 for _x in range(WorldSide)] for _y in range(WorldSide)]  #and new state of the simulation

def setup(): # Is it any global variable modified inside?
  '''Purpose of the code block below is ...'''
  size(501,521)     #square window
  background(64)
  noSmooth()
  frameRate(FR  if FR>0  else Dens );  

  initialisation()


t=0  # time is global

def draw(): # Is it any global variable modified inside? 
  global t
  '''Note! Procedures used inside could be declaret later, 
  as long as draw() is used only by Processing engine "invisible" loop'''
  if sync :
    # block:
     visualisationSY()  #Visualisation for synchronous mode
     synchronicStep()
   
  else :
    # block:
     visualisationAS()  #Visualisation for asynchronous mode
     stepMonteCarlo()
  
  status()  #Status bar
  t+=1       #The next generation/step/year


def status(): # Is it any global variable modified inside?
  '''Purpose of the code block below is ...'''
  fill(128);noStroke()
  rect(0,height-20,width,20)
 
  fill(255);textSize(18);textAlign(LEFT,BOTTOM)
  text(str(t)+" ("+ nf(frameRate,3,2) +") "+str(liveCounter),0,height)


def initialisation(): # Is it any global variable modified inside?
  '''Purpose of the code block below is ...'''
  if Dens<1 :
    # block:
   for i in range(0,WorldSide,1): # loop over variable "i" #Initialisation
    for j in range(0,WorldSide,1): # loop over variable "j"
      # block:
      if not traceVA : 
          WorldNew[i][j]=-1  #Something different from any possible state
      
      if random(1.0)<Dens :
        WorldOld[i][j]=1
    
  
  else :
    # block:  # Initialisation for testing an emergent properties of CA
     off=-0
     for j in range(1,int(Dens),1): # loop over variable "j"
       # block:
        WorldOld[off+WorldSide/2][off+WorldSide/2+j]=1
        WorldOld[off+WorldSide/2][off+WorldSide/2-j]=1
     
     WorldOld[off+WorldSide/2][off+WorldSide/2]=1
  


def visualisationSY(): # Is it any global variable modified inside?
  '''Purpose of the code block below is ...'''
  for i in range(0,WorldSide,1): # loop over variable "i"
   for j in range(0,WorldSide,1): # loop over variable "j"
    if WorldOld[i][j] != WorldNew[i][j]  : #now WorldNew have step-1 content!!!
      # block:
      if WorldOld[i][j]>0 : 
        stroke(255,0,100)
      else :           
        stroke(0)
      point(j,i)  #the horizontal dimension of the array is the SECOND index
    


def visualisationAS(): # Is it any global variable modified inside?
  '''Purpose of the code block below is ...'''
  for i in range(0,WorldSide,1): # loop over variable "i"
   for j in range(0,WorldSide,1): # loop over variable "j"
    if WorldNew[i][j] == -1  :
      # block:
      if WorldOld[i][j]>0 : stroke(255,0,100)
      else : stroke(0)
      point(j,i)  #the horizontal dimension of the array is the SECOND index
      WorldNew[i][j]=1  #READY
    


liveCounter=0  #The only statistics for the model so far

def synchronicStep(): # Is it any global variable modified inside? 
  global WorldOld,WorldNew
  '''Purpose of the code block below is ...'''
  liveCounter=0  #Reset the only statistic
  for i in range(0,WorldSide,1): # loop over variable "i" #Now the cellular automaton state change
    # block:
     # RULE: Not too many neighbors, not too few, but optimal
     right = (i+1) % WorldSide;          
     left  = (WorldSide+i-1) % WorldSide
     
     for j in range(0,WorldSide,1): # loop over variable "j" 
       # block:
       dw=(j+1) % WorldSide;   
       up=(WorldSide+j-1) % WorldSide
       
       lives = (
                   WorldOld[left][j]+WorldOld[right][j]+WorldOld[i][up]+WorldOld[i][dw]
                   +(WorldOld[left][up]+WorldOld[right][up]+WorldOld[left][dw]+WorldOld[right][dw]  if withM  else 0)
                   )
               
       if WorldOld[i][j]==0 :
         WorldNew[i][j]=(1 if lives == OptN  else 0)
       else :
         WorldNew[i][j]=(1 if MinN <= lives  and  lives <=MaxN  else 0 )  #New state 
       
       if WorldNew[i][j]>0 : 
             liveCounter+=1  #Calculating the only statistic
     
  
   
  # Swap the arrays
  '''assumed list of list of int (inefficient!)'''
  WorldTmp=WorldOld
  WorldOld=WorldNew
  WorldNew=WorldTmp


def stepMonteCarlo(): # Is it any global variable modified inside? 
  global WorldOld,WorldNew
  '''Purpose of the code block below is ...'''
  liveCounter=0  # Reset the only statistic
  '''constant int'''
  N=WorldSide*WorldSide
  for a in range(0,N,1): # loop over variable "a"
    # block:
       i=int(random(WorldSide));j=int(random(WorldSide))  #draw the agent's indexes
       
       #Rule: "Min-Best-Max neighbors"
       right = (i+1) % WorldSide;      
       left  = (WorldSide+i-1) % WorldSide
       dw=(j+1) % WorldSide;   
       up=(WorldSide+j-1) % WorldSide
       
       lives = ( #sum of living neighbors = sum of states of neighbors (states 0 and 1 only)
                 WorldOld[left][j]+WorldOld[right][j]+WorldOld[i][up]+WorldOld[i][dw]        
                 # corners:
                 + (WorldOld[left][up]+WorldOld[right][up]+WorldOld[left][dw]+WorldOld[right][dw] if withM  else 0 )
                 ); 
       
       # Implementation of the rule  
       State=WorldOld[i][j]
       if State==0 :
           WorldOld[i][j]=(1 if lives == OptN  else 0)
       else :
           WorldOld[i][j]=(1 if MinN <= lives  and  lives <=MaxN  else 0 ) #New state 
         
       if State!=WorldOld[i][j] : 
           WorldNew[i][j]=-1  #Force painting changed points.
       
       if WorldOld[i][j]>0 : liveCounter+=1  #Calculating the only statistic
   


## @date 2024-12-01 (https:##github.com/borkowsk/bookProcessingEN/tree/main/08_2D_cellular/_synchronic/)
