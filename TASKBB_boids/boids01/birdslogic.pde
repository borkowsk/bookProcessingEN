/// decisions and actions of birds
void decisions()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     thinkAndDo0(current);
   }
}

/// simple target orientation
void thinkAndDo0(Bird me)
{
  float dx=me.tx-me.x;
  float dy=me.ty-me.y;
  float dz=me.tz-me.z;
  
  //Has the goal been achieved?
  if(dx==0 && dy==0 && dz==0)
  {
    println("Caught! Go up!");
    me.vx=0;
    me.vy=0;
    me.vx=0;
    me.tz=1000; //Target now unattainable height //<>//
  }
  else //Zeno's of Elea like target aproaching ;-)
  {
    me.vx=dx*0.01;
    me.vy=dy*0.01;
    me.vz=dz*0.01;
  }
}
