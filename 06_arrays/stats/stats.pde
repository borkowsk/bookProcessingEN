//Mean of some random numbers:

final int N=20;// How many numbers?
float[] numbers=new float[N];// table storing values

//Draw numbers randomly!
for(int i=0;i<N;i++)
    numbers[i]=random(0,10);
  
//Print numbers
for(int i=0;i<N;i++)
    println(i,":",numbers[i]);

//Sum up the numbers!
float sum=0;
for(int i=0;i<N;i++)
     sum=sum+numbers[i];//<=> sum+=numbers[i]; 

println("Sum =",sum);

//Calculate and write the average!
print("Average =",sum/N);

//https://github.com/borkowsk/bookProcessingEN

