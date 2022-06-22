/// Drawing lines example

size(500,500);
//noSmooth(); //Without line smoothing ("anti-aliasing")

for(int i=0;i<200;i+=1) //REPEAT 100 times, but try also i+=2 or more
  line(i,50,i,450);
  
//https://github.com/borkowsk/bookProcessingEN
