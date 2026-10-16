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

void initNodes(){}
void initConnections(){}
void viewConnections(){}
void viewNodes(){}
void changeStates(){}

/// @date 2025-11-24 (https://github.com/borkowsk/bookProcessingEN)
