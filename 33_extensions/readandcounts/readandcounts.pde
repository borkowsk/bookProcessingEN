/**
Read file and make dictionary of tokens, then write dictionary in .md format
*/

String FileName = "readandcounts.pde" ;
BufferedReader input;
IntDict dictionary = new IntDict();

//Output flags
Boolean trace = false;
Boolean all = false;
Boolean freq = false;

void setup() 
{
  size(130,30);
  frameRate(500);
  // Open the file from the createReader() example
  if(args!=null)
    FileName=args[0];
  println("Name of input file is \""+FileName+"\"\n");
  input = createReader(FileName); //file must exist   
}

void draw() 
{
  String  iline;
  try 
  {
    iline = input.readLine();
  } 
  catch (IOException e) 
  {
    e.printStackTrace();
    iline = null;
  }
  
  if (iline == null) 
  {
    // Stop reading because of an error or file is empty
    noLoop();
    exit();
  } 
  else 
  {
    String[] pieces = splitIntoTokens(iline); //Split on borders of character types 
    
    for (String s:pieces) 
    {
       String trimmed=trim(s);
       if(trimmed.length()==0) trimmed=" ";
       print("‘" + trimmed + "’•");
       
       if(trimmed.equals("[") ||  trimmed.equals("]") )//'[' and ']' breaks .md syntax
            trimmed="[]";
       dictionary.increment(trimmed);  
    }
    
    println();
  }
  
  background(0);
  textAlign(CENTER,CENTER);
  text(frameCount,width/2,height/2);
} 

void exit()
{
  PrintWriter output=createWriter("keyindex.md");
  dictionary.sortKeys();

  println("\nRESULTS:");
  String[] keys=dictionary.keyArray();
  int[]    vals=dictionary.valueArray();
  
  for(int i=0;i<vals.length;i++)
  {
    String ref=reference.get(keys[i]);
    if(all || ref!=null )
    {
        print('‘' + keys[i] + "’\t");
        output.print("[ ‘" + keys[i] + "’ ]");
        println(ref!=null?ref:"");
        output.print(ref!=null?"("+ref+")\t":"\t");
    }
  }
  
  println();
  output.println("\n"); // *.md file need duble '\n'
  
  if(freq)
  {
    dictionary.sortValuesReverse();
    keys=dictionary.keyArray();
    vals=dictionary.valueArray();
    for(int i=0;i<vals.length;i++)
    {
      String ref=reference.get(keys[i]);
      if(all || ref!=null )
      {
          print(nf(vals[i],4) + "\t‘" + keys[i] + "’\t\t");
          output.print(nf(vals[i],4) + "\t__‘" + keys[i] + "’__\t");
          println(ref!=null?ref:"");
          output.print(ref!=null?"<"+ref+">\n\n":"\n\n");
      }
    }
  }
  output.println("\n__Processing.org__ <"+reference.get("Processing.org")+">\n");
  output.close();
  //println(HALF_PI); //TEST
  super.exit();
}
