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
    println("Caught! Change a goal, now!");
    me.vx=0;
    me.vy=0;
    me.vz=0;
    if(me.tz<MAX_CEIL/2)
    {
      me.tz=MAX_CEIL-1; //Target now unattainable height
    }
    else 
    {
      me.tx=-NORD_SOUTH;me.ty=-WEST_EAST;me.tz=MAX_CEIL+1; // Not the real target.
    }
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
void thinkAndDoBoids(Bird boid,int my_index)
{
  // For every "boid" - is "upstairs" . . .  //for each boid (boid):
  
      // Zero all accumulator variables
      float xpos_avg, ypos_avg, zpos_avg, xvel_avg, yvel_avg, zvel_avg, neighboring_boids, close_dx, close_dy, close_dz;
      xpos_avg=ypos_avg=zpos_avg=xvel_avg=yvel_avg=zvel_avg=neighboring_boids=close_dx=close_dy=close_dz = 0.0;
  
      // For every other boid in the flock . . .
      //for each other boid (otherboid):
      for(int i=0;i<HM_BIRDS;i++)
      if(i!=my_index)
      {
          Bird otherboid=birds.get(i);
          
          // Compute differences in x and y coordinates
          float dx = boid.x - otherboid.x;
          float dy = boid.y - otherboid.y;
          float dz = boid.z - otherboid.z;
  
          // Are both those differences less than the visual range?
          if (abs(dx)<visualRange && abs(dy)<visualRange && abs(dz)<visualRange)
          {
              // If so, calculate the squared distance
              float squared_distance = dx*dx + dy*dy + dz*dz;
  
              // Is squared distance less than the protected range?
              if (squared_distance < protectedRangeSquared)
              {
                  // If so, calculate difference in x/y/z-coordinates to nearfield boid
                  close_dx += boid.x - otherboid.x;
                  close_dy += boid.y - otherboid.y;
                  close_dz += boid.z - otherboid.z;
              }
              // If not in protected range, is the boid in the visual range?
              else if (squared_distance < visualRangeSquared)
                   {
                      // Add other boid's x/y/z-coord and x/y/z vel to accumulator variables
                      xpos_avg += otherboid.x;
                      ypos_avg += otherboid.y;
                      zpos_avg += otherboid.z;
                      
                      xvel_avg += otherboid.vx;
                      yvel_avg += otherboid.vy;
                      zvel_avg += otherboid.vz;
                      
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
          zpos_avg = zpos_avg/neighboring_boids;
          
          xvel_avg = xvel_avg/neighboring_boids;
          yvel_avg = yvel_avg/neighboring_boids;
          zvel_avg = zvel_avg/neighboring_boids;
  
          // Add the centering/matching contributions to velocity
          boid.vx = (boid.vx + 
                     (xpos_avg - boid.x)*centeringFactor + 
                     (xvel_avg - boid.vx)*matchingFactor);
  
          boid.vy = (boid.vy + 
                     (ypos_avg - boid.y)*centeringFactor + 
                     (yvel_avg - boid.vy)*matchingFactor);
                     
          boid.vz = (boid.vz + 
                     (zpos_avg - boid.z)*centeringFactor + 
                     (zvel_avg - boid.vz)*matchingFactor);           
      }
      
      // Add the avoidance contribution to (x,y,z)-velocity
      boid.vx = boid.vx + (close_dx*avoidFactor);
      boid.vy = boid.vy + (close_dy*avoidFactor);
      boid.vz = boid.vz + (close_dz*avoidFactor);
  
      // If the boid is near an edge, make it turn by turnfactor
      // but in proportion to the distance from the permitted area
      if(boid.x < westMargin)
          boid.vx = boid.vx + turnFactor*abs(boid.x - westMargin);
      if(boid.x > eastMargin)
          boid.vx = boid.vx - turnFactor*abs(boid.x - eastMargin);
          
      if(boid.y > southMargin)
          boid.vy = boid.vy - turnFactor*abs(boid.y - southMargin);
      if(boid.y < nordMargin)
          boid.vy = boid.vy + turnFactor*abs(boid.y - nordMargin);

      if(boid.z > ceilMargin)
          boid.vz = boid.vz - turnFactor*abs(boid.z - ceilMargin);
      if(boid.z < groundMargin)
          boid.vz = boid.vz + turnFactor*abs(boid.z - groundMargin);
  
      // Calculate the boid's speed
      // Slow step! Lookup the "alpha max plus beta min" algorithm
      float speed = sqrt(boid.vx*boid.vx + boid.vy*boid.vy + boid.vz*boid.vz);
  
      // Enforce min and max speeds
      if (speed < minSpeed)
      {
          boid.vx = (boid.vx/speed)*minSpeed;
          boid.vy = (boid.vy/speed)*minSpeed;
          boid.vz = (boid.vz/speed)*minSpeed;
      }
      
      if (speed > maxSpeed)
      {
          boid.vx = (boid.vx/speed)*maxSpeed;
          boid.vy = (boid.vy/speed)*maxSpeed;
          boid.vz = (boid.vz/speed)*maxSpeed;
      }
      
      // Update boid's position - is in worldphysics!
      //boid.x = boid.x + boid.vx;
      //boid.y = boid.y + boid.vy;
}


/// @date 2026-01-15 (modified)
