/// Ad hoc semigraphic map of the extended Moore neighborhood

println("--------------------------------------------------");

for (int k=-3; k<=3; k++)
{
  print('|');
  
  for (int l=-3; l<=3; l++)
  {
    print(nfs(k,1),nfs(l,1),'|'); //the nfs() function guarantees alignment
  }
  
  println();
  println("--------------------------------------------------");
}
