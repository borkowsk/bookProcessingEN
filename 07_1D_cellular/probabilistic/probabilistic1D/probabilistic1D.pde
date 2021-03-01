//One-dimensional, probabilistic, non-interactive cellular automaton - skeleton in the "non-functional" form
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

size(500,1000);    //The window is more vertical than horizontal 

int[] World=new int[width];//Creating an array - in Processing always using allocations 

//for(int i=0;i<World.length;i++) //Reset an array - if needed. The printout of the table will show if it is there
//    World[i]=0;

World[World.length/2]=1; //Seed

println("table:");
for(int i=0;i<World.length;i++) //Writing an array to the console
    print(World[i],' ');
    
for(int t=0;t<height;t++)//As many generations as there are canvas lines
{
  for(int i=0;i<World.length;i++)//Visualization or "drawing on the screen" 
  {
    if(World[i]>0) stroke(255);
    else           stroke(0);
    point(i,t);
  }
  
  for(int i=0;i<World.length;i++)// Change the state of the automaton
  {
      if(World[i]>0 && random(1.0)<0.005) // If the cell is alive it may die
        World[i]=0;
        
      if(World[i]==0 && random(1.0)<0.001)// If the cell is dead, it might come to life
        World[i]=1;
  }
}

println("table:");// Print an Array To Console Again!
for(int i=0;i<World.length;i++) 
    print(World[i],' ');
    
