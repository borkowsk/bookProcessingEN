//Read file and make dictionary of tokens

String FileName = "readandcounts.pde" ;
BufferedReader input;
String line;
Boolean trace = false;
Boolean all = false;
IntDict dictionary = new IntDict();

void setup() 
{
  size(130,30);
  frameRate(500);
  // Open the file from the createReader() example
  input = createReader(FileName); //file must exist   
}

void draw() {
  try 
  {
    line = input.readLine();
  } 
  catch (IOException e) 
  {
    e.printStackTrace();
    line = null;
  }
  
  if (line == null) 
  {
    // Stop reading because of an error or file is empty
    noLoop();
    exit();
  } 
  else 
  {
    String[] pieces = splitIntoTokens(line);//Split on borders of character types 
    
    for (String s:pieces) 
    {
       String trimmed=trim(s);
       if(trimmed.length()==0) trimmed=" ";
       print("‘" + trimmed + "’•");
       
       if(trimmed.equals("[") ||  trimmed.equals("]") )//[ & ] breaks .md syntax
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
        output.print(nf(vals[i],4) + "\t[ ‘" + keys[i] + "’ ]");
        println(ref!=null?ref:"");
        output.print(ref!=null?"("+ref+")\t":"\t");
    }
  }
  
  println();
  output.println("\n");//.md file need duble '\n'
  dictionary.sortValuesReverse();
  keys=dictionary.keyArray();
  vals=dictionary.valueArray();
  for(int i=0;i<vals.length;i++)
  {
    String ref=reference.get(keys[i]);
    if(all || ref!=null )
    {
        print(nf(vals[i],4) + "\t‘" + keys[i] + "’\t\t");
        output.print(nf(vals[i],4) + "\t[ ‘" + keys[i] + "’ ]");
        println(ref!=null?ref:"");
        output.print(ref!=null?":"+ref+"\n\n":"\n\n");
    }
  }
  
  output.close();
  //println(HALF_PI);//TEST
  super.exit();
}
