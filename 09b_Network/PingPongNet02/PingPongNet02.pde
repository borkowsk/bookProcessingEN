// Network of activations
//-//////////////////////

class Node {
  boolean is_active=false; //State of node, initialisation in definition place
  boolean will_be_a=false; //Future state of the node. Internal use only.
  int visX,visY; //Spatial position of the node. For visualisation only!
}

final int   NUMBER_OF_NODES=20;   //We need some nodes
final float CONNECTION_PROB=0.33; //And we have to choose which of them are connected.

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

void initConnections(){}

void viewConnections()
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

void viewNodes(){}

void changeStates(){}

/// @date 2025-11-13 (https://github.com/borkowsk/bookProcessingEN)
