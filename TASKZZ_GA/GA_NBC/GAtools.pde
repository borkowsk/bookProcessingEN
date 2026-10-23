/// Bitwise tools for evolutionary algorithms.  
//-//////////////////////////////////////////////
/// @date 2026-10-23 (modified)
// Commented using the Doxygen standard.

/// Creates a hexadecimal string representation of a 32-bit integer.
/// @param sou - input value.
/// @param USE_BITS - bit count limit.
public String toHex(int sou,int USE_BITS)
{                                                     assert(USE_BITS <= 32);
  int form=(USE_BITS+3)/4;
  return hex(sou,form);
}

/// Creates a hexadecimal string representation of a 64-bit long integer.
/// @param sou - input value.
/// @param USE_BITS - bit count limit.
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

/// Creates a binary string representation of a 32-bit integer.
/// @param sou - input value.
/// @param USE_BITS - bit count limit.
public String toBin(int sou,int USE_BITS)
{                                                     assert(USE_BITS <= 32);
  return binary(sou,USE_BITS);
}

/// Creates a binary string representation of a 64-bit long integer.
/// @param sou - input value.
/// @param USE_BITS - bit count limit.
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

/// @name Encoding from NBC to Gray code. 
/// @details
/// Functions accept a standard number (e.g., randomly generated) and return its Gray code representation.
/// @{
  
/// Encoding a 32-bit signed NBC number into Gray code.
/// @param n - signed number encoded in natural binary code (NBC).
/// @return number `n` encoded in Gray code.
public static int toGray(int n) {
    return n ^ (n >>> 1);
}

/// Encoding a 64-bit signed NBC number into Gray code.
/// @param n - signed number encoded in natural binary code (NBC).
/// @return number `n` encoded in Gray code.
public static long toGray(long n) {
    return n ^ (n >>> 1);
}
/// @}


/// Decoding back from Gray code to NBC.
/// @details 
/// This is slightly more complex and requires iterative (or cascaded) XOR operations, 
/// because each bit of the NBC number depends on all the bits preceding it.
/// These are the most efficient, loopless bitwise implementations (operating in logarithmic time).
/// @note Created with the help of Gemini, but verified by tests.
/// @{

/// Decoding a 32-bit signed number from Gray code.
/// @param g - Gray code encoded number.
/// @return number `g` decoded to NBC.
public static int fromGray(int g) {
    g ^= (g >>> 16);
    g ^= (g >>> 8);
    g ^= (g >>> 4);
    g ^= (g >>> 2);
    g ^= (g >>> 1);
    return g;
}

/// Decoding a 64-bit signed number from Gray code.
/// @param g - Gray code encoded number.
/// @return number `g` decoded to NBC.
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

/// @name Functions processing UNSIGNED 32-bit numbers in Gray code.
/// @details
/// In Java, an unsigned 32-bit value fits inside a 64-bit long type. 
/// To treat an int as unsigned in the context of Gray code, two things must be handled:
/// - During encoding to Gray code (long -> int) – truncate upper 32 bits so XOR operations 
///   do not include garbage outside the range.
/// - During decoding (int -> long) – treat bits from int as a pure positive value 
///   (strip sign extension) and then perform decoding.
/// @{
  
/// Encoding a number from the range 0...2^32 into 32-bit Gray code. 
/// @param n - naturally encoded (NBC) non-negative number, not exceeding 2^32.
/// @return number `n` encoded in Gray code.
/// @note Created with the help of Gemini, but verified by tests.
public static int toGrayU32(long n) 
{
    // Truncate long to 32 bits to operate strictly within unsigned int range
    int bin = (int) n;
    // Perform standard Gray operation on 32 bits
    return bin ^ (bin >>> 1);
}

/// Decoding a Gray code encoded 32-bit number into a number in the range 0...2^32.
/// @param g - Gray code encoded number.
/// @return number `g` decoded to NBC.
public static long fromGrayU32(int g) {
    // Step 1: Decode Gray code at the 32-bit level
    g ^= (g >>> 16);
    g ^= (g >>> 8);
    g ^= (g >>> 4);
    g ^= (g >>> 2);
    g ^= (g >>> 1);
    
    // Step 2: Convert decoded int to unsigned long (using mask 0xFFFFFFFFL)
    return g & 0xFFFFFFFFL;
}
/// @}

