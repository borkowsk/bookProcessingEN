// Przykład klasy
////////////////////////////////////////////////

  class singiel //Klasa oscylatora chaotycznego - typ złożony
  { //POLA/ATRYBUTY:
    float r; //Parametr kontroli
    float al;//Parametr sprzężenia
    float x1,x2;//Stan aktualny i poprzedni
    
    //Konstruktor
    singiel(float iX,float iR,float iAlpha)
    //każda klasa ma choć jedną metodę, ktora nazywa sie jak nazwa klasy
    {
      x1=x2=iX;r=iR;al=iAlpha;
    }
    
    //METODY:
    float alpha()//R/O dostęp do pola pod inną nazwą
    {
      return al;
    }
    
    void next() //Metoda zmieniająca stan. Tu iteracja bez pary
    {
      x1=x2;
      x2=x1*r*(1-x1);
    }
     
  };

  void view(singiel S,float v,float h,float rad) //viewer - zewnętrzny w stosunku do klasy  
  {
     ellipseMode(RADIUS); 
     ellipse(v,h,round(S.x1*rad),round(S.x2*rad));
  }

  void next4couple(singiel F,singiel S) //Iteracja w parze
  {
    //Interakcja
    F.x2=F.x2*(1-F.al)+S.x2*F.al;
    S.x2=S.x2*(1-S.al)+F.x2*S.al;
    
    //Zmiana stanu
    F.next();
    S.next();
  }
  
