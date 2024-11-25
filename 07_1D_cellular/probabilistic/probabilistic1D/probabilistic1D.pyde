## One-dimensional, probabilistic, non-interactive cellular automaton - CA skeleton in the "non-functional" form:
##=##============================================================================================================

size(500,1000)     ## The window is more vertical than horizontal 

World=[0]*(width)  ## Creating list of cell (no regular arrays in Processing Python dialect)
                   ## Here list is formed from zeros.

World[len(World)/2]=1  ## Seed

print "table:"
for i in range(0,len(World),1): # 'i' has int value ## Writing an array to the console
  print World[i],' ',
    
for t in range(0,height,1): # 't' has int value ## As many generations as there are canvas lines
  '''block:''' 
  for i in range(0,len(World),1): # 'i' has int value ## Visualization or "drawing on the screen" 
    '''block:''' 
    if World[i]>0 : stroke(255)
    else :           stroke(0)
    point(i,t)
  
  
  for i in range(0,len(World),1): # 'i' has int value ## Change the state of the automaton
    '''block:''' 
    if World[i]>0 and random(1.0)<0.005 : ## If the cell is alive it may die
      World[i]=0
      
    if World[i]==0 and random(1.0)<0.001 : ## If the cell is dead, it might come to life
      World[i]=1
  


print "table:" ## Print an Array To Console Again!
for i in range(0,len(World),1): # 'i' has int value 
  print World[i],' ',
    

## https://github.com/borkowsk/bookProcessingEN
