/// Population of genetic agents for solving one-dimensional problems.
//-////////////////////////////////////////////////////////////////////////////
/// @date 2026-10-22 (last modification)
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

/// Population of "GAgateks" responsible for implementing basic genetic operations.
/// @details We do not implement crossover because there is no need for it in one-dimensional problems.
class GAPopulation
{
  GAgatek[] all;
  
  double  minx,maxx,range;  ///< Range of 'x' values within which we search.
  boolean     float_coded; ///< Do we use floating-point encoding?
  
  /// @brief Constructor.
  GAPopulation(int population_size,double min_x,double max_x,boolean use_float)
  {
    all=new GAgatek[population_size];
    
    minx=min_x;maxx=max_x;
    range=max_x-min_x;
    float_coded=use_float;
    
    for(int i=0;i<population_size;i++)
    {
      double r=Math.random()*range;
      int as_NKB=map_(r,range);
      
      float f=(float)(minx+r); ///< To inspect the difference with `r` in the debugger.
      int as_float=reinterpret(f);
      
      // Encoding test
      println('*',minx+r,'\t',r,'\t',
              toBin(as_NKB,32),'\t',minx+unmap_(as_NKB,range),'\t',
              toBin(as_float,32),'\t',reinterpret(as_float,(float)(minx),(float)(maxx)) 
              );
              
      if(float_coded)
        all[i]=new GAgatek(as_float);
      else
        all[i]=new GAgatek(as_NKB);
    }
  }
  
  // Accessors:
  //==========
  
  /// @brief Read the value encoded in the gene of a specific agent.
  double get_val(int index)
  {                                      assert(index<all.length);
    int from_gene=all[index].gene;
    if(float_coded)
    {
      float uncoded=reinterpret(from_gene,(float)(minx),(float)(maxx));
      if(uncoded==0) 
              print("*");
      if(Float.isNaN(uncoded))
        return minx; 
      else
        return uncoded;
    }
    else
      return minx+unmap_(from_gene,range);  // NBC
  }
  
  /// @brief Set a new fitness value obtained "from the environment".
  void set_fitness(int index,double new_fitness)
  {                                     assert(index<all.length);
    all[index].fitness=new_fitness;
  }
  
  /// @brief Read the fitness value.
  /// @return The value set in set_fitness, or -Double.MAX_VALUE if not calculated yet.
  double get_fitness(int index)
  {                                     assert(index<all.length);
    return all[index].fitness;
  } 

  // MAIN GENETIC OPERATIONS:
  //=========================

  /// @brief Sort by fitness. @note Fitness values must already be evaluated for all agents!
  /// @param maximize - whether we search for/promote maximum `fitness` or the opposite - minimum (makes sense for functions).
  void sort_by_fitness(boolean maximize)
  {
    if(maximize)
      Arrays.sort(all);
    else
      // Reverse sorting code (descending by fitness):
      Arrays.sort(all, new Comparator() {
        public int compare(Object o1, Object o2) {
          GAgatek g1 = (GAgatek) o1;
          GAgatek g2 = (GAgatek) o2;
          
          // Reverse sorting: compare g2 to g1
          if (g2.fitness > g1.fitness) return -1;
          if (g2.fitness < g1.fitness) return 1;
          return 0;
        }
      });
  }
  
  /// @brief Cloning a gene. The new value can be identical or differ by a single bit.
  //double current_mutation_rate=0;
  int max_mutation_index=0; //(int)(1./current_mutation_rate);
  int randomized_clone(int parent_gene)
  {
    int index=(int)random(max_mutation_index);
    if(index<32)
    {
      int mutated=switch_bit(parent_gene,index,32); // with mutation
      float uncoded=reinterpret( mutated,(float)(minx),(float)(maxx) ); // For checking
      if( !Float.isNaN( uncoded ) )
      {
          if(uncoded==0) 
              print("!");
          return mutated; // Accept mutations only when not "lethal".
      }
    }

    return parent_gene; // No mutation because index landed outside bits or outside the required domain.
  }
  
