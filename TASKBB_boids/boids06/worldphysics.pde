/// Birds' decisions and actions have physical consequences
void moveBirds()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     //Moving...
     current.x+=current.vx;
     current.y+=current.vy;
     current.z+=current.vz;
     
     //Cloud and ground collision check
     if(current.z>=MAX_CEIL)
     {
       current.z=MAX_CEIL;
       current.vz=-1; 
     }
     else 
     if(current.z<=0)
     {
       current.vx=current.vy=current.vz=0;
     } 
   }
}

/// @date 2026-01-15 (modified)
