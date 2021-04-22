// Processing has its own specific application structure which makes it a bit difficult 
// to create sequence programs, which usually are graphical demos. 
// But there is a way around this ...
////////////////////////////////////////////////////////////////////////////////////////

int W;
void setup()//Initialisation
{
  size(600,600);
  W=width;
}

int radius(int D) //A function that draws a fraction from the size of the window
{
  return int( random(W/D) );//float to int conversion
}

void draw1()
{
  fill(random(255),random(255),random(255),random(255));//RGB+opacity
  stroke(random(255),random(255),random(255),random(255));//RGB+opacity
  float r=radius(10);
  ellipse(random(W),random(W),r,r);
}

void draw2()
{
  fill(random(255),random(255),random(255),random(255));//RGB+opacity
  float s=radius(10);
  rect(random(W-s),random(W-s),s,s);
}

int i=0;
float R=0;
void draw3()
{
  if(R==0) //Only the first time
  {
      R=10+radius(2);
      noStroke();
  }
  fill(0,i%256,0,25);//GREEN + opacity
  arc(W/2,W/2, R, R, radians(i-10),radians(i));
  i+=10;
  R+=0.1;
}

int frame=0;
void draw() 
{
  if(frame<500)
    draw1();
  else if(frame<999)
    draw2();
  else draw3(); 
  
  frame++;
}

//https://github.com/borkowsk/bookProcessingEN

