// A "for" loop with the + = operation drawing every other line

size(500,500);
smooth();//With line smoothing ("anti-aliasing")

for(int i=0;i<200;i+=2) //REPEAT EVERY SECOND! (100 times)
  line(i,i,0,500);
  
//https://github.com/borkowsk/bookProcessingEN
