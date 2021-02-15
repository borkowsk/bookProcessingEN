//Lotka–Volterra equations
//https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations

float X=100;//x is the number of prey (for example, rabbits);
float Y=10;//y is the number of some predator (for example, foxes);

//α, β, γ, δ are positive real parameters describing 
//the interaction of the two species.
float alpha=0.001, beta=0.01, gamma=0.001, delta=0.1;//What is the meaning of these parameters?
println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);

float Tstep=0.01;//Time step. As short as possible ;-)
int N=25;//Number of steps

for(int i=0;i<N;i++)
{
  println(i,"X:",X," Y:",Y);
  //How X & Y changes in "infinitely short" time step
  float oldX=X;//Such local variable is valid only inside its block of code
  X = X + Tstep * (alpha*X-beta*X*Y);//What is the meaning of these parameters?
  Y = Y + Tstep * (gamma*oldX*Y-delta*Y);//See lv02.pde, if you haven't guessed!
}

//https://github.com/borkowsk/bookProcessingEN