/// @name Bit reinterpretation of `int` and long to float and double, and vice versa.
///       ===================================================================
/// @details Mutating bits of floating-point representations carries 
///          many possibilities of producing lethal combinations, 
///          primarily exceeding the meaningful range for the task.
///          However, it allows the algorithm to get much closer to the solution 
///          than mapping the range to an `int` or even `long` type.
/// @{
    
    ///@returns value within range. If the bit string does not yield a value within range 
    ///         or is NaN, Float.NaN is returned, which can be checked via `if(Float.isNaN(...)) ...`.
    float   reinterpret(int src,float min,float max)
    {
      float val=Float.intBitsToFloat(src);
      if(min<=val && val<=max)
        return val;
      else
        return Float.NaN;
    }
    
    ///@returns value within range. If the bit string does not yield a value within range 
    ///         or is NaN, Double.NaN is returned, which can be checked via `if(Double.isNaN(...)) ...`.
    double reinterpret(long src,double min,double max)
    {
      double val=Double.longBitsToDouble(src);
      if(min<=val && val<=max)
        return val;
      else
        return Double.NaN;
    }
    
    ///@returns an `int` with the same bit representation as `src`.
    ///@note similar to "reinterpret_cast" in C++.
    int reinterpret(float src)
    {
      return Float.floatToIntBits(src);
    }
    
    ///@returns a `long` with the same bit representation as `src`.
    ///@note similar to "reinterpret_cast" in C++.
    long reinterpret(double src)
    {
      return Double.doubleToLongBits(src);
    }
  
/// @}  

/// @name Functions encoding smaller genes with lengths up to 31 bits within a 64-bit sequence.
/// @details
/// Bitwise mask operations are ideal for packing multiple genes into a single 64-bit sequence (long).
/// In the following implementations, we adopt the standard convention where bit index 0 is the least significant bit 
/// (LSB, on the right), and bit 63 is the most significant bit (on the left). 
/// @note The following highly efficient, UNCONDITIONAL functions perform this task, but do not check parameter validity!
/// [Gemini]
/// @{
  
/// Extracts a specified number of bits (length) starting from `pos` (inclusive).
/// @details Shifts them to the very beginning of the sequence, returning them as a pure int (unsigned) value.
/// @returns EXTRACTED BIT SEQUENCE stored in an `int` (32 bits).
public static int get_bits(long value, int pos, int length) 
{                                                                               assert(0<=pos && pos < 64);
    // 1. Shift target bits all the way to the right side (position 0)
    long shifted = value >>> pos;
    
    // 2. Create a bit-mask of desired length (e.g., for length=5: 00011111)
    long mask = (1L << length) - 1;
    
    // 3. Extract bits using mask and safely cast to `int`
    return (int) (shifted & mask);
}

/// Inserts a gene value (put_value) of specified length into a designated position (`pos`) inside the original long sequence. 
/// @note Existing bits at these positions are completely overwritten.
/// @return Returns the new 64-bit sequence as a `long`.
public static long put_bits(long old_value, int pos, int length, int put_value)
{                                                                               assert(0<=pos && pos < 64);
    // 1. Create a mask for the gene (e.g., for length=5: 00011111)
    long mask = (1L << length) - 1;
    
    // 2. Clean gene value from structures above 'length' (safety measure)
    long clean_gene = put_value & mask;
    
    // 3. Create a clear mask for original number (zeros at destination positions)
    long clear_mask = ~(mask << pos);
    
    // 4. Clear slot in original number and insert shifted gene using OR (|)
    return (old_value & clear_mask) | (clean_gene << pos);
}
/// @}

/// Function to flip a specific bit value (for use in mutations).
/// @param sou - input value to mutate.
/// @param pos - specifies position at which to flip the bit.
/// @param USE_BITS - bit count limit where mutation can occur.
/// @return number `sou` with flipped bit at `pos`.
/// @note OTHER BITS, INCLUDING THOSE ABOVE `USE_BITS`, REMAIN UNCHANGED.
/// @{

