/// Narzędzia bitowe dla algorytmów ewolucyjnych.  
//-//////////////////////////////////////////////
/// @date 2026-06-12 (zmodyfikowany)
// Skomentowane w standardzie Doxygen.

/// Tworzy string z reprezentacją heksadecymalną liczby typu integer (32-bitowy).
/// @param sou - wartość wejściowa.
/// @param USE_BITS - ograniczenie liczby bitów.
public String toHex(int sou,int USE_BITS)
{                                                     assert(USE_BITS <= 32);
  int form=(USE_BITS+3)/4;
  return hex(sou,form);
}

/// Tworzy string z reprezentacją heksadecymalną liczby typu long integer (64 bitowy).
/// @param sou - wartość wejściowa.
/// @param USE_BITS - ograniczenie liczby bitów.
public String toHex(long sou,int USE_BITS)
{                                                     assert(USE_BITS <= 64);
  if(USE_BITS>32)
  {
    int high=(int)(sou>>>32);
    int low =(int)(sou);
    return toHex(high,USE_BITS-32)+"."+toHex(low,32);
  }
  else
    return toHex((int)(sou),USE_BITS);
}

/// Tworzy string z reprezentacją binarną liczby typu integer (32-bitowy).
/// @param sou - wartość wejściowa.
/// @param USE_BITS - ograniczenie liczby bitów.
public String toBin(int sou,int USE_BITS)
{                                                     assert(USE_BITS <= 32);
  return binary(sou,USE_BITS);
}

/// Tworzy string z reprezentacją binarną liczby typu long integer (64 bitowy).
/// @param sou - wartość wejściowa.
/// @param USE_BITS - ograniczenie liczby bitów.
public String toBin(long sou,int USE_BITS)
{                                                     assert(USE_BITS <= 64);
  if(USE_BITS>32)
  {
    int high=(int)(sou>>>32);
    int low =(int)(sou);
    return toBin(high,USE_BITS-32)+"."+toBin(low,32);
  }
  else
    return toBin((int)(sou),USE_BITS);
}

/// @name kodowanie z NKB na kod Graya. 
/// @details
/// Funkcje przyjmują zwykłą liczbę (np. wylosowaną) i zwracają jej reprezentację w kodzie Graya.
/// @{
  
/// Kodowanie 32 bitowej liczby NKB ze znakiem na kod Graya.
/// @param n - liczba ze znakiem zakodowana naturalnie (NKB).
/// @return liczba `n` zakodowana kodem Graya.
public static int toGray(int n) {
    return n ^ (n >>> 1);
}

/// Kodowanie 64 bitowej liczby NKB ze znakiem na kod Graya.
/// @param n - liczba ze znakiem zakodowana naturalnie (NKB).
/// @return liczba `n` zakodowana kodem Graya.
public static long toGray(long n) {
    return n ^ (n >>> 1);
}
/// @}


/// Dekodowanie powrotne z kodu Graya na NKB.
/// @details 
/// Jest to nieco bardziej skomplikowane i wymaga iteracyjnego (lub kaskadowego) nakładania operacji XOR, 
/// ponieważ każdy bit liczby NKB zależy od wszystkich bitów stojących przed nim.
/// Oto najbardziej wydajne, bezpętlowe implementacje bitowe (działające w czasie logarytmicznym).
/// @note Z pomocą Gemini, ale sprawdzone testem.
/// @{

/// Dekodowanie 32 bitowej liczby ze znakiem w kodzie Graya.
/// @param g - liczba zakodowana kodem Graya.
/// @return liczba `g` zdekodowana na kod NKB.
public static int fromGray(int g) {
    g ^= (g >>> 16);
    g ^= (g >>> 8);
    g ^= (g >>> 4);
    g ^= (g >>> 2);
    g ^= (g >>> 1);
    return g;
}

/// Dekodowanie 64 bitowej liczby ze znakiem w kodzie Graya.
/// @param g - liczba zakodowana kodem Graya.
/// @return liczba `g` zdekodowana na kod NKB.
public static long fromGray(long g) {
    g ^= (g >>> 32);
    g ^= (g >>> 16);
    g ^= (g >>> 8);
    g ^= (g >>> 4);
    g ^= (g >>> 2);
    g ^= (g >>> 1);
    return g;
}
/// @}

