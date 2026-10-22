/// A population of genetic agents for solving one-dimensional problems.
//-////////////////////////////////////////////////////////////////////////////
/// @date 2026-10-22 (last modification)
import java.lang.Math;
import java.util.Arrays;
import java.util.Comparator;

/// @brief "GAgatek2G" – that is, a genetic algorithm agent with two genes.
/// @details
/// Gagatek to potoczne określenie oznaczające figlarza, łobuziaka lub osobę lekkomyślną, 
/// zdolną do nieodpowiedzialnych wybryków i drobnych wykroczeń.  
/// Synonimami są tu m.in. urwis, ancymonek, ziółko czy spryciarz.
class GAgatek2G implements Comparable
{
  /// @name Geny. Są inicjowane w konstruktorze.
  /// @{
  int       geneX;
  int       geneY;
  /// @}
  
  double fitness; ///< Fitness is determined later by the environment.
  
  GAgatek2G(int i_geneX,int i_geneY){ geneX=i_geneX; geneY=i_geneY;fitness=-Double.MAX_VALUE; }
  
  void reset_genes(int i_geneX,int i_geneY) {  geneX=i_geneX; geneY=i_geneY;fitness=-Double.MAX_VALUE; }
  
  //double get_fitness() { return fitness; }
  
  int compareTo(Object o)
  {
    GAgatek2G other=(GAgatek2G)o;
    if (this.fitness < other.fitness) return 1;
    if (this.fitness > other.fitness) return -1;
    return 0;
  }
  
}//_EndOfClass

/// Sposoby kodowania liczby zmiennoprzecinkowej na liczbie całkowitej.
enum GENE_CODING{ 
                  NKB, ///< Natural Binary Encoding of the mapped range (N-aturalne K-odowanie B-inarne in Polish)
                  GRY, ///< Gray coding of a mapped range.
                  FLA, ///< Direct bitwise reinterpretation from `float` to `int`. (?)
                  FLR  ///< Bitwise reinterpretation of a `float` as an `int`. (?)
                };

/// The population of "GAgateks" handles the implementation of basic genetic operations.
/// @details Nie implementujemy crossing-over bo w problemach jednowymiarowych nie ma potrzeby jego używania.
class GAPopulation
{
  GAgatek2G[] all;
  
  double  minx,maxx,rangex;  ///< Range of 'x' values within which we search.
  double  miny,maxy,rangey;  ///< Range of 'y' values within which we search.
  GENE_CODING       coding;  ///< What type of encoding do we use for numbers in genes?
  
  /// @brief Constructor.
  GAPopulation(int population_size,double min_x,double max_x,double min_y,double max_y,GENE_CODING use_coding)
  {
    all=new GAgatek2G[population_size];
    
    minx=min_x;maxx=max_x;
    rangex=max_x-min_x;
    
    miny=min_y;maxy=max_y;
    rangey=max_y-min_y;
    
    coding=use_coding;
    
    for(int i=0;i<population_size;i++)
    {
      double rx=Math.random()*rangex;
      double ry=Math.random()*rangey;
  
      int coded_x=Integer.MAX_VALUE;
      int coded_y=Integer.MAX_VALUE;
      
      switch(coding){
        case NKB: 
          coded_x=map_(rx,rangex);
          coded_y=map_(ry,rangey);
        break;
        case GRY:
          coded_x=toGray(map_(rx,rangex));
          coded_y=toGray(map_(ry,rangey));
        break;
        case FLA: // Bezposrednia reinterpretacja bitowa float-->int.
        {
          float fx=(float)(minx+rx);
          float fy=(float)(miny+ry);
          coded_x=reinterpret((float)(fx));
          coded_y=reinterpret((float)(fy));
        }
        break;
        case FLR: // Zakres reinterpretowany bitowo float-->int.
          coded_x=reinterpret((float)(rx));
          coded_y=reinterpret((float)(ry));
        break;
        default:
        println("Invalid gene encoding specifier!"); exit();
        break;
      } //_EndOfSwitch  
      
      all[i]=new GAgatek2G(coded_x,coded_y);
      
      //Test kodowania
      println("*x*\t",minx+rx,'\t',rx,'\t',toBin(coded_x,32),'\t',this.get_x_val(i));
      println("*y*\t",miny+ry,'\t',ry,'\t',toBin(coded_y,32),'\t',this.get_y_val(i),'\n');
              
    }
  }
  
