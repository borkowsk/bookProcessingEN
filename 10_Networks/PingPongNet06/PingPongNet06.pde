// Network of activations with refractions
//-///////////////////////////////////////

final int RESTS=-1; //Cannot be activated
final int READY=0;  //Susceptible to activation
final int ACTIVE=1; //Active state of node

class Node {
  int     active_state=0;    //State of node, initialisation in definition place
  boolean will_be_act=false; //Future state of the node. Internal use only.
  int visX,visY; //Spatial position of the node. For visualisation only!
}

final int   NUMBER_OF_NODES=50;  //We need some nodes
final float CONNECTION_PROB=0.03; //0.033; //And we have to choose which of them are connected.

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
  //viewConnections();
  viewNodes();
}

void initNodes() //Arrangement of nodes on a circle 
{
  float R=min(width,height)/2.0*0.9; println("R:",R);
  for(int i=0;i<NUMBER_OF_NODES;i++)
  {
    nodes[i]=new Node(); //State was set during construction.
    float angle=float(i)/NUMBER_OF_NODES*TWO_PI;
    nodes[i].visX=int(width/2.0+sin(angle)*R);
    nodes[i].visY=int(height/2.0+cos(angle)*R);  println(degrees(angle),'\t',angle,'\t',nodes[i].visX,nodes[i].visY);
  }
  
  int a=(int)random(NUMBER_OF_NODES); //Which node will be activated?
  nodes[a].active_state=ACTIVE;
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
    switch(nodes[i].active_state) {
    case RESTS:  fill(0,255,255); break; //resting nodes are cyan
    case ACTIVE: fill(255,255,0); break; //active nodes are yellow
    default:
      fill(0); break; //otherwise node are black
    }  
    circle(nodes[i].visX,nodes[i].visY,D);  
  }
}

void changeStates()
{
  // First we calculate new activations into internal fields.
  for(int i=0;i<NUMBER_OF_NODES;i++)
    if(nodes[i].active_state==ACTIVE)
    {
      for(int j=0;j<NUMBER_OF_NODES;j++)
      if(connections[i][j]>0)
         nodes[j].will_be_act=true; //Transfer acctivation
    }
  
  // Then we change states of nodes, and clear internal fields.
  boolean flag=false;
  for(int i=0;i<NUMBER_OF_NODES;i++)
  {
    switch(nodes[i].active_state) {
    case RESTS:  nodes[i].active_state=READY; break;
    case ACTIVE: nodes[i].active_state=RESTS; break;
    case READY: if(nodes[i].will_be_act) { nodes[i].active_state=ACTIVE; flag=true; } break;
    default:
      println("INVALID STATE!",nodes[i].active_state); break;
    }
     
    nodes[i].will_be_act=false;
  }
  
  if(flag) println("Activation is continued in frame",frameCount);

}

/// @date 2025-11-24 (https://github.com/borkowsk/bookProcessingEN)
