// Losowe linie wzdłuż osi Y

size(200,300);

for(int i=0;i<300;i++)
{
  float a=random(200); //Liczba z zakresu 0..200
  line(0,i,a,i);
}

// https://github.com/borkowsk/bookProcessingEN
