''' Lotka–Volterra equations. Over time loop.
 * https:##en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
 '''

X=100 #x is the number of prey (for example, rabbits)
Y=15  #y is the number of some predator (for example, foxes)

##α, β, γ, δ are positive real parameters describing the interaction of the two species.
alpha=0.1 #prey growth
beta=0.01 #interaction of prey with predators
gamma=beta/10.0 #the growth of predators depends on the number of prey
delta=0.1 #the mortality of predators
##α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 is perfectly stable if Xo=100, Yo=10

Tstep=0.05 #Time step. As short as possible ;-)

size(1000,500)
print   "α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta 

## Why i? T may be used instead!
for T in range(0,1000,Tstep): # "T"  is used as stearing variable! 
  '''Ups! `float` range unavailable in core Python! We need `numPy.arange` or something similar.
  See: https://stackoverflow.com/questions/7267226/range-for-floats '''
  #println(T,"X:",X," Y:",Y)
  #Visualisation
  stroke(0,255,0) #GREEN for X
  ellipse(T,500-X,3,3)
  stroke(255,0,0) #RED for Y
  ellipse(T,500-Y,3,3)
  #How X & Y changes in "infinitely short" time step
  oldX=X #Local variable may be declared in any place before use
  X=X + Tstep * (alpha*X-beta*X*Y)
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y)


##@date 2024 (https://github.com/borkowsk/bookProcessingEN)
