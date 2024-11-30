''' Lotka–Volterra equations.
* https:##en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
'''

X=350 #x is the number of prey (for example, rabbits)
Y=10  #y is the number of some predator (for example, foxes)
  
##α, β, γ, δ are positive real parameters describing the interaction of the two species.
alpha=0.2 #prey growth
beta=0.01 #interaction of prey with predators
gamma=beta/10.0 #the growth of predators depends on the number of prey
delta=0.05      #the mortality of predators

Tstep=0.3 #Time step. As short as possible ;-)
N=1000    #Number if steps

size(1000,500)
print   "α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta 

for i in range(0,N,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  oldX=X #Local variable is valid only inside its block of code
  print   i,"X:",X," Y:",Y 
  #Visualisation:
  stroke(0,255,0) #GREEN for X
  ellipse(i,500-X,3,3)
  stroke(255,0,0) #RED for Y
  ellipse(i,500-Y,3,3)
  #How X & Y changes in "infinitely short" time step?
  X=X + Tstep * (alpha*X-beta*X*Y)
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y)


##https://github.com/borkowsk/bookProcessingEN