/// @name Funkcje obrabiające BEZ-ZNAKOWE, 32-bitowe liczby w kodzie Graya.
/// @details
/// W Javie 32-bitowa wartość bez znaku (unsigned int) mieści się w 64-bitowym typie long. 
/// Aby traktować int jako unsigned w kontekście kodu Graya, musimy zadbać o dwie rzeczy:
/// - Przy konwersji do Graya (long -> int) – uciąć wyższe 32 bity, aby operacja XOR nie 
///   uwzględniała śmieci spoza zakresu.
/// - Przy dekodowaniu (int -> long) – potraktować bity z int jako czystą wartość dodatnią 
///   (odciąć rozszerzenie znaku), a następnie przeprowadzić dekodowanie.
/// @{
  
/// Kodowanie liczby z zakresu 0...2^32 na 32 kod Graya. 
/// @param n - zakodowana naturalnie (NKB) liczba nieujemna, nie większa niż 2^32.
/// @return liczba `n` zakodowana kodem Graya.
/// @note Z pomocą Gemini, ale sprawdzone testem.
public static int toGrayU32(long n) 
{
    // Obcinamy long do 32 bitów, aby operować wyłącznie na zakresie unsigned int
    int bin = (int) n;
    // Wykonujemy klasyczną operację Graya na 32 bitach
    return bin ^ (bin >>> 1);
}

/// Dekodowanie zakodowane kodem Graya 32 bitowej liczby na liczbę z zakresu 0...2^32.
/// @param g - liczba zakodowana kodem Graya.
/// @return liczba `g` zdekodowana na NKB.
public static long fromGrayU32(int g) {
    // Krok 1: Dekodujemy kod Graya na poziomie 32 bitów
    g ^= (g >>> 16);
    g ^= (g >>> 8);
    g ^= (g >>> 4);
    g ^= (g >>> 2);
    g ^= (g >>> 1);
    
    // Krok 2: Konwertujemy zdekodowany int na bez-znakowy long (maska 0xFFFFFFFFL)
    return g & 0xFFFFFFFFL;
}
/// @}

/// @name Reinterpretacje bitów int i long na float i double i odwrotnie.
///       ===============================================================
/// @details Mutowanie bitów reprezentacji zmiennoprzecinkowej obciążone jest
///          wieloma możliwościami uzyskania letalnych kombinacji, 
///          przede wszystkim wychodzących poza sensowny dla zadania zakres.
///          Pozwala jednak dojść algorytmowi znacznie bliżej rozwiązania niż
///          mapowanie zakresu na liczbę typu `int` czy nawet `long`.
/// @{
    
    ///@returns wartość z zakresu. Jeśli ciąg bitowy nie daje wartości z zakresu 
    ///         lub jest którąś z nie-liczb to zwracane jest Float.NaN, co można
    ///         sprawdzić warunkiem `if(Float.isNaN(...)) ...`.
    float   reinterpret(int src,float min,float max)
    {
      float val=Float.intBitsToFloat(src);
      if(min<=val && val<=max)
        return val;
      else
        return Float.NaN;
    }
    
    ///@returns wartość z zakresu. Jeśli ciąg bitowy nie daje wartości z zakresu 
    ///         lub jest którąś z nie-liczb to zwracane jest Float.NaN, co można
    ///         sprawdzić warunkiem `if(Float.isNaN(...)) ...`.
    double reinterpret(long src,double min,double max)
    {
      double val=Double.longBitsToDouble(src);
      if(min<=val && val<=max)
        return val;
      else
        return Double.NaN;
    }
    
    ///@returns liczbę typu `int` o takiej samej reprezentacji bitowej jak `src`.
    ///@note jak "reinterpret_cast" w C++.
    int reinterpret(float src)
    {
      return Float.floatToIntBits(src);
    }
    
    ///@returns liczbę typu `long` o takiej samej reprezentacji bitowej jak `src`.
    ///@note jak "reinterpret_cast" w C++.
    long reinterpret(double src)
    {
      return Double.doubleToLongBits(src);
    }
  
/// @}  

/// @name Funkcje kodujące mniejsze geny o długości do 31 bitów w ciągu 64 bitów.
/// @details
/// Do upakowania wielu genów w jednym 64-bitowym ciągu (long) idealnie nadają się operacje na maskach bitowych.
/// W poniższych implementacjach przyjmujemy standardową konwencję, gdzie bit o indeksie 0 to najmniej znaczący bit 
/// (LST, po prawej stronie), a bit 63 to bit najstarszy (po lewej stronie). 
/// @note Poniższe wysoce wydajne, BEZWARUNKOWE funkcje realizują to zadanie, ale nie sprawdzają poprawności parametrów!
/// [Gemini]
/// @{
  
