/// decisions and actions of birds
void decisions()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     if(current.isTargeted())
         thinkAndDoTarget(current);
     else
         thinkAndDoBoids(current,i);
   }
}

int signum(float v)
{
  if(v<0) return -1;
  else if(v>0) return 1;
  else return 0;
}

/// simple target orientation
void thinkAndDoTarget(Bird me)
{
  float dx=me.tx-me.x;
  float dy=me.ty-me.y;
  float dz=me.tz-me.z;
  
  //Has the goal been achieved?
  if(sqrt(dx*dx+dy*dy+dz*dz)<=1.0)
  {
    println("Caught! Go up!");
    me.vx=0;
    me.vy=0;
    me.vx=0;
    me.tz=1000; //Target now unattainable height
  }
  else //NO! Continue to approach!
  {
    me.vx=dx*0.01; if(abs(me.vx)<1) me.vx=signum(dx);
    me.vy=dy*0.01; if(abs(me.vy)<1) me.vy=signum(dy);
    me.vz=dz*0.01; if(abs(me.vz)<0.1) me.vz=signum(dz)*0.1;
    println(me.vx,me.vy,me.vz);
  }
}

/// Implementation of the boids algorithm.
/// See: https://people.ece.cornell.edu/land/courses/ece4760/labs/s2021/Boids/Boids.html
void thinkAndDoBoids(Bird me,int myIndex)
{
  
}


/// @date 2025-12-10 (modified)