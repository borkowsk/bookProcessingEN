// Chaotic oscillator class - complex type
// An example of a class - user-defined type
//-//////////////////////////////////////////////

//The second partner adapts to the state already changed 
//in the first one, or they operate in strict parallel.
boolean _GottmanMode4double=true;
  
class singiel_double
{ // FIELDS / ATTRIBUTES:
  double r; 
  double al;
  double x1,x2;
  
  //Constructor(s):
  // each class has at least one method called as 
  // the class name, has no return type and is used 
  // to create a class object - the instance
  
  singiel_double() //parameterless constructor
  {
    x1=x2=0.5;r=3;al=0;
  }
  
  singiel_double(double iX,double iR) //Alpha-less constructor
  {
    x1=x2=iX;r=iR;al=0;
  }
  
  singiel_double(double iX,double iR,double iAlpha) //other constructor    
  {
    x1=x2=iX;r=iR;al=iAlpha;
  }
  
  // METHODS:
  float alpha() //R/O Access to the field 'al' ("getter")
  {             //under a different name. 
    return (float)(al); //The so-called accessory
  }
  
  float xPre() //R/O Access to the field 'x1' ("getter")
  {
    return (float)(x1);
  }
  
  float xCur() //R/O Access to the field 'x1' ("getter")
  {
    return (float)(x2);
  }
  
  float rCur()  //R/O Access to the field 'x1' ("getter")
  {
    return (float)(r);
  }
  
  // Methods to change state of object
  
  void set_alpha(double iAl) // "setter" for 'al'
  {
    if(0<=iAl && iAl<=1)
      al=iAl;
    else 
      println("Invalid 'alpha' value:",iAl);
  }
  
  void set_x(double iX) // "setter" for x1 & x2
  {
    if(0<=iX && iX<=1)
      x1=x2=iX;
    else 
      println("Invalid state value:",iX);
  }
  
  void next() //Next iteration of this logistic equation
  {          
    x1=x2;
    x2=x1*r*(1-x1); //This is an iteration without a pair
  }
   
}; //Closing the class. 


// viewer - procedure external to the class 
void view(singiel_double S,float v,float h,float baseLength)   
{
  ellipse(v,h,round(S.xPre()*baseLength),round(S.xCur()*baseLength));
}

// Pair iteration routine
// Declared outside the class for symmetry reasons
void next4couple(singiel_double F,singiel_double S) 
{
  // The interaction of the oscillators
  if(_GottmanMode4double)
  {
    F.x2=F.x2*(1-F.al)+S.x2*F.al; //He adopts first
    S.x2=S.x2*(1-S.al)+F.x2*S.al;
  }
  else
  {
    double Xold=F.x2;
    F.x2=F.x2*(1-F.al)+S.x2*F.al;
    S.x2=S.x2*(1-S.al)+Xold*S.al;
  }
  
  // New states of partners
  F.next();
  S.next();
}

/// @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
