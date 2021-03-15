//Inny przykład użycia tej samej klasy
//zdefiniowaliśmy klasę, teraz jej użyjemy, wspólczynnik spięcia, synchronizacji
/////////////////////////////////////////////////////////////////////////////////////////

final  float DefaultAlpha=0.1;//dwa systemy od siebie niezależne, wpływając na alfa możemy zwiekszac ich wzajmna synchronizacje
final  int   Rozbieg=100;

singiel First, Second;// uchwyty do obiektow, to ze je zadeklarujemy nie oznacza ze istnieja. 
                      // obiekty powstana dalej, wiec uchwyt złapie to co tam powstanie

void setup()
{
   size(1200,400);
   frameRate(300);
  
   // First=new singiel() // tworzymy nowy obiekt, bedzie typu singiel, używamy konstruktor singiel
   First= new singiel(random(1.0), 3.5+random(0.5), DefaultAlpha);// 3,5 do 4 bo synchronnizacje w chaosie jest najciekawsza
   Second=new singiel(random(1.0), 3.5+random(0.5), DefaultAlpha);
   
   println("1st:",First.x1+" "+First.r+" alfa:"+First.alpha());//uchwyt do biektu, robi za nazwe obiektu, ...
   println("2st:",Second.x1+" "+Second.r+" alfa:"+Second.alpha());//kropka i nazwa pola wiec czytamy nazew pola lub mozna z funkcja
}


//Dla wizualizacji
int N=0;//licznik kroków

int Ws=400;//Współczynnik skali

float scaleY(double X) //Funkcja skalująca
{
  return Ws-(float)X*Ws;
}

float Gre=255;
float Blu=255;
float Red=255;

void draw()
{
  First.next();
  Second.next();   //println("1st:",First.x1,"\t2nd:",Second.x1);
  
  if(N<2*Ws)
  {
    stroke(Red,0,0,25);
    line(N-1,scaleY(First.x1),N,scaleY(First.x2));//musimy napisac z ktorego obiektu bierzemy x1,x2
    
    stroke(0,0,Blu,25);
    line(N-1,scaleY(Second.x1),N,scaleY(Second.x2));
    
    stroke(0,Gre,0);
    point(N,scaleY(abs(First.x2-Second.x2)));
    //point(2*Ws+First.x2*Ws,scaleY(Second.x2));
    
    if(N>Rozbieg)//to wyrzucić to będzie widać doście do atraktora
    {
       ellipse(2*Ws+First.x2*Ws,scaleY(Second.x2),4.0,4.0);       
    }
    
    N++; // tu kończymy wyrzucanie
  }
  else
  {
    N=0;//Zaczynamy od poczatku z innymi wartościami poczatkowymi
    println("realFM:",frameRate,"\tX=",First.x1,Second.x2);
    First.x2=random(1.0);
    Second.x2=random(1.0);
    Gre=random(255);Blu=random(255);Red=random(255);
  }

}
