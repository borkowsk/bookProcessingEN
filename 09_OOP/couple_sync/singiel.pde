// Chaotic oscillator class - complex type
// An example of a class - user-defined type
////////////////////////////////////////////////

  class singiel 
  { // FIELDS / ATTRIBUTES:
    float r; 
    private float al;// "private" does not work in processing because of its relation to JAVA. 
    float x1,x2;
    
    //Constructor(s):
    // each class has at least one method called as 
    // the class name, has no return type and is used 
    // to create a class object - the instance
    singiel(float iX,float iR,float iAlpha)    
    {
      x1=x2=iX;r=iR;al=iAlpha;
    }
    
    // METHODS:
    float alpha()//R / O Access to the field 'al' 
    {            //under a different name. 
      return al; //The so-called accessory
    }
    
    void next() // Method to change state of object.
    {          
      x1=x2;
      x2=x1*r*(1-x1);//This is an iteration without a pair
    }
     
  };//Closing the class. May be ';' but it doesn't have to.


  // viewer - procedure external to the class
  void view(singiel S,float v,float h,float rad)   
  {  //Actually this is a visualization of the oscillator 
     //transition between states
     rad*=2;
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
  
//https://github.com/borkowsk/bookProcessingEN/
