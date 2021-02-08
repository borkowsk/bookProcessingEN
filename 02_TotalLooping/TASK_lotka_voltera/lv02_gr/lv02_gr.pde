//Lotka–Volterra equations
//https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
//
float X=350;//x is the number of prey (for example, rabbits);
float Y=10;//y is the number of some predator (for example, foxes);

//α, β, γ, δ are positive real parameters describing the interaction of the two species.
float alpha=0.2;//Prey growth
float beta=0.01;//interaction of prey with predators
float gamma=beta/10.0;//the growth of predators depends on the number of pray
float delta=0.05;//the mortality of predators

float Tstep=0.3;//Time step. As short as possible ;-)
int N=1000;//Number if steps
size(1000,500);
println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);

for(int i=0;i<N;i++)
{
  float oldX=X;//Local variable is valid only inside its block of code
  println(i,"X:",X," Y:",Y);
  //Visualisation
  stroke(0,255,0);//GREEN for X
  ellipse(i,500-X,3,3);
  stroke(255,0,0);//RED for Y
  ellipse(i,500-Y,3,3);
  //How X & Y changes in "infinitely short" time step
  X=X + Tstep * (alpha*X-beta*X*Y);
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y);
}

//https://github.com/borkowsk/bookProcessingEN