  // Accessors:
  //==========
  
  /// @brief Read the value of 'x' encoded in the gene of a specific g-agent.
  double get_x_val(int index)
  {                                      assert(index<all.length);
    int from_gene=all[index].geneX;
    
    switch(coding){
        case NKB: // Naturalne Kodowanie Binarne zmapowanego zakresu.
          return minx+unmap_(from_gene,rangex);
        case GRY: // Kodowanie Graya zmapowanego zakresu.
          return minx+unmap_(fromGray(from_gene),rangex);
        case FLA: // Bezposrednia reinterpretacja bitowa float-->int.
        {
          float uncoded=reinterpret(from_gene,(float)(minx),(float)(maxx));
          if(Float.isNaN(uncoded))
            return minx; 
          else
            return uncoded;
        }
        case FLR: // Zakres reinterpretowany bitowo float-->int.
        {
          double uncoded=minx+reinterpret(from_gene,0f,(float)(rangex));
          if(Double.isNaN(uncoded))
            return minx; 
          else
            return uncoded;
        }
        default: //To się nie powinno nigdy zdarzać!
            return Double.NaN;
    } 
  }
  
  /// @brief Read the value of 'y' encoded in the gene of a specific g-agent.
  double get_y_val(int index)
  {                                      assert(index<all.length);
    int from_gene=all[index].geneY;
    
    switch(coding){
        case NKB: // Naturalne Kodowanie Binarne zmapowanego zakresu.
          return miny+unmap_(from_gene,rangey);
        case GRY: // Kodowanie Graya zmapowanego zakresu.
          return miny+unmap_(fromGray(from_gene),rangey);
        case FLA: // Bezposrednia reinterpretacja bitowa float-->int.
        {
          float uncoded=reinterpret(from_gene,(float)(miny),(float)(maxy));
          if(Float.isNaN(uncoded))
            return miny; 
          else
            return uncoded;
        }
        case FLR: // Zakres reinterpretowany bitowo float-->int.
        {
          double uncoded=miny+reinterpret(from_gene,0f,(float)(rangey));
          if(Double.isNaN(uncoded))
            return miny; 
          else
            return uncoded;
        }
        default: //To się nie powinno nigdy zdarzać!
            return Double.NaN;
    } 
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
          GAgatek2G g1 = (GAgatek2G) o1;
          GAgatek2G g2 = (GAgatek2G) o2;
          
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
    {
      int mutated=switch_bit(parent_gene,index,32); //z mutacją
      return mutated;
    }

    return parent_gene; //Bez mutacji bo trafił poza bity albo poza wymaganą dziedzinę.
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
      int new_gene_x=randomized_clone(all[parent_index].geneX);
      int new_gene_y=randomized_clone(all[parent_index].geneY);
      all[i].reset_genes(new_gene_x,new_gene_y); //Przy okazji czyści stary fitness żeby mógł zostać policzony od nowa.
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
      GAgatek2G A=null,B=null;
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
        {
          B.reset_genes(randomized_clone(A.geneX),randomized_clone(A.geneY));
        }
        else //'B' wins, even if it has an equal fitness score. The point is to ensure that some form of "generational turnover" continues to take place.
        {
          A.reset_genes(randomized_clone(B.geneX),randomized_clone(B.geneY));
        }
      }
      else //Alternatively, we look for the minimum.
      {
        if(A.fitness<B.fitness) //'A' wins
        {
          B.reset_genes(randomized_clone(A.geneX),randomized_clone(A.geneY));
        }
        else //'B' wins, even if it has an equal fitness score. The point is to ensure that some form of "generational turnover" continues to take place.
        {
          A.reset_genes(randomized_clone(B.geneX),randomized_clone(B.geneY));
        }
      }
    }
  }
  
  // MAPOWANIE ZAKRESU 0..maxVal na zakres integer-ów i z powrotem (tu potrzebne tylko dla porównawczego NKB).
  //==========================================================================================================
  
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