/// Funkcja wycina określoną liczbę bitów (length) zaczynając od pozycji start_pos (włącznie).
/// @details Przesuwa je na sam początek ciągu, zwracając jako czystą wartość int (unsigned).
/// @returns WYEKSTRACHOWANY CIĄGU BITÓW na liczbie typu `int` (32 bity).
public static int get_bits(long value, int pos, int length) 
{                                                                               assert(0<=pos && pos < 64);
    // 1. Przesuwamy interesujące nas bity na samą prawą stronę (pozycję 0)
    long shifted = value >>> pos;
    
    // 2. Tworzymy maskę bitową o żądanej długości (np. dla length=5: 00011111)
    long mask = (1L << length) - 1;
    
    // 3. Wycinamy bity maską i bezpiecznie rzutujemy na int
    return (int) (shifted & mask);
}

/// Funkcja wstawia wartość genu (gene_value) o określonej długości (length) w wybrane miejsce (start_pos) wewnątrz oryginalnego ciągu long. 
/// @note Stare bity na tych pozycjach są całkowicie nadpisywane.
/// @return Zwraca nowy ciąg 64 bitowy na liczbie typu `long`.
public static long put_bits(long old_value, int pos, int length, int put_value)
{                                                                               assert(0<=pos && pos < 64);
    // 1. Tworzymy maskę dla genu (np. dla length=5: 00011111)
    long mask = (1L << length) - 1;
    
    // 2. Czyszczona jest wartość genu ze struktur powyżej 'length' (zabezpieczenie)
    long clean_gene = put_value & mask;
    
    // 3. Tworzymy maskę czyszczącą dla oryginalnej liczby (zera na docelowych pozycjach)
    long clear_mask = ~(mask << pos);
    
    // 4. Czyścimy miejsce w oryginalnej liczbie i wstawiamy przesunięty gen za pomocą OR (|)
    return (old_value & clear_mask) | (clean_gene << pos);
}
/// @}

/// Funkcj3 do odwracania wartości konkretnego bitu (do użycia w mutacjach).
/// @param sou - wartość wejściowa do zmutowania.
/// @param pos - określa w jakiej pozycji flip-flop-ujemy bit.
/// @param USE_BITS - ograniczenie liczby bitów gdzie może zajść zmiana.
/// @return liczba `sou` z odwróconym bitem na pozycji `pos`.
/// @note POZOSTAŁE BITY. TAKŻE TE POWYŻEJ `USE_BITS` NIE ULEGAJĄ ZMIANIE.
/// @{

/// Wersja 32 bitowa.  
public  int switch_bit(int sou,int pos,int USE_BITS)
{
  if(pos>=USE_BITS)
  {
    println(" Mutation outside BITMASK");
    return sou;
  }//else Pozycja jest poprawna.
  
  int bit=0x1<<pos; // Ustawianie pozycji na masce.
  return sou^bit;   // Przełączenie bitu wg. maski. (xor should do the job).
}


/// Wersja 64 bitowa.  
public  long switch_bit(long sou,int pos,int USE_BITS)
{
  if(pos>=USE_BITS)
  {
    println(" Mutation outside BITMASK");
    return sou;
  }//else Pozycja jest poprawna.
  
  long bit=0x1<<pos; // Ustawianie pozycji na masce.
  return sou^bit;    // Przełączenie bitu wg. maski. (xor should do the job).
}
/// @}

/// @name Funkcje do wykonywania crossing-over.
/// @details 
///   Działa prosto przy założeniu upraszczającym, że zawsze początkowa część jest od pierwszego rodzica, 
///   a od pozycji "pos" mamy bity od drugiego rodzica. Jeśli chcesz uzyskać efekt odwrotny to...
///   Zamień kolejność rodziców w wywołaniu!
/// @{
  
/// Crossing over dla chromosomów 32 bitowych.  
public static int cross_over(int parent1, int parent2, int pos) 
{                                                                assert(0<=pos && pos < 32);
    // 1. Tworzymy maskę dla końcowych (młodszych) bitów od pozycji 'pos' w prawo.
    // Np. dla pos = 4, maska to cztery jedynki: 000...0001111
    int mask = (1 << pos) - 1;

    // 2. ~mask zachowuje bity po lewej stronie (starsze) pierwszego rodzica.
    // 3. mask zachowuje bity po prawej stronie (młodsze) drugiego rodzica.
    return (parent1 & ~mask) | (parent2 & mask);
}

