//4 bars example. SIMPLIFIED
//DATA. Values can be changed at will
float d0=300,d1=499,d2=150,d3=75;

size(600,500);

//Bars
rect(100,500-d0,100,d0);
rect(200,500-d1,100,d1);
rect(300,500-d2,100,d2);
rect(400,500-d3,100,d3);

//coordinate system
stroke(128);
line(0,0,0,499);//Vertical
line(0,0,5,10);//Arrow

line(0,499,599,499);//Horizontal
