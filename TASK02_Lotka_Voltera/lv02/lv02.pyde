''' Lotka–Volterra equations
 *  https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
 '''

X=100 #x is the number of prey (for example, rabbits)
Y=10  #y is the number of some predator (for example, foxes)

## α, β, γ, δ are positive real parameters describing 
## the interaction of the two species.
'''constant double'''
alpha=0.1    #prey growth. The name `alpha` can be used until you want to use the `alpha` processing function.
'''constant double'''
beta=0.01    #interaction of prey with predators
'''constant double'''
gamma=0.001  #the growth of predators depends on the number of prey
'''constant double'''
delta=0.1    #the mortality of predators
##α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 is perfectly stable if Xo=100, Yo=10

Tstep=0.01 #Time step. As short as possible ;-)
N=25       #Number if steps

print   "α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta 
for i in range(0,N,1): # loop over variable "i"
  '''Purpose of the code block below is ...'''
  oldX=X #Local variable is valid only inside its block of code
  print   i,"X:",X," Y:",Y 
  #How X & Y changes in "infinitely short" time step
  X= X + Tstep * (alpha*X-beta*X*Y)     #Prey
  Y= Y + Tstep * (gamma*oldX*Y-delta*Y) #Predator


text("DONE",30,50)

##@date 2024 (https://github.com/borkowsk/bookProcessingEN)
