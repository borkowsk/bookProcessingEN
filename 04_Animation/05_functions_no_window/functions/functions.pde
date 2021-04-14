int funkcja_zwraca_int()
{
  return 1;
}

float funkcja_zwraca_float()
{
  return 1.01;
}

int funkcja_dostaje_int_i_zwraca_int(int x)
{
  return x*x;
}

float funkcja_dostaje_int_i_zwraca_float(int x)
{
  return sqrt(x);//Pierwiastek kwadratowy z liczby całkowitej
}

float funkcja_dostaje_float_i_zwraca_float(float x)
{
  return sqrt(x);//Pierwiastek kwadratowy z liczby zmiennoprzecinkowej
}

float funkcja_dostaje_Float_i_zwraca_float(Float x)
{
  return sqrt(x);//Pierwiastek kwadratowy z liczby zmiennoprzecinkowej
}

void setup()
{
  noLoop();
  println(  funkcja_zwraca_int() );
  println(  funkcja_zwraca_float() );
  println(  funkcja_dostaje_int_i_zwraca_int(2) );
  println(  funkcja_dostaje_int_i_zwraca_float(2) );
  println(  funkcja_dostaje_float_i_zwraca_float(2) );
  Float X=new Float("3.5");
  println(  X );
  println(  funkcja_dostaje_Float_i_zwraca_float(X) );
}

void draw() //Console only applet!
{
  surface.setVisible(false);
  exit();
}

void exit()
{
  println("Dziękuję!");
  super.exit();
}
