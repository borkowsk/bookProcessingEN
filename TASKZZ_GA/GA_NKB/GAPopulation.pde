/// Populacja agentów genetycznych do rozwiązywania jednowymiarowych problemów.
//-////////////////////////////////////////////////////////////////////////////
/// @date 2026-06-12 (last modyfikacja)
import java.lang.Math;
import java.util.Arrays;
import java.util.Comparator;

/// @brief "GAgatek" czyli agent algorytmu genetycznego.
/// @details
/// Gagatek to potoczne określenie oznaczające figlarza, łobuziaka lub osobę lekkomyślną, 
/// zdolną do nieodpowiedzialnych wybryków i drobnych wykroczeń.  
/// Synonimami są tu m.in. urwis, ancymonek, ziółko czy spryciarz.
class GAgatek implements Comparable
{
  int       gene; ///< Geny są inicjowane w konstruktorze.
  double fitness; ///< Fitness to dopiero określi środowisko.
  
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

/// Populacja "gagatków" zajmuje się implementacją podstawowych operacji genetycznych.
/// @details Nie implementujemy crossing-over bo w problemach jednowymiarowych nie ma potrzeby jego używania.
class GAPopulation
{
  GAgatek[] all;
  
  double  minx,range; ///< Zakres wartości x w jakim szukamy.
  
  /// @brief Konstruktor.
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
  
  // Akcesory:
  //==========
  
  /// @brief Odczytanie wartości zakodowanej w genie konkretnego "gagenta".
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
  
  /// @brief Odczytanie wartości fitness.
  /// @return Wartość ustawioną w set_fitness, a jak jeszcze nie policzone to -Double.MAX_VALUE;
  double get_fitness(int index)
  {                                     assert(index<all.length);
    return all[index].fitness;
  } 

  // GŁÓWNE OPERACJE GENETYCZNE:
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
  
  /// @brief Klonowanie genu. Nowa wartość może być identyczna lub różnić się jednym bitem.
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
  
  /// @brief Produkcja potomstwa najlepiej przystosowanych (tzw. "odcięcie").
  /// @note Zakładamy, że wcześniej policzono fitness i wykonano sortowanie!
  /// @param selection_r - współczynnik selekcji czyli jaka część populacji zostanie bezpowrotnie zastąpiona.
  /// @param mutation_r - jak często zachodzi flip bitu w powstającym klonie gagatka.
  /// @details
  /// Powstaje `population_size*selection_r` nowych agentów będących (niekiedy zmutowanymi) klonami rodziców 
  /// wylosowanych z `population_size*(1-selection_r)` gagatków z "górnej" części tablicy `all`.
  void clonal_offspring(float selection_r,float mutation_r)
  {
    this.max_mutation_index=(int)(1./mutation_r);
    int border=(int)(all.length*(1-selection_r)); ///< Granica od której zaczyna się nowy obszar.
    for(int i=border;i<all.length;i++)
    {
      int parent_index=(int)random(0,border-1);                             assert(parent_index<border);
      int new_gene=randomized_clone(all[parent_index].gene);
      all[i].reset_gene(new_gene); //Przy okazji czyści stary fitness żeby mógł zostać policzony od nowa.
    }
  }
  
  /// @brief Produkcja potomstwa zwycięzców pojedynków losowych par. 
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
      
      if(maximize) //Czy szukamy maksimum?
      {
        if(A.fitness>B.fitness) //Wygrywa A
          B.reset_gene(randomized_clone(A.gene));
        else //Wygrywa B, nawet jak ma równy fitness. Chodzi o to żeby jakaś "wymiana pokoleń" wciąż zachodziła.
          A.reset_gene(randomized_clone(B.gene));
      }
      else //Alternatywnie szukamy minimum.
      {
        if(A.fitness<B.fitness) //Wygrywa A
          B.reset_gene(randomized_clone(A.gene));
        else //Wygrywa B, nawet jak ma równy fitness. Chodzi o to żeby jakaś "wymiana pokoleń" wciąż zachodziła.
          A.reset_gene(randomized_clone(B.gene));
      }
    }
  }
  
  // MAPOWANIE ZAKRESU 0..maxVal na zakres integer-ów i z powrotem.
  //===============================================================
  
  /// @brief Szerokość zakresu docelowego (dla int 32 jest to dokładnie 4 294 967 295).
  final double targetRange = (double) Integer.MAX_VALUE - (double) Integer.MIN_VALUE;
        
  /// @brief Prywatne kodowanie wartości double z zakresu 0...maxVal na cały "signed int" 32-bitowy.      
  private int map_(double val, double maxVal) 
  {
        // Zabezpieczenie przed wartościami spoza zakresu [0, maxVal]
        if (val <= 0) return Integer.MIN_VALUE;
        if (val >= maxVal) return Integer.MAX_VALUE;

        // Obliczenie zmapowanej wartości
        double mapped = (double) Integer.MIN_VALUE + (val / maxVal) * targetRange;

        return (int) Math.round(mapped);
  }

  /// @brief Prywatne dekodowanie wartości z int z powrotem na zadany zakres 0...maxVal.
  private double unmap_(int codedVal, double maxVal) 
  {
      // Obliczenie pozycji codedVal w zakresie int (od 0 do 1)
      double percentage = ((double) codedVal - (double) Integer.MIN_VALUE) / targetRange;

      // Skalowanie powrotne do zakresu [0, maxVal]
      double unmapped = percentage * maxVal;

      // Zabezpieczenie przed minimalnymi błędami zaokrągleń zmiennoprzecinkowych
      if (unmapped <= 0) return 0.0;
      if (unmapped >= maxVal) return maxVal;

      return unmapped;
  }
  
}//_EndOfClass

//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - https://github.com/borkowsk/bookProcessingPL
//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//_EOC
