// Demonstration of functions with different parameters
//*///////////////////////////////////////////////////////

int function_returning_int()
{
  return 1;
}

float function_returning_float()
{
  return 1.01;
}

int function_receiving_int_returning_int(int x)
{
  return x*x;
}

float function_receiving_int_returning_float(int x)
{
  return sqrt(x); // Square root of an integer
}

float function_receiving_float_returning_float(float x)
{
  return sqrt(x); // Square root of a floating point number
}

float function_receiving_Float_object_returning_float(Float x)
{
  return sqrt(x); // Square root of a floating point number
}

void setup()
{
  noLoop();
  println(  function_returning_int() );
  println(  function_returning_float() );
  println(  function_receiving_int_returning_int(2) );
  println(  function_receiving_float_returning_float(2) );
  println(  function_receiving_float_returning_float(2) );
  Float X=new Float("3.5");
  println(  X );
  println(  function_receiving_Float_object_returning_float(X) );
}

void draw() //Console only applet!
{
  surface.setVisible(false);
  exit();
}

void exit()
{
  println("Thank You!");
  super.exit();
}

// https://github.com/borkowsk/bookProcessingEN
