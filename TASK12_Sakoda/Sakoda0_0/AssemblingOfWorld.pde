/// World is a one of two central class of each ABM model
//*/////////////////////////////////////////////////////////////

class World //implements simulation_world interface later...
{
  int StepCounter=0; //If we had more worlds, each one must have their own timer!

  //type v.name [][]<- marks of 2D array   
  Agent[][] agents; //Two-dimensional array of agents
  //But it could be one-dimensional,
  //Or even hexagonal!

  World(int side) //Constructor of the World
  {
    agents=new Agent[side][side]; //We guarantee the creation 
    //of an array. Empty for now!
  }

  void initializeModel() //Method 1
  {
    for (int a=0; a<agents.length; a++) //for every row
      for (int b=0; b<agents[a].length; b++) //for every column
        if (random(1.0)<density) // Only some of the cells are occupied
        {
          Agent curr=new Agent(); // We construct the agent
          agents[a][b]=curr; // ... and put it in the array
        }
  }

  void changeState() //Method 2
  {
    int MCN=agents.length*agents[0].length; //number of M C draws
    for (int i=0; i<MCN; i++)
    {
      int a=(int)random(0, agents.length); //row
      int b=(int)random(0, agents[a].length); //column

      if ( agents[a][b] != null )
      {
        //Check the stress on the agent
        int strangers=0; //Number of foreign neighbors in von Neumann's neib.

        if ( 0 <= a-1 //when not reaching beyond the array
          && agents[a-1][b]!=null //...and there is an agent in the cell
          && agents[a-1][b].identity!=agents[a][b].identity) //...and is different
          strangers++; //Remember the behavior of the operator &&!

        if (a+1 < agents.length 
          && agents[a+1][b]!=null 
          && agents[a+1][b].identity!=agents[a][b].identity)
          strangers++;  

        if (0 <= b-1 
          && agents[a][b-1]!=null 
          && agents[a][b-1].identity!=agents[a][b].identity)
          strangers++;

        if (b+1 < agents.length 
          && agents[a][b+1]!=null 
          && agents[a][b+1].identity!=agents[a][b].identity)
          strangers++;  

        agents[a][b].stress=strangers/4.0; //von Neumann neib.  

        //Attempting to migrate when the agent is under stress
        if ( agents[a][b].stress > 0  //Scheling model
          && random(1.0)<agents[a][b].stress //"Not always" modification
          )
        {
          int tara=(int)random(0, agents.length);
          int tarb=(int)random(0, agents[a].length);

          if (agents[tara][tarb]==null) //There is an empty place
          {
            agents[tara][tarb]=agents[a][b]; //Moving to a new apartment
            agents[a][b]=null; //Check out from the old place
          }
        }
      }
    }
  }

  void makeStatistics()
  {
    //... later on
  }

  void modelStep() //Method 3 using method 2 
  {
    //this.
    changeState(); //'this' is redundant here. For example only.

    //Other every step actions
    makeStatistics(); //here without 'this'

    StepCounter++;
  }
};

//More alaborated functionalities may be defined as stand-alone functions
///////////////////////////////////////////////////////////////////////////

void visualizeModel(World world)
{
  Agent curr; //tmp handle
  for (int a=0; a<world.agents.length; a++)
    for (int b=0; b<world.agents[a].length; b++)
    {
      //Cell background. If there was no agent present here,
      noStroke();
      fill(200); //the only background will remain
      rect(b*cwidth, a*cwidth, cwidth, cwidth); //Remember, 'a' is vertical!

      //Drawing the agent only when it is in this array cell
      if ( (curr=world.agents[a][b]) != null ) //null means "empty handle"
      {
        if (curr.stress>0) // Stress as the outline color
          stroke(curr.stress*255, 0, curr.stress*255);
        else
          noStroke();

        // Filling The Circle Depends On 'Identity'   
        float forFill=(curr.identity*255.0)/Number_of_identities;
        fill(forFill, forFill, 0);
        rect(b*cwidth, a*cwidth, cwidth-2, cwidth-2); //strokeWeight == 2 !
      }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
//  https://github.com/borkowsk/bookProcessingEN
///////////////////////////////////////////////////////////////////////////////////////////////
