/// Simple example of Agent Base Model.
/// @date 2025-01-04 (modification)
//*/////////////////////////////////////////////////////////////////////////////

void setup()
{
  size(1000,1020);
  
  theWorld=new World();
  theWorld.initialise();
  
  frameRate(100);
  println(Model,"Ready!");
}

void draw()
{
  background(128);
  
  visualise(theWorld);
  theWorld.update();
  
  text(str(frameCount)+"("+str(frameRate)+")",0,height);
}

void exit()
{
  println("The end");
  super.exit();
}