  /// @brief Producing offspring from the best fitted (so-called "truncation selection").
  /// @note Assumes fitness was calculated and sorting was performed beforehand!
  /// @param selection_r - selection rate, i.e. what fraction of the population will be permanently replaced.
  /// @param mutation_r - how often a bit flip occurs in the newly created clone agent.
  /// @details
  /// Generates `population_size*selection_r` new agents as (possibly mutated) clones of parents 
  /// selected randomly from the top `population_size*(1-selection_r)` agents in the `all` array.
  void clonal_offspring(float selection_r,float mutation_r)
  {
    this.max_mutation_index=(int)(1./mutation_r);
    int border=(int)(all.length*(1-selection_r)); ///< Boundary where the new area begins.
    for(int i=border;i<all.length;i++)
    {
      int parent_index=(int)random(0,border-1);                             assert(parent_index<border);
      int new_gene=randomized_clone(all[parent_index].gene);
      all[i].reset_gene(new_gene); // Resets old fitness as well so it can be recalculated.
    }
  }
  
  /// @brief Producing offspring from winners of duels between random pairs. 
  /// @note Assumes fitness was calculated previously, but sorting was NOT performed!
  /// @param selection_r - selection rate, i.e. what fraction of the population will be permanently replaced.
  /// @param mutation_r - how often a bit flip occurs in the newly created clone agent.
  /// @param maximize - whether we search for/promote maximum `fitness` or the opposite - minimum (makes sense for functions).
  /// @details
  /// Generates `population_size*selection_r` new agents as (possibly mutated) clones of parents 
  /// that won `fitness` duels in randomly picked pairs. 
  void clonal_offspring_by_duels(float selection_r,float mutation_r,boolean maximize)
  {
    this.max_mutation_index=(int)(1./mutation_r);
    int N=(int)(selection_r*all.length); // Number of new offspring, i.e. number of duels.
    for(int pair=0;pair<N;pair++)
    {
      GAgatek A=null,B=null;
      int indexA=-1,indexB=-1;
      
      do{ // Drawing pairs while avoiding suicidal fights and including new offspring.
        indexA=(int)random(all.length);
        indexB=(int)random(all.length);
        A=all[indexA];
        B=all[indexB];
      }while(A.fitness==-Double.MAX_VALUE || B.fitness==-Double.MAX_VALUE || indexB==indexA);
      
      if(maximize) // Are we searching for a maximum?
      {
        if(A.fitness>B.fitness) // 'A' wins
          B.reset_gene(randomized_clone(A.gene));
        else // B wins, even on equal fitness to ensure generational turnover continues.
          A.reset_gene(randomized_clone(B.gene));
      }
      else // Alternatively searching for a minimum.
      {
        if(A.fitness<B.fitness) // 'A' wins (?)
          B.reset_gene(randomized_clone(A.gene));
        else // B wins, even on equal fitness to ensure generational turnover continues.
          A.reset_gene(randomized_clone(B.gene));
      }
    }
  }
  
  // RANGE MAPPING 0..maxVal to signed integer range and vice versa (only needed here for comparative NBC).
  //========================================================================================================
  
  /// @brief Target range width (for 32-bit int, exactly 4,294,967,295).
  final double targetRange = (double) Integer.MAX_VALUE - (double) Integer.MIN_VALUE;
        
  /// @brief Private encoding of `double` value from 0...maxVal range to full signed 32-bit int.      
  private int map_(double val, double maxVal) 
  {
        // Guard against values outside [0, maxVal]
        if (val <= 0) return Integer.MIN_VALUE;
        if (val >= maxVal) return Integer.MAX_VALUE;

        // Calculate mapped value
        double mapped = (double) Integer.MIN_VALUE + (val / maxVal) * targetRange;

        return (int) Math.round(mapped);
  }

  /// @brief Private decoding of `int` value back to given 0...maxVal range.
  private double unmap_(int codedVal, double maxVal) 
  {
      // Calculate codedVal position within int range (0 to 1)
      double percentage = ((double) codedVal - (double) Integer.MIN_VALUE) / targetRange;

      // Scale back to [0, maxVal] range
      double unmapped = percentage * maxVal;

      // Guard against minimal floating-point rounding errors
      if (unmapped <= 0) return 0.0;
      if (unmapped >= maxVal) return maxVal;

      return unmapped;
  }
  
}//_EndOfClass

//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - https://github.com/borkowsk/bookProcessingEN
//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//_EOC
