/// Ad hoc semigraphic map of the extended Moore neighborhood

println("--------------------------------------------------");

for (int l=-3; l<=3; l++)
{
  print('|');
  
  for (int r=-3; r<=3; r++)
  {
    print(nfs(l,1),nfs(r,1),'|'); //the nfs() function guarantees alignment
  }
  
  println();
  println("--------------------------------------------------");
}
