void draw() //Jest wykonywane w niewidocznej, nieskończonej pętli
{
  point(random(width),random(height));
}

void setup() //Ustalamy rozmiar okna, kolor jego tła i kolor punktów
{
  size(500,200);
  background(0,0,128);
  stroke(255,255,0);
}