/// Crossing over dla chromosomów 64 bitowych.
public static long cross_over(long parent1, long parent2, int pos) 
{                                                                assert(0<=pos && pos < 64);
    // 1. Tworzymy 64-bitową maskę za pomocą literału 1L.
    long mask = (1L << pos) - 1;

    // 2. Łączymy lewą część pierwszego rodzica z prawą częścią drugiego rodzica.
    return (parent1 & ~mask) | (parent2 & mask);
}
/// @}

/// Funkcja testująca zestaw narzędzi dla GA.
void tests()
{
  int testi=0x00FFAA11;
  long testl=0x1100AABBC0DDEEFFl; //0x8100000A000000EFl; //0x1001010110000000l; //0x1100AABBC0DDEEFFl;
  
  println("\nLiczby 32 bitowe ze znakiem:\n============================");
  println("NKB:",testi);
  println("24b:",toHex(testi,24),"\t",toBin(testi,24));
  println("32b:",toHex(testi,32),"\t",toBin(testi,32));
  int gri=toGray(testi);
  println("gri:",toHex(gri,32),"\t",toBin(gri,32));
  int ugr=fromGray(gri);
  println("ugr:",toHex(ugr,32),"\t",toBin(ugr,32));
  
  println("\nLiczby 64 bitowe ze znakiem:\n============================");
  println("NKB:",testl);
  println("24b:",toHex(testl,24),"\t\t\t",toBin(testl,24));
  println("48b:",toHex(testl,48),"\t\t",toBin(testl,48));
  println("64b:",toHex(testl,64),"\t",toBin(testl,64));
  int  _0to24=get_bits(testl,0,24);
  println("0+24b:",toHex(_0to24,32),"\t\t\t\t\t\t    ",toBin(_0to24,32));
  int  _1to15=get_bits(testl,1,14);
  println("1+14b:",toHex(_1to15,32),"\t\t\t\t\t\t   ",toBin(_1to15,32));
  int  _lst4b=get_bits(testl,60,4);
  println("58+4b:",toHex(_lst4b,32),"\t\t",toBin(_lst4b,4));
  long grl=toGray(testl);
  println("gri:",toHex(grl,64),"\t",toBin(grl,64));
  long ugl=fromGray(grl);
  println("ugr:",toHex(ugl,64),"\t",toBin(ugl,64));
  
  println("\nZakodowanie bez znaku liczby z zakresu 0..2^32:\n===============================================");
  long trzyMiliardy=3000000000l;
  int gray_coded_u=toGrayU32(trzyMiliardy);
  println(trzyMiliardy,"=?=",fromGrayU32(gray_coded_u));
  println(toBin(trzyMiliardy,32),"==>",toBin(gray_coded_u,32));
  println(toBin(fromGrayU32(gray_coded_u),32));
  
  println("\nMutacja reprezentacji greyowej:\n===============================");
  int gray_coded_u1=switch_bit(gray_coded_u,0,32);
  println(trzyMiliardy," < ",fromGrayU32(gray_coded_u1));
  println("----------------------------------->",toBin(gray_coded_u1,32));
  
  int gray_coded_u2=switch_bit(gray_coded_u,30,32);
  println(trzyMiliardy," < ",fromGrayU32(gray_coded_u2));
  println("----------------------------------->",toBin(gray_coded_u2,32));
  
  println("Inserted:");
  long after_ins=put_bits(0L,16,32,gray_coded_u);
  println("------------------->",toBin(after_ins,64));
  
  println("\nCrossing over:\n==============");
  println(toBin(gray_coded_u1,32));
  println(toBin(gray_coded_u2,32));
  println("-----------------------------------------------");
  int c1=cross_over(gray_coded_u1,gray_coded_u2,24);
  println(toBin(c1,32)," = ",fromGrayU32(c1));
  int c2=cross_over(gray_coded_u2,gray_coded_u1,24);
  println(toBin(c2,32)," = ",fromGrayU32(c2));
  
  println("\n\nEND of TESTS!");
}

//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - https://github.com/borkowsk/bookProcessingPL
//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//_EOC
