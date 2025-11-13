// Network of activations
//-//////////////////////

class Node {
  boolean is_active=false; //State of node, initialisation in definition place
  boolean will_be_act=false; //Future state of the node. Internal use only.
  int visX,visY; //Spatial position of the node. For visualisation only!
}

final int   NUMBER_OF_NODES=20;   //We need some nodes
final float CONNECTION_PROB=0.13; //And we have to choose which of them are connected.

Node[]  nodes=new Node[NUMBER_OF_NODES];
int[][] connections=new int[NUMBER_OF_NODES][NUMBER_OF_NODES];

void setup()
{
  size(500,500);
  frameRate(5);
  initNodes();
  initConnections();
  viewConnections();
  viewNodes();
}

void draw()
{
  changeStates();
  viewConnections();
  viewNodes();
}

void initNodes()
{
  for(int i=0;i<NUMBER_OF_NODES;i++)
  {
    nodes[i]=new Node(); //State was set during construction. 
    nodes[i].visX=(int)random(width);
    nodes[i].visY=(int)random(height);
  }
  
  int a=(int)random(NUMBER_OF_NODES); //Which node will be activated?
  nodes[a].is_active=true;
}

void initConnections()
{
  for(int a=0;a<NUMBER_OF_NODES;a++)
  {
    for(int b=a+1;b<NUMBER_OF_NODES;b++)
    {
      int connected=(random(1.0)<CONNECTION_PROB?1:0); //are a and b connected or not.
      connections[a][b]=connected;
      print(connected,' ');
      connections[b][a]=connected; //The shadow of connection (because they are symmetric)
    }
    println();
  }
}

void viewConnections()
{
  for(int a=0;a<NUMBER_OF_NODES;a++)
  {
    for(int b=a+1;b<NUMBER_OF_NODES;b++)
    {
      int connected=connections[a][b]; //are a and b connected or not.
      if(connected>0)
        line(nodes[a].visX,nodes[a].visY,nodes[b].visX,nodes[b].visY);
    }
  }
}

void viewNodes()
{
  float D=min(width,height)/30; //Visual diameter of node
  
  for(int i=0;i<NUMBER_OF_NODES;i++)
  {
    if(nodes[i].is_active)
      fill(255,255,0); //Active nodes are yellow
    else
      fill(0); //otherwise node are black
      
    circle(nodes[i].visX,nodes[i].visY,D);  
  }
}

void changeStates()
{
  // First we calculate new activations into internal fields.
  for(int i=0;i<NUMBER_OF_NODES;i++)
    if(nodes[i].is_active)
    {
      for(int j=0;j<NUMBER_OF_NODES;j++)
      if(connections[i][j]>0)
         nodes[j].will_be_act=true; //Transfer acctivation
    }
  
  // Then we change states of nodes, and clear internal fields.
  for(int i=0;i<NUMBER_OF_NODES;i++)
  {
    nodes[i].is_active=nodes[i].will_be_act;
    nodes[i].will_be_act=false;
  }
  

}

/// @date 2025-11-13 (https://github.com/borkowsk/bookProcessingEN)
