/// Table of squares of integers.
//*//////////////////////////////

final int N = 50;

int[]  squares = new int[N+1];

for(int i=0; i<=N ; i++ )
     squares[i] = i * i ;

// List these numbers using print!
println("First",N,"squares of integers");
for(int i=0; i<=N ; i++ )
     println(i,"->",squares[i]);

// https://github.com/borkowsk/bookProcessingEN
