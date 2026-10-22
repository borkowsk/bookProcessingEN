void exit()          //This function is always called after the window is closed. 
{
  noLoop();          //For to be sure...
  delay(100);        // Unfortunately, it is possible for the window to be closed while draw() is running.
  //write(world,modelName+"."+nf((float)StepCounter,5,5)); //end state of the system
  
  //if(outstat!=null)
  //{
  //  outstat.flush();  // Saves the remaining data to a file
  //  outstat.close();  // Finishes writing and closes the file
  //}
  
  if(WITH_VIDEO) CloseVideo();
  
  println(modelName,"said: Thank You!");
  super.exit();       //Co superklasa z biblioteki musi zrobić przy wyjściu.()
} 

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - EXIT TEMPLATE
//-/////////////////////////////////////////////////////////////////////////////////////////
