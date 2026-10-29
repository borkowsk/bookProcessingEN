/// A population of genetic agents for solving one-dimensional problems.
//-////////////////////////////////////////////////////////////////////////////
/// @date 2026-10-23 ( → https://github.com/borkowsk/bookProcessingEN)
import java.lang.Math;
import java.util.Arrays;
import java.util.Comparator;

/// @brief "GAgatek" - a genetic algorithm agent (g-agent).
/// @details
/// "Gagatek" is a colloquial Polish term meaning a rascal, rogue, or prankster, 
/// capable of irresponsible antics and minor mischief.  
/// Synonyms include rascal, imp, scamp, or trickster.
class GAgatek implements Comparable
{
  int       gene; ///< Genes are initialized in the constructor.
  double fitness; ///< Fitness is determined later by the environment.
  
  GAgatek(int i_gene){ gene=i_gene;fitness=-Double.MAX_VALUE; }
  
  void reset_gene(int i_gene) { gene=i_gene;fitness=-Double.MAX_VALUE; }
  
  //double get_fitness() { return fitness; }
  
  int compareTo(Object o)
  {
    GAgatek other=(GAgatek)o;
    if (this.fitness < other.fitness) return 1;
    if (this.fitness > other.fitness) return -1;
    return 0;
  }
  
}//_EndOfClass

/// The population of "GAgatek-s" handles the implementation of basic genetic operations.
/// @details We do not implement crossover because there is no need for it in one-dimensional problems.
class GAPopulation
{
  GAgatek[] all;
  
  double  minx,range; ///< Range of 'x' values within which we search.
  boolean gray_coded; ///< Do we use Gray coding?
  
  /// @brief Constructor.
  GAPopulation(int population_size,double min_x,double max_x,boolean use_Gray)
  {
    all=new GAgatek[population_size];
    
    minx=min_x;
    range=max_x-min_x;
    gray_coded=use_Gray;
    
    for(int i=0;i<population_size;i++)
    {
      double r=Math.random()*range;
      int as_NBC=map_(r,range);
      int as_gray=toGray(as_NBC);
      
      float f=(float)r; ///< To inspect the difference with `r` in the debugger.
      int as_float=reinterpret(f);
      
      //Coding test
      println('*',minx+r,'\t',r,'\t',
              toBin(as_NBC,32),'\t',minx+unmap_(as_NBC,range),'\t',
              toBin(as_gray,32),'\t',minx+unmap_(fromGray(as_gray),range),'\t',
              toBin(as_float,32),'\t',minx+reinterpret(as_float,0f,(float)range) 
              );
              
      if(gray_coded) //TODO Change to an `enum` that specifies the encoding method.
        all[i]=new GAgatek(as_gray);
      else
        all[i]=new GAgatek(as_NBC);
    }
  } 
  
  // Accessors:
  //==========
  
  /// @brief Read the value encoded in the gene of a specific g-agent.
  double get_val(int index)
  {                                      assert(index<all.length);
    int from_gene=all[index].gene;
    if(gray_coded)
      return minx+unmap_(fromGray(from_gene),range);
    else
      return minx+unmap_(from_gene,range);  // NKB/NBC (N-atural B-inary C-ode or N-aturalne K-odowanie B-inarne in Polish)
  }
  
  /// @brief Setting a new fitness value obtained "from the environment".
  void set_fitness(int index,double new_fitness)
  {                                     assert(index<all.length);
    all[index].fitness=new_fitness;
  }
  
  /// @brief Checking the fitness value.
  /// @return The value set in `set_fitness`, and if not calculated yet, -Double.MAX_VALUE;
  double get_fitness(int index)
  {                                     assert(index<all.length);
    return all[index].fitness;
  } 

  // MAIN GENETIC OPERATIONS:
  //============================

  /// @brief Sorting by fitness. @note Sorting by fitness. The fitness values ​​must be known by now for every "GAgatek"
  /// @param maximize - whether we are looking for/promoting the maximum of the `fitness` value or, on the contrary, the minimum (which makes sense in the case of mathematical functions).
  void sort_by_fitness(boolean maximize)
  {
    if(maximize)
      Arrays.sort(all);
    else
      // Reverse sort code (descending by fitness):
      Arrays.sort(all, new Comparator() {
        public int compare(Object o1, Object o2) {
          GAgatek g1 = (GAgatek) o1;
          GAgatek g2 = (GAgatek) o2;
          
          // Reverse sort: g2 is compared to g1
          if (g2.fitness > g1.fitness) return -1;
          if (g2.fitness < g1.fitness) return 1;
          return 0;
        }
      });

    // TOO MODERN - even Processing 4 doesn't understand it: 
    //Arrays.sort(all,Comparator.comparingDouble(GAgatek::get_fitness));
    
    // THIS WORKS IN Processing VERSION 4.
    //// Old-style ascending sort with two-parameter "lambda" function:
    //// It's a bit "magical" because Lambda functions come from a very professional "arsenal".
    //if(maximize)
    //  Arrays.sort(all, (obiektA, obiektB) -> Double.compare(obiektA.fitness, obiektB.fitness)  );
    //else
    //  Arrays.sort(all, (obiektA, obiektB) -> Double.compare(obiektB.fitness, obiektA.fitness)  );
  }
  
