/** Lotka–Volterra equations calculated in double precision.
 *  https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
 */
 
double X=300;  //x is the number of prey (for example, rabbits);
double Y=15;   //y is the number of some predator (for example, foxes);

//α, β, γ, δ are positive real parameters describing the interaction of the two species.
final double alpha=0.1; //prey growth
final double beta=0.01; //interaction of prey with predators
final double gamma=beta/10.0; //the growth of predators depends on the number of prey
final double delta=0.1; //the mortality of predators
//α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 is perfectly stable if Xo=100, Yo=10;

final double Tstep=0.01;  //Time step. As short as possible ;-) Why? Lets try! :-D
final double Tlimit=1000; //Time limit expected to be 2/3 of width

final int    DOTSIZE=2;   //More flexible visualisation

size(1500,500);
println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);

line((float)(Tlimit),0,(float)(Tlimit),height); // see reference for `line`.

for(double T=0;T<Tlimit;T+=Tstep) // double TIME used as stearing variable!
{
  //print('.'); //println(T,"X:",X," Y:",Y);
  //float mirrors of variables because of graphics requairements
  float Xf=(float)(X);
  float Yf=(float)(Y);
  float Tf=(float)(T);
  //Visualisation:
  stroke(0,255,0); //GREEN for X
  ellipse(Tf,height-Xf,DOTSIZE,DOTSIZE);
  stroke(255,0,0); //RED for Y
  ellipse(Tf,height-Yf,DOTSIZE,DOTSIZE);
  stroke(0,0,255); //BLUE for interaction
  point(1000+Xf,height-Yf);
  //How X & Y changes in "infinitely short" time step:
  double oldX=X;  //Old value of X
  X=X + Tstep * (alpha*X-beta*X*Y);
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y);
}

println("DONE");

//@date 2024 (https://github.com/borkowsk/bookProcessingEN)
