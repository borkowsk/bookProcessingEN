// Magic trick - Sorting taken from JAVA
//-//////////////////////////////////////

import java.util.*;

void sortBirds() ///< birds flying lower must be drawn first!
{
  birds.sort(new Comparator<Bird>() {
      public int compare(Bird b1, Bird b2)
      {
         if(b1.z<b2.z) return -1;
         else if(b1.z>b2.z) return 1;
         else return 0;
      }
    });
}

/// @date 2025-11-25 (modified)
