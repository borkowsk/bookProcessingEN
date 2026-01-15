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
void thinkAndDoBoids(Bird boid,int myIndex)
{
  // For every "boid" - is "upstairs" . . .  //for each boid (boid):
  
      // Zero all accumulator variables
      float xpos_avg, ypos_avg, xvel_avg, yvel_avg, neighboring_boids, close_dx, close_dy;
      xpos_avg=ypos_avg=xvel_avg=yvel_avg=neighboring_boids=close_dx=close_dy = 0.0;
  
      // For every other boid in the flock . . .
      //for each other boid (otherboid):
      for(int i=0;i<HM_BIRDS;i++)
      if(i!=myIndex)
      {
          Bird otherboid=birds.get(i);
          
          // Compute differences in x and y coordinates
          float dx = boid.x - otherboid.x;
          float dy = boid.y - otherboid.y;
  
          // Are both those differences less than the visual range?
          if (abs(dx)<visualRange && abs(dy)<visualRange)
          {
              // If so, calculate the squared distance
              float squared_distance = dx*dx + dy*dy;
  
              // Is squared distance less than the protected range?
              if (squared_distance < protectedRangeSquared)
              {
                  // If so, calculate difference in x/y-coordinates to nearfield boid
                  close_dx += boid.x - otherboid.x;
                  close_dy += boid.y - otherboid.y;
              }
              // If not in protected range, is the boid in the visual range?
              else if (squared_distance < visual_range_squared)
                   {
                      // Add other boid's x/y-coord and x/y vel to accumulator variables
                      xpos_avg += otherboid.x;
                      ypos_avg += otherboid.y;
                      xvel_avg += otherboid.vx;
                      yvel_avg += otherboid.vy;
      
                      // Increment number of boids within visual range
                      neighboring_boids += 1;
                   }
          }        
      }
      
      // If there were any boids in the visual range . . .            
      if (neighboring_boids > 0) 
      {
          // Divide accumulator variables by number of boids in visual range
          xpos_avg = xpos_avg/neighboring_boids;
          ypos_avg = ypos_avg/neighboring_boids;
          xvel_avg = xvel_avg/neighboring_boids;
          yvel_avg = yvel_avg/neighboring_boids;
  
          // Add the centering/matching contributions to velocity
          boid.vx = (boid.vx + 
                     (xpos_avg - boid.x)*centeringfactor + 
                     (xvel_avg - boid.vx)*matchingfactor);
  
          boid.vy = (boid.vy + 
                     (ypos_avg - boid.y)*centeringfactor + 
                     (yvel_avg - boid.vy)*matchingfactor);
      }
      
      // Add the avoidance contribution to velocity
      boid.vx = boid.vx + (close_dx*avoidfactor);
      boid.vy = boid.vy + (close_dy*avoidfactor);
  
      // If the boid is near an edge, make it turn by turnfactor
      // but in proportion to the distance from the permitted area
      if(boid.x < leftmargin)
          boid.vx = boid.vx + turnfactor*abs(boid.x - leftmargin);
      if(boid.x > rightmargin)
          boid.vx = boid.vx - turnfactor*abs(boid.x - rightmargin);
      if(boid.y > bottommargin)
          boid.vy = boid.vy - turnfactor*abs(boid.y - bottommargin);
      if(boid.y < topmargin)
          boid.vy = boid.vy + turnfactor*abs(boid.y - topmargin);

  
      // Calculate the boid's speed
      // Slow step! Lookup the "alpha max plus beta min" algorithm
      float speed = sqrt(boid.vx*boid.vx + boid.vy*boid.vy);
  
      // Enforce min and max speeds
      if (speed < minspeed)
      {
          boid.vx = (boid.vx/speed)*minspeed;
          boid.vy = (boid.vy/speed)*minspeed; //fix!
      }
      
      if (speed > maxspeed)
      {
          boid.vx = (boid.vx/speed)*maxspeed;
          boid.vy = (boid.vy/speed)*maxspeed;
      }
      
      // Update boid's position - is in worldphysics!
      //boid.x = boid.x + boid.vx;
      //boid.y = boid.y + boid.vy;
}


/// @date 2026-01-15 (modified)
