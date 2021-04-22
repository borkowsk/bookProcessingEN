//4 bars example. Without FOR!!!
//DATA. Values can be changed at will
//"final" means something like "constant"

final float d0=200,d1=180,d2=50,d3=25;

//auxiliary variables
final float maxd=max(d0,d1,max(d2,d3));// max() accept only 2 or 3 parameters
float curr=0;

size(600,500);//the size can be almost any
println(maxd,"in",width,"x",height,"window");//print to console!

//Bars
stroke(255);fill(0);
curr=d0/maxd*height;
rect(width/6,height-curr,width/6,curr-2);
curr=d1/maxd*height;
rect(width/6*2,height-curr,width/6,curr-2);
curr=d2/maxd*height;
rect(width/6*3,height-curr,width/6,curr-2);
curr=d3/maxd*height;
rect(width/6*4,height-curr,width/6,curr-2);

//coordinate system
stroke(128);
line(0,0,0,height-1);//Vertical
line(0,0,5,10);//Arrow
textAlign(LEFT,TOP);text(maxd,0,0);//Print max on window!

line(0,height-1,width,height-1);//Horizontal
//line(width,height-1,width-10,height-5);//Arrow

//https://github.com/borkowsk/bookProcessingEN