  /// @brief Cloning a gene. The new value can be identical or differ by a single bit.
  //double current_mutation_rate=0;
  int max_mutation_index=0; //(int)(1./current_mutation_rate);
  int randomized_clone(int parent_gene)
  {
    int index=(int)random(max_mutation_index);
    if(index<32)
      return switch_bit(parent_gene,index,32); //with mutation
    else  
      return parent_gene; //No mutation because it went out of range
  }
  
  /// @brief Producing offspring from the best fitted (so-called "truncation selection").
  /// @note We assume that fitness has been calculated and sorted beforehand!
  /// @param selection_r - selection rate, i.e. what fraction of the population will be permanently replaced.
  /// @param mutation_r - how often a bit flip occurs in the newly created  g-agent clone.
  /// @details
  /// Generates `population_size*selection_r` new agents as (possibly mutated) clones of parents 
  /// drawn from the `population_size*(1-selection_r)` individuals in the "upper" part of the `all` array.
  void clonal_offspring(float selection_r,float mutation_r)
  {
    this.max_mutation_index=(int)(1./mutation_r);
    int border=(int)(all.length*(1-selection_r)); ///< Boundary where the new area begins.
    for(int i=border;i<all.length;i++)
    {
      int parent_index=(int)random(0,border-1);                             assert(parent_index<border);
      int new_gene=randomized_clone(all[parent_index].gene);
      all[i].reset_gene(new_gene); //At the same time, it cleans the old fitness so that it can be counted again.
    }
  }
  
  /// @brief Producing offspring from winners of duels between random pairs. 
  /// @note We assume that `fitness` was calculated beforehand, but no sorting was performed!
  /// @param selection_r - selection rate, i.e. what fraction of the population will be permanently replaced.
  /// @param mutation_r - how often a bit flip occurs in the newly created  g-agent clone.
  /// @param maximize - whether we are looking for/promoting the maximum of the `fitness` value or, on the contrary, the minimum (which makes sense in the case of mathematical functions).
  /// @details
  /// Generates `population_size*selection_r` new agents as (possibly mutated) clones of parents 
  /// who won the duels for the `fitness` value in drawn pairs.
  void clonal_offspring_by_duels(float selection_r,float mutation_r,boolean maximize)
  {
    this.max_mutation_index=(int)(1./mutation_r);
    int N=(int)(selection_r*all.length); //How many new descendants, i.e. how many duels.
    for(int pair=0;pair<N;pair++)
    {
      GAgatek A=null,B=null;
      int indexA=-1,indexB=-1;
      
      do{ //Drawing pairs to avoid suicidal struggles and with new children.
        indexA=(int)random(all.length);
        indexB=(int)random(all.length);
        A=all[indexA];
        B=all[indexB];
      }while(A.fitness==-Double.MAX_VALUE || B.fitness==-Double.MAX_VALUE || indexB==indexA);
      
      if(maximize) //Are we looking for the maximum?
      {
        if(A.fitness>B.fitness) //'A' wins
          B.reset_gene(randomized_clone(A.gene));
        else //'B' wins, even if it has an equal fitness score. The point is to ensure that some form of "generational turnover" continues to take place.
          A.reset_gene(randomized_clone(B.gene));
      }
      else //Alternatively, we look for the minimum.
      {
        if(A.fitness<B.fitness) //'A' wins
          B.reset_gene(randomized_clone(A.gene));
        else //'B' wins, even if it has an equal fitness score. The point is to ensure that some form of "generational turnover" continues to take place.
          A.reset_gene(randomized_clone(B.gene));
      }
    }
  }
  
  // MAPPING THE RANGE 0..maxVal to a range of integers and back.
  //==============================================================
  
  /// @brief Target range width (for 32-bit int, exactly 4,294,967,295).
  final double targetRange = (double) Integer.MAX_VALUE - (double) Integer.MIN_VALUE;
        
  /// @brief Private encoding of `double` value from 0...maxVal range to full signed 32-bit int.   
  private int map_(double val, double maxVal) 
  {
        // Protection against values ​​outside the range [0, maxVal]
        if (val <= 0) return Integer.MIN_VALUE;
        if (val >= maxVal) return Integer.MAX_VALUE;

        // Calculate mapped value
        double mapped = (double) Integer.MIN_VALUE + (val / maxVal) * targetRange;

        return (int) Math.round(mapped);
  }

  /// @brief Private decoding of `int` value back to given 0...maxVal range.
  private double unmap_(int codedVal, double maxVal) 
  {
      // Calculate codedVal position within `int` range (0 to 1)
      double percentage = ((double) codedVal - (double) Integer.MIN_VALUE) / targetRange;

      // Scaling back to the range [0, maxVal]
      double unmapped = percentage * maxVal;

      // Protection against minor floating-point rounding errors
      if (unmapped <= 0) return 0.0;
      if (unmapped >= maxVal) return maxVal;

      return unmapped;
  }
  
}//_EndOfClass

//-////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: https://github.com/borkowsk/bookProcessingEN
//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//_EOC
