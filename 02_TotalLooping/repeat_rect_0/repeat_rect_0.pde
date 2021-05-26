//30 white paper sheets

size(500,500);
smooth();//Line smoothing ("anti-aliasing")

for(int i=0;i<300;i+=10)//REPEAT 30 TIMES EVERY TEN!
  rect(i-500,i,500,500); //Drawing a sheet of paper

//https://github.com/borkowsk/bookProcessingEN
