//Random tiles
size(500,500);
for(int i=0;i<10;i++)
{
   for(int j=0;j<10;j++)
   {
      fill( random(256),random(256),random(256));
      rect(i*50,j*50,50,50);
   }
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/05_random
