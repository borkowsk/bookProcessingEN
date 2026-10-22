/// Very simple genetic algorithm using mutations only.
//-///////////////////////////////////////////////////////////
/// @date 2026-10-22 (modified)

import java.lang.Math;

/// @name Genetic algorithm parameters
/// @{
int     TEMPO=5;                   ///< How many algorithm steps per second?
int     population_size=500;       ///< Solution population size.
float   selection_rate=0.20;       ///< What fraction of the population is replaced in each generation (algorithm step)?
float   mutation_rate=0.015;       ///< What is the mutation rate (can have different interpretations!)
boolean use_float_code=true;       ///< Do we encode numbers as floating-point? Makes more sense for finding minima than maxima.
boolean maximize=false;            ///< Are we looking for the maximum of the function? When false, we search for the minimum.
boolean selection_by_duels=true;   ///< Do we use tournament selection (duels) or classical selection - with sorting?
/// @}

GAPopulation Pop;

/// One-dimensional Rastrigin Function.
/// @details 
/// The mathematical formula for a single variable is as follows:
///      \(f(x)=10+x^{2}-10\cdot \cos (2\pi x)\)
///      f(X) = 10 + x² - 10 cos(2πx)
/// * Recommended domain search interval is `x in [-5.12, 5.12]`. 
///   In this interval, the function has one clear global minimum at point `x = 0`,
///   where the value is `0`, and multiple local minima ("valleys", in which 
///   you can observe the algorithm getting stuck if the mutation rate is too small).
/// * Global minimum (Bottom): Exactly 0.0 at point `x = 0`.
/// * Global maximum (Peak): Approximately 40.35 at points \(x \approx \pm 4.523\).
/// * cf.: https://www.wikiwand.com/en/Rastrigin_function . There are also links to 
///   other interesting benchmark functions for optimization algorithms.
double Rastrigin(double x)
{
  if(Double.isNaN(x))
      println("NaN parameter!"); 
  double result=10+x*x-10*Math.cos(2*x*Math.PI);
  return result;
}

void calculate_fitnesses(GAPopulation pop)
{
  for(int i=0;i<pop.all.length;i++)
  {
    double cfit=pop.get_fitness(i);
    if(cfit==-Double.MAX_VALUE) // Not evaluated yet
    {
      double cx=pop.get_val(i);
      cfit=Rastrigin(cx);
      //if(cfit==0) println("DEBUG:",cx); //Of course this will often happen with `float` encoding when `0` is within range!
      pop.set_fitness(i,cfit);
    }
  }
}


float zero=-5; ///< Position Y==0 as coordinate in the window.

void draw_function()
{
  stroke(0);
  line(512,height,512,0);
  line(512,0,510,6);
  line(512,0,514,6);
  line(505,zero,519,zero);
  
  int mi=width-1;
  float old_y=(float)Rastrigin(-5.13);
  stroke(0,255,255);
  for(int i=0;i<mi;i++)
  {
    double x=i/100.0-5.12;
    float y=(float)Rastrigin(x); //println(x,y);
    line(i-1,zero-old_y*10,i,zero-y*10);
    old_y=y;
  }
}

/// @name Pair of values for the currently best solution
/// @{
double best_fit=-Double.MAX_VALUE;
double x_best=-Double.MAX_VALUE;
/// @}

void find_the_best(GAPopulation pop)
{
  if(maximize)
  { best_fit=x_best=-Double.MAX_VALUE; }
  else
  { best_fit=x_best=Double.MAX_VALUE; }
  
  for(int i=0;i<pop.all.length;i++)
  if(maximize)
  {
    double fit=pop.all[i].fitness;
    if(fit>best_fit)
    {
      best_fit=fit;
      x_best=pop.get_val(i);
    }
  }
  else
  {
    double fit=pop.all[i].fitness;
    if(fit<best_fit)
    {
      best_fit=fit;
      x_best=pop.get_val(i);
    }
  }
}

// Draws the population.
void draw_population(GAPopulation pop)
{ 
  stroke(255,0,0);noFill();
  for(int i=0;i<pop.all.length;i++)
  {
    float cx=(float)pop.get_val(i)*100+512;
    float cfit=zero-(float)pop.get_fitness(i)*10;
    circle(cx,cfit,4);
    point(cx,cfit);
  }
}

void setup()
{
  //tests();
  size(1024,450);
  zero=height-5;
  Pop=new GAPopulation(population_size,-5.12,5.12,use_float_code);
  frameRate(TEMPO);
}

void draw()
{
  background(255);
  // Current state:
  draw_function();
  calculate_fitnesses(Pop);
  draw_population(Pop);
  
  find_the_best(Pop);
  fill(0,255,0);
  textSize(24);
  text("X="+x_best,width/2,24);
  text("Y="+best_fit,width/2,48);
  println(frameCount,"\tX:\t",x_best,"\tY:\t",best_fit);
  
  // State change:
  if(selection_by_duels)
  {
    Pop.clonal_offspring_by_duels(selection_rate,mutation_rate,maximize);
  }
  else
  {
    Pop.sort_by_fitness(maximize);
    Pop.clonal_offspring(selection_rate,mutation_rate);
  }
}

//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - https://github.com/borkowsk/bookProcessingEN
//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//_EOC
