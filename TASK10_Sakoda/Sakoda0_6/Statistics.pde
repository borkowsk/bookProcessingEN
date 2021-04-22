// Simulation have to collect and write down statistics from every step
///////////////////////////////////////////////////////////////////////////////////////

//Variable for statistics
float meanStress=0;
int   liveCount=0;

//The PrintWriter class is an intermediary between the program 
//and the text file on the disk
PrintWriter outstat;//Empty handler for PrintWriter class object

//This function does whatever needs to be done to write the statistics to disk
void initializeStats()
{
  //Uniq name for experiment!
  String FileName=modelName
                  +"_s"+side+"d"+density+"i"+Number_of_identities //All model parameters
                  +"_"+year()+'.'+nf(month(),2)+'.'+nf(day(),2) //date
                  +'.'+nf(hour(),2)+'.'+nf(minute(),2)+'.'+nf(second(),2)//time
                  +'.'+millis();//It will be unique even if we run two programs 
                                //almost simultaneously!
  println("Output in file:",FileName);
  
  outstat=createWriter(FileName+".out");//Creating PrintWriter object & his file on a disk
  
  outstat.println("STEP\tAlive\tStress\t...");//<-- Complete a line of header fields!
}

void saveStatistics()
{
  if(outstat==null) //So called "late" or "lazy" initialisation!
        initializeStats();//The "outstat" object is prepared on 
                          //the first attempt to save statistics
        
  outstat.println(TheWorld.getTimeStep()+"\t"
                  +liveCount+"\t"+meanStress+"\t...");//<-- Complete a line of fields!
                  
  //REMEMBER! outstat should be closed in exit() --> see Exit.pde                      
}

void statusLine()
{
  fill(255);noStroke();rect(0,side*cwidth,width/5,STATUSHEIGH);
  fill(0);
  textAlign(LEFT, TOP);text(liveCount+"  "+meanStress,0,side*cwidth);
  textAlign(LEFT, BOTTOM); text(TheWorld.getTimeStep()+")  Fps:"+ frameRate,
                        0,side*cwidth+STATUSHEIGH-2);
}

void doStatisticsOnAgents(Agent[][] agents)
{  
  Agent curra;//Auxiliary agent handle
  double summ=0;//Sum of stresses
  liveCount=0;//Number of agents
  
  for(int a=0;a<agents.length;a++)
   for(int b=0;b<agents[a].length;b++)
    if( (curra=agents[a][b]) != null )
    {
      summ+=curra.stress;//Sum of stresses
     
      //Other statistics
      //... //TODO
      
      liveCount++;//Number of agents
    }
     
   meanStress=(float)(summ/liveCount);
}

void doStatisticsOnAgents(Agent[] agents)
{  
  Agent curra;
  double summ=0;
  liveCount=0;
  
  for(int a=0;a<agents.length;a++)
    if( (curra=agents[a]) != null )
    {
      summ+=curra.stress;
     
      //Other statistics
      //...//TODO
      
      liveCount++;
    }
     
   meanStress=(float)(summ/liveCount);
}

///////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM EXAMPLE: 
//  1D & 2D BASIC STATISTICS
//  https://github.com/borkowsk/bookProcessingEN
///////////////////////////////////////////////////////////////////////////////////////////

