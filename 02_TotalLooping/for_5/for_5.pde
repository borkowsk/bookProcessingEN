/// Squares of i

size(100,250);
background(0);stroke(255);

for(int i=0;i<16;i++) //REPEAT 16 TIMES
{
    println(i*i); //calculate square of i
    ellipse(i,250-i*i,2,2); // better visible than point(i,250-i*i);
}

// https://github.com/borkowsk/bookProcessingEN
