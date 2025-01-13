/// Simple example of Agent Base Model.
/// @date 2025-01-13 (modification)
//*/////////////////////////////////////////////////////////////////////////////

void setup()
{
  size(1000,1020);
  
  theWorld=new World();
  theWorld.initialise();
  
  frameRate(DEFAULT_FRAME_RATE);
  println(Model,"Ready!");
}

void draw()
{
  background(128);
  
  census(theWorld);
  visualise(theWorld);
  theWorld.update();
  
  text(str(frameCount)+"("+str(frameRate)+")",3,height-3); // 3 pixels margins.
}

void exit()
{
  println("The end");
  super.exit();
}
