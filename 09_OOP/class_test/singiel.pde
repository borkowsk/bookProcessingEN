/// Chaotic oscillator class.
/// An example of a class - user-defined type.
//-//////////////////////////////////////////////

class singiel 
{ // FIELDS / ATTRIBUTES:
  float  r;    //!< Control parameter.
  float al;    //!< Coupling parameter
  float x1,x2=0; //!< Current and previous states
  
  final float max_r=4.0;
  
  // Constructor(s):
  //-///////////////
  // each class has at least one method called as 
  // the class name, has no return type and is used 
  // to create a class object - the "instance".
  
  
  singiel(float iX,float iR,float iAlpha)    
  {
    float tmp; //TEST
    x1=x2=iX;r=iR;al=iAlpha;
  }
  
  // METHODS:
  //-////////
  
  float alpha() //!< R / O Access to the field 'al' 
  {             //!< under a different name. 
    String tmp; //TEST
    return al;  //!< The so-called accessory
  }
  
  
  void next()  //!<  Method to change state of object.
  {          
    x1=x2;
    x2=x1*r*(1-x1); //This is an iteration without a pair
  }
   
}; //Closing the class. In JAVA syntax may be ';' but it doesn't have to.


// viewer - procedure external to the class because 
// it can be in various variants, created as needed.
void view(singiel S,float v,float h,float rad)   
{
  ellipseMode(RADIUS); 
  ellipse(v,h,round(S.x1*rad),round(S.x2*rad));
}

// Pair iteration routine
// Declared outside the class for symmetry reasons
void next4couple(singiel F,singiel S) 
{
  // The interaction of the oscillators
  F.x2=F.x2*(1-F.al)+S.x2*F.al;
  S.x2=S.x2*(1-S.al)+F.x2*S.al;
  
  // Real state change
  F.next();
  S.next();
}

int tmp=0; //test!

// https://github.com/borkowsk/bookProcessingEN/
/// @date 2024-12-10 (revived)
