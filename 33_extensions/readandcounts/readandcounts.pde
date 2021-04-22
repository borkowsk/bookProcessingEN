/**
_ReadAndCounts_: 
Read file and make dictionary of tokens, then write dictionary in .md format
with links to reference if available.
2021 (c) Wojciech Borkowski wborkowski AT uw.edu.pl
*/

String FileName = "readandcounts.pde"; // "readandcounts.pde"; // "splitIntoTokens.pde"; // "reference.pde";
BufferedReader input;
IntDict dictionary = new IntDict();

//Output flags
Boolean trace = false;
Boolean alltk = false;
Boolean freq =  false;
Boolean multi = false;

void setup() 
{
  size(130,30);
  frameRate(500);
  // Open the file from the createReader() example
  if(args!=null)
  {
    FileName=args[0];
    if(args.length>1) multi=args[1].equals("+M");
    if(args.length>2) alltk=args[2].equals("+A");
  }
  else
  {
     println("USAGE:\n\treadandcount filename.pde [+/-M] [+/-A]\n");
  }
  println("Expected name of input file is \""+FileName+"\"\n");
  input = createReader(FileName); //file must exist   
}

int linecounter=0;
void draw() 
{
  String  iline;
  try 
  {
    iline = input.readLine();
    linecounter++;
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
    String[] pieces = splitIntoTokens(iline);//Split on borders of character types 
    print(linecounter,'\t');
    for (String s:pieces) 
    {
       String trimmed=trim(s);
       int    up=1;
       
       if(trimmed.length()==0) trimmed=" ";
       print("‘" + trimmed + "’•");
       
       if(trimmed.equals("()") || trimmed.equals("[]") || trimmed.equals("{}"))
             up=2;
       else      
       if(trimmed.equals("[") ||  trimmed.equals("]") )//'[' and ']' breaks .md syntax
            trimmed="[]";
       else     
       if(trimmed.equals("(") ||  trimmed.equals(")") )//'(' and ')' may break .md syntax
            trimmed="()";
       else
       if(trimmed.equals("{") ||  trimmed.equals("}") )//consequently as above
            trimmed="{}";
       else
       if(trimmed.charAt(0)=='"') trimmed="\"...\"";
            
       dictionary.add(trimmed,up);  
    }
    
    println();
  }
  
  background(0);
  textAlign(CENTER,CENTER);
  text(frameCount,width/2,height/2);
} 

void exit()
{
  PrintWriter output=createWriter(multi?FileName+".md":"keyindex.md");
  dictionary.sortKeys();

  println("\nRESULTS:");
  String[] keys=dictionary.keyArray();
  int[]    vals=dictionary.valueArray();
  
  for(int i=0;i<vals.length;i++)
  {
    String ref=reference.get(keys[i]);
    if(alltk || ref!=null )
    {
        print("“" + keys[i] + "”\t");
        output.print("[ ‘" + keys[i] + "’ ]");
        println(ref!=null?ref:"");
        output.print(ref!=null?"("+ref+")\t":"\t");
    }
  }
  
  println();
  output.println("\n"); // *.md file need double '\n'
  
  if(freq)
  {
    dictionary.div("{}",2);
    dictionary.div("[]",2);
    dictionary.div("()",2);
    dictionary.sortValuesReverse();
    keys=dictionary.keyArray();
    vals=dictionary.valueArray();
    for(int i=0;i<vals.length;i++)
    {
      String ref=reference.get(keys[i]);
      if(alltk || ref!=null )
      {
          print(nf(vals[i],4) + "\t‘" + keys[i] + "’\t\t");
          output.print(nf(vals[i],4) + "\t__‘" + keys[i] + "’__\t");
          println(ref!=null?ref:"");
          output.print(ref!=null?"<"+ref+">\n\n":"\n\n");
      }
    }
  }
  output.println("\n----\n[__Processing.org__](http://Processing.org/) <"+reference.get("Processing.org")+">\n");
  output.println("\n[Index made by _ReadAndCounts_ (c) Wojciech Borkowski](https://github.com/borkowsk/bookProcessingEN/tree/main/33_extensions/readandcounts)\n");
  output.close();
  //println(HALF_PI); //TEST
  super.exit();
}


//https://github.com/borkowsk/bookProcessingEN/tree/main/33_extensions/readandcounts