/// 32-bit version.  
public  int switch_bit(int sou,int pos,int USE_BITS)
{
  if(pos>=USE_BITS)
  {
    println(" Mutation outside BITMASK");
    return sou;
  }//else Position is valid.
  
  int bit=0x1<<pos; // Setting mask position.
  return sou^bit;   // Flipping bit according to mask (xor should do the job).
}


/// 64-bit version.  
public  long switch_bit(long sou,int pos,int USE_BITS)
{
  if(pos>=USE_BITS)
  {
    println(" Mutation outside BITMASK");
    return sou;
  }//else Position is valid.
  
  long bit=0x1<<pos; // Setting mask position.
  return sou^bit;    // Flipping bit according to mask (xor should do the job).
}
/// @}

/// @name Functions for performing crossover operations.
/// @details 
///   Operates simply under the simplifying assumption that the initial part always comes from the first parent, 
///   and starting from position "pos" bits come from the second parent. If you want the opposite effect...
///   Swap parent order in the function call!
/// @{
  
/// Crossover for 32-bit chromosomes.  
public static int cross_over(int parent1, int parent2, int pos) 
{                                                                assert(0<=pos && pos < 32);
    // 1. Create a mask for trailing (lower) bits from position `pos` to the right.
    // E.g., for pos = 4, mask is four ones: 000...0001111
    int mask = (1 << pos) - 1;

    // 2. ~mask preserves bits on the left side (higher) of the first parent.
    // 3. mask preserves bits on the right side (lower) of the second parent.
    return (parent1 & ~mask) | (parent2 & mask);
}

/// Crossover for 64-bit chromosomes.
public static long cross_over(long parent1, long parent2, int pos) 
{                                                                assert(0<=pos && pos < 64);
    // 1. Create 64-bit mask using 1L literal.
    long mask = (1L << pos) - 1;

    // 2. Combine left part of first parent with right part of second parent.
    return (parent1 & ~mask) | (parent2 & mask);
}
/// @}

/// Test function for the GA toolkit.
void tests()
{
  int testi=0x00FFAA11;
  long testl=0x1100AABBC0DDEEFFl; //0x8100000A000000EFl; //0x1001010110000000l; //0x1100AABBC0DDEEFFl;
  
  println("\nSigned 32-bit numbers:\n============================");
  println("NBC:",testi);
  println("24b:",toHex(testi,24),"\t",toBin(testi,24));
  println("32b:",toHex(testi,32),"\t",toBin(testi,32));
  int gri=toGray(testi);
  println("gri:",toHex(gri,32),"\t",toBin(gri,32));
  int ugr=fromGray(gri);
  println("ugr:",toHex(ugr,32),"\t",toBin(ugr,32));
  
  println("\nSigned 64-bit numbers:\n============================");
  println("NBC:",testl);
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
  
  println("\nUnsigned encoding of a number in the range 0..2^32:\n===============================================");
  long trzyMiliardy=3000000000l;
  int gray_coded_u=toGrayU32(trzyMiliardy);
  println(trzyMiliardy,"=?=",fromGrayU32(gray_coded_u));
  println(toBin(trzyMiliardy,32),"==>",toBin(gray_coded_u,32));
  println(toBin(fromGrayU32(gray_coded_u),32));
  
  println("\nMutation of Gray representation:\n===============================");
  int gray_coded_u1=switch_bit(gray_coded_u,0,32);
  println(trzyMiliardy," < ",fromGrayU32(gray_coded_u1));
  println("----------------------------------->",toBin(gray_coded_u1,32));
  
  int gray_coded_u2=switch_bit(gray_coded_u,30,32);
  println(trzyMiliardy," < ",fromGrayU32(gray_coded_u2));
  println("----------------------------------->",toBin(gray_coded_u2,32));
  
  println("Inserted:");
  long after_ins=put_bits(0L,16,32,gray_coded_u);
  println("------------------->",toBin(after_ins,64));
  
  println("\nCrossover:\n==============");
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
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - https://github.com/borkowsk/bookProcessingEN
//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//_EOC
