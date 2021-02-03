//Praca domowa - wg ograzka

size(500,500);
smooth();//Z wygładzaniem lini ("antyaliasingiem")
rectMode(CORNERS);  // Set rectMode to CORNERS
for(int i=0;i<=300;i+=10) //POWTARZAJ CO DZIESIĄTY!
{
  fill(i,0,i);
  rect(i,i,0,500); //I rysuj "kartkę"
}

for(int i=300;i>=0;i-=10) //POWTARZAJ CO DZIESIĄTY!
{
  fill(0,i,i);
  ellipse(355,150,i,i);//I rysuj "dysk"
  ellipse(i,i,10,10); // oraz  "ogonki"
}

//https://www.facebook.com/ProcessingWEdukacji/
//http://processingwedukacji.blogspot.com
