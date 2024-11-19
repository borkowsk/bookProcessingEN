/// Loop in loop - printing to console.
//*/////////////////////////////////////

for(int i=0;i<10;i++)
{
  print(i,": ");
  for(int j=0;j<10;j++)
  {
    print(j,""); // Console printout. "" is empty but forces space emmision.
    //print("*"); // ...with additional '*'
  }
  println();
}

// https://github.com/borkowsk/bookProcessingEN
