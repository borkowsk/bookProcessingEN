/// Two-dimensional genetic algorithm.
//-///////////////////////////////////////////////////////////
/// @date 2026-10-23 ( → https://github.com/borkowsk/bookProcessingEN)

import java.lang.Math;

/// @name Genetic algorithm parameters
/// @{
int     TEMPO=5;                   ///< How many algorithm steps per second?
int     population_size=500;       ///< Solution population size.
float   selection_rate=0.20;       ///< What fraction of the population is replaced in each generation (algorithm step)?
float   mutation_rate=0.015;       ///< What is the mutation rate (can have different interpretations!)
GENE_CODING code=GENE_CODING.FLA;  ///< Should we encode numbers as floating-point values? This makes more sense for finding a minimum than for finding a maximum.
boolean maximize=false;            ///< Are we looking for the maximum of the function? When false, we search for the minimum.
boolean selection_by_duels=true;   ///< Do we use tournament selection (duels) or classical selection - with sorting?
/// @}

GAPopulation Pop;

/// Two-dimensional Rastrigin function.
/// @details 
/// The mathematical formula for two variables is as follows:
///     f(x, y) = 20 + (x² - 10*cos(2πx)) + (y² - 10*cos(2πy))
/// * The recommended search range for the domain is `x in [-5.12, 5.12]` and same for `y`. 
///   In this interval, the function has one clear global minimum at point `(x, y) = (0, 0)`,
///   where the value is `0`. It has about 50 local minima!
///  It is an excellent benchmark for 2D algorithms!
/// * Global minimum (Bottom): Exactly 0.0 at point `(x,y) = (0,0)`.
/// * Global maximum: It is approximately 80.7 for points near the corners of the domain.
/// * cf.: https://www.wikiwand.com/en/Rastrigin_function .
double Rastrigin2D(double x, double y)
{
  if (Double.isNaN(x) || Double.isNaN(y)) {
    println("NaN parameter in Rastrigin2D!");
  }
  
  double result = 20 + (x*x - 10*Math.cos(2*Math.PI*x)) 
                     + (y*y - 10*Math.cos(2*Math.PI*y));
  return result;
} 

void calculate_fitnesses(GAPopulation pop)
{
  for(int i=0;i<pop.all.length;i++)
  {
    double cfit=pop.get_fitness(i);
    if(cfit==-Double.MAX_VALUE) // It had not yet been calculated
    {
      double cx=pop.get_x_val(i);
      double cy=pop.get_y_val(i);
      cfit=Rastrigin2D(cx,cy);
      pop.set_fitness(i,cfit);
    }
  }
}


void draw_function(int opacity)
{
  //stroke(0);
  //line(512,height,512,0);
  //line(512,0,510,6);
  //line(512,0,514,6);
  //line(505,zero,519,zero);
  
  int mi=width;
  int mj=height;
  
  for(int i=0;i<mi;i++)
  {
    double x=i/100.0-5.12;
    for(int j=0;j<mj;j++)
    {
      double y=j/100.0-5.12;
      double z=Rastrigin2D(x,y); //println(x,y,z);
      int intens=(int)(z*3);
      stroke(0,intens,intens,opacity);
      point(i,j);
    }
  }
}

/// @name Triplet of values for the currently best solution
/// @{
double best_fit=-Double.MAX_VALUE;
double x_best=-Double.MAX_VALUE;
double y_best=-Double.MAX_VALUE;
/// @}

void find_the_best(GAPopulation pop)
{
  if(maximize)
  { best_fit=y_best=x_best=-Double.MAX_VALUE; }
  else
  { best_fit=y_best=x_best=Double.MAX_VALUE; }
  
  for(int i=0;i<pop.all.length;i++)
  if(maximize)
  {
    double fit=pop.all[i].fitness;
    if(fit>best_fit)
    {
      best_fit=fit;
      x_best=pop.get_x_val(i);
      y_best=pop.get_y_val(i);
    }
  }
  else
  {
    double fit=pop.all[i].fitness;
    if(fit<best_fit)
    {
      best_fit=fit;
      x_best=pop.get_x_val(i);
      y_best=pop.get_y_val(i);
    }
  }
}

// Draws the population.
void draw_population(GAPopulation pop)
{ 
  stroke(255,0,0);noFill();
  for(int i=0;i<pop.all.length;i++)
  {
    float cx=(float)pop.get_x_val(i)*100+512;
    float cy=(float)pop.get_y_val(i)*100+512;
    double fit=pop.get_fitness(i);
    float cfit=(float)fit*5;
    stroke(cfit,frameCount%256,0,10);
    circle(cx,cy,4);
    point(cx,cy);
    if(fit==best_fit)
    {
      stroke(0,255,0,10);fill(0,255,0,10);
      line(cx,cy,cx+50,cy+50);
      text("X:"+x_best+"\nY:"+y_best+"\nZ:"+best_fit,cx+50,cy+50);
      noFill();
    }
  }
}

void setup()
{
  //tests();
  size(1024,1024);
  Pop=new GAPopulation(population_size,-5.12,5.12,-5.12,5.12,code);
  frameRate(TEMPO);
  draw_function(255);
}

void draw()
{
  if(frameCount%10==0) draw_function(10);
  // Current state:
  
  calculate_fitnesses(Pop);
  draw_population(Pop);
  
  find_the_best(Pop);
  println(frameCount,"\tX:\t",x_best,"\tY:\t",y_best,"\tZ:\t",best_fit);
  
  // Change of state:
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

void keyPressed()
{
   draw_function(128);
}

//-////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: https://github.com/borkowsk/bookProcessingEN
//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//_EOC
