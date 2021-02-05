//Lotka–Volterra equations
//https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
//https://pl.wikipedia.org/wiki/R%C3%B3wnanie_Lotki-Volterry
//
double X=300;//x is the number of prey (for example, rabbits);
double Y=15;//y is the number of some predator (for example, foxes);

//α, β, γ, δ are positive real parameters describing the interaction of the two species.
final double alpha=0.1;//Prey growth
final double beta=0.01;//interaction of prey with predators
final double gamma=beta/10.0;//the growth of predators depends on the number of pray
final double delta=0.1;//the mortality of predators
//α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 is perfectly stable if Xo=100, Yo=10;

final double Tstep=0.005;//Time step. As short as possible ;-) Why? Lets try! :-D
final float Tlimit=1000;//Time limit as 2/3 of width
final int   DOTSIZE=2;//More flexible visualisation
size(1500,500);

stroke(255,0,0);
println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);

for(double T=0;T<Tlimit;T+=Tstep)// double TIME used as stearing variable!
{
  double oldX=X;//Local variable is valid only inside its block of code
  print('.');//println(T,"X:",X," Y:",Y);
  //How X & Y changes in "infinitely short" time step
  X=X + Tstep * (alpha*X-beta*X*Y);
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y);
  //Visualisation
  float Xf=(float)X,Yf=(float)Y,Tf=(float)T;//float mirrors of variables because of graphics requarements
  stroke(0,255,0);//GREEN for X
  ellipse(Tf,500-Xf,DOTSIZE,DOTSIZE);
  stroke(255,0,0);//RED for Y
  ellipse(Tf,500-Yf,DOTSIZE,DOTSIZE);
  stroke(0,0,255);//BLUE for interaction
  point(1000+Xf,500-Yf);
}

//https://github.com/borkowsk/bookProcessingEN
