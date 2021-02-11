//"line" animation with setup()

void setup() 
{
  frameRate(30);
  size(300,100);
  strokeWeight(2);//Bold lines!
}

int pos = 0;

void draw() 
{
  background(204);
  line(pos, 20, pos, 80);
  pos++;
}
