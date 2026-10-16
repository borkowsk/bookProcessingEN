// EXIT TEMPLATE

void exit()          //it is called whenever a window is closed. Maybe asynchronicaly!
{
  noLoop();          //For to be sure...
  delay(100);        // it is possible to close window when draw() is still working!
  println(modelName+" exited in step: "+TheWorld.getTimeStep()); //end state of the system
  
  if(outstat!=null)
  {
    outstat.flush(); // Writes the remaining data to the stat file
    outstat.close(); // Finishes the stat file
  }
    
  println(modelName,"said: Thank You!");
  super.exit();      //What library superclass have to do at exit() !!!
} 

//*/////////////////////////////////////////////////////////////////////////////////////////
// https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - EXIT TEMPLATE
// https://github.com/borkowsk/bookProcessingEN
//*/////////////////////////////////////////////////////////////////////////////////////////
