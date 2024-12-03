/// Chaotic oscillator class.
/// An example of a class - user-defined type.
//-//////////////////////////////////////////////

class singiel  //@CLASS singiel
{ // FIELDS / ATTRIBUTES: //@BEGIN
  
// static and final object members are not supported !!!
  final float max_r=4.0;
  
  // Constructor(s):
  //-///////////////
  // each class has at least one method called as 
  // the class name, has no return type and is used 
  // to create a class object - the "instance".
  
  
  singiel(float iX,float iR,float iAlpha)    //@CONSTRUCTOR:1
  { //@BEGIN
    float tmp; //TEST//@VAR DECLARATION
    x1=x2=iX;r=iR;al=iAlpha;
  } //@END_OF_FUNCTION
  
  // METHODS:
  //-////////
  
  float alpha() //!< R / O Access to the field 'al' //@METHOD DECLARATION
  {             //!< under a different name.  //@BEGIN
    String tmp; //TEST//@VAR DECLARATION
    return al;  //!< The so-called accessory
  } //@END_OF_FUNCTION
  
  
  void next()  //!<  Method to change state of object.//@METHOD DECLARATION
  {           //@BEGIN
    x1=x2;
    x2=x1*r*(1-x1); //This is an iteration without a pair
  } //@END_OF_FUNCTION
   
  //@FIELD_INITIALISATIONS
  float r =0.0; //!< Control parameter.     //@FIELD DECLARATION 
  float al =0.0; //!< Coupling parameter     //@FIELD DECLARATION 
  float x2 =0; //!< Current and previous states   //@FIELD DECLARATION 
  float x1 =0.0; //!< Current and previous states   //@FIELD DECLARATION 
  // fc:4
}; //Closing the class. In JAVA syntax may be ';' but it doesn't have to. //@END_OF_CLASS


// viewer - procedure external to the class because 
// it can be in various variants, created as needed.
void view(singiel S,float v,float h,float rad)   //@FUNCTION DECLARATION
{ //@BEGIN
   ellipseMode(RADIUS); 
   ellipse(v,h,round(S.x1*rad),round(S.x2*rad));
} //@END_OF_FUNCTION

// Pair iteration routine
// Declared outside the class for symmetry reasons
void next4couple(singiel F,singiel S) //@FUNCTION DECLARATION
{ //@BEGIN
  // The interaction of the oscillators
  F.x2=F.x2*(1-F.al)+S.x2*F.al;
  S.x2=S.x2*(1-S.al)+F.x2*S.al;
  
  // Real state change
  F.next();
  S.next();
} //@END_OF_FUNCTION

int tmp=0; //test!//@VAR DECLARATION

// https://github.com/borkowsk/bookProcessingEN/
/// @date 2024-12-03 (revived)

// Finally, level is 0,infunction is 0, inclass is 0 (global)
