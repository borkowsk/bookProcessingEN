/// A population of genetic agents for solving one-dimensional problems.
//-////////////////////////////////////////////////////////////////////////////
/// @date 2026-10-22 (last modification)
import java.lang.Math;
import java.util.Arrays;
import java.util.Comparator;

/// @brief "GAgatek" - a genetic algorithm agent (g-agent).
/// @details
/// Gagatek to potoczne określenie oznaczające figlarza, łobuziaka lub osobę lekkomyślną, 
/// zdolną do nieodpowiedzialnych wybryków i drobnych wykroczeń.  
/// Synonimami są tu m.in. urwis, ancymonek, ziółko czy spryciarz.
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

/// The population of "GAgateks" handles the implementation of basic genetic operations.
/// @details Nie implementujemy crossing-over bo w problemach jednowymiarowych nie ma potrzeby jego używania.
class GAPopulation
{
  GAgatek[] all;
  
  double  minx,range; ///< Range of 'x' values within which we search.
  
  /// @brief Constructor.
  GAPopulation(int population_size,double min_x,double max_x)
  {
    all=new GAgatek[population_size];
    
    minx=min_x;
    range=max_x-min_x;
    
    for(int i=0;i<population_size;i++)
    {
      double r=Math.random()*range;
      int as_NKB=map_(r,range);
      
      //Test kodowania
      println('*',minx+r,'\t',r,'\t',
              toBin(as_NKB,32),'\t',minx+unmap_(as_NKB,range)
              );
              
      all[i]=new GAgatek(as_NKB);
    }
  } 
  
  // Accessors:
  //==========
  
  /// @brief Read the value encoded in the gene of a specific g-agent.
  double get_val(int index)
  {                                      assert(index<all.length);
    int from_gene=all[index].gene;
    return minx+unmap_(from_gene,range);  // NKB
  }
  
  /// @brief Ustawienie nowej wartości fitness uzyskanej "ze środowiska".
  void set_fitness(int index,double new_fitness)
  {                                     assert(index<all.length);
    all[index].fitness=new_fitness;
  }
  
  /// @brief Checking the fitness value.
  /// @return Wartość ustawioną w set_fitness, a jak jeszcze nie policzone to -Double.MAX_VALUE;
  double get_fitness(int index)
  {                                     assert(index<all.length);
    return all[index].fitness;
  } 

  // MAIN GENETIC OPERATIONS:
  //============================

  /// @brief Sortowanie wg. fitness. @note Wartości dostosowania muszą być już znane dla wszystkich gagatków!
  /// @param maximize - czy szukamy/promujemy maksimum wartości `fitness` czy przeciwnie - minimum (co ma sens przy funkcjach).
  void sort_by_fitness(boolean maximize)
  {
    if(maximize)
      Arrays.sort(all);
    else
      // Kod sortowania odwrotnego (malejąco po fitness):
      Arrays.sort(all, new Comparator() {
        public int compare(Object o1, Object o2) {
          GAgatek g1 = (GAgatek) o1;
          GAgatek g2 = (GAgatek) o2;
          
          // Odwrotne sortowanie: g2 porównujemy z g1
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
      return switch_bit(parent_gene,index,32); //z mutacją
    else  
      return parent_gene; //Bez mutacji bo trafił poza
  }
  
  /// @brief Producing offspring from the best fitted (so-called "truncation selection").
  /// @note Zakładamy, że wcześniej policzono fitness i wykonano sortowanie!
  /// @param selection_r - współczynnik selekcji czyli jaka część populacji zostanie bezpowrotnie zastąpiona.
  /// @param mutation_r - jak często zachodzi flip bitu w powstającym klonie gagatka.
  /// @details
  /// Powstaje `population_size*selection_r` nowych agentów będących (niekiedy zmutowanymi) klonami rodziców 
  /// drawn from the `population_size*(1-selection_r)` individuals in the "upper" part of the `all` array.
  void clonal_offspring(float selection_r,float mutation_r)
  {
    this.max_mutation_index=(int)(1./mutation_r);
    int border=(int)(all.length*(1-selection_r)); ///< Boundary where the new area begins.
    for(int i=border;i<all.length;i++)
    {
      int parent_index=(int)random(0,border-1);                             assert(parent_index<border);
      int new_gene=randomized_clone(all[parent_index].gene);
      all[i].reset_gene(new_gene); //Przy okazji czyści stary fitness żeby mógł zostać policzony od nowa.
    }
  }
  
  /// @brief Producing offspring from winners of duels between random pairs.
  /// @note Zakładamy, że wcześniej policzono `fitness`, ale nie wykonano sortowania!
  /// @param selection_r - współczynnik selekcji czyli jaka część populacji zostanie bezpowrotnie zastąpiona.
  /// @param mutation_r - jak często zachodzi flip bitu w powstającym klonie gagatka.
  /// @param maximize - czy szukamy/promujemy maksimum wartości `fitness` czy przeciwnie - minimum (co ma sens przy funkcjach).
  /// @details
  /// Powstaje `population_size*selection_r` nowych agentów będących (niekiedy zmutowanymi) klonami rodziców,
  /// którzy wygrali pojedynki na wartość `fitness` w wylosowanych parach. 
  void clonal_offspring_by_duels(float selection_r,float mutation_r,boolean maximize)
  {
    this.max_mutation_index=(int)(1./mutation_r);
    int N=(int)(selection_r*all.length); //Ile nowych potomków, czyli ile pojedynków.
    for(int pair=0;pair<N;pair++)
    {
      GAgatek A=null,B=null;
      int indexA=-1,indexB=-1;
      
      do{ //Losowanie par z uniknięciem walk samobójczych i z nowymi dziećmi.
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
  
  // MAPOWANIE ZAKRESU 0..maxVal na zakres integer-ów i z powrotem.
  //===============================================================
  
  /// @brief Target range width (for 32-bit int, exactly 4,294,967,295).
  final double targetRange = (double) Integer.MAX_VALUE - (double) Integer.MIN_VALUE;
        
  /// @brief Private encoding of `double` value from 0...maxVal range to full signed 32-bit int.   
  private int map_(double val, double maxVal) 
  {
        // Protection against values ​​outside the range [0, maxVal]
        if (val <= 0) return Integer.MIN_VALUE;
        if (val >= maxVal) return Integer.MAX_VALUE;

        // Obliczenie zmapowanej wartości
        double mapped = (double) Integer.MIN_VALUE + (val / maxVal) * targetRange;

        return (int) Math.round(mapped);
  }

  /// @brief Private decoding of `int` value back to given 0...maxVal range.
  private double unmap_(int codedVal, double maxVal) 
  {
      // Obliczenie pozycji codedVal w zakresie int (od 0 do 1)
      double percentage = ((double) codedVal - (double) Integer.MIN_VALUE) / targetRange;

      // Skalowanie powrotne do zakresu [0, maxVal]
      double unmapped = percentage * maxVal;

      // Protection against minor floating-point rounding errors
      if (unmapped <= 0) return 0.0;
      if (unmapped >= maxVal) return maxVal;

      return unmapped;
  }
  
}//_EndOfClass

//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - https://github.com/borkowsk/bookProcessingEN
//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//_EOC
