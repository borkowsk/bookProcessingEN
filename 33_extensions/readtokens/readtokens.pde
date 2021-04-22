//Read file and make dictionary of tokens

String FileName = "readtokens.pde" ;
BufferedReader input;
String line;
Boolean trace = true;

void setup() 
{
  size(130,30);
  frameRate(500);
  // Open the file from the createWriter() example
  input = createReader(FileName);    
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
       print("`"+trim(s)+"` ");
    }
    
    println();
  }
  
  background(0);
  textAlign(CENTER,CENTER);
  text(frameCount,width/2,height/2);
} 

String[] splitIntoTokens(String line)
{
  StringList pieces=new StringList();//For output
  
  if(line.length()>0)
  {
    int beg=0;//First position of substring
    int ptype=Character.getType(line.charAt(0));
    
    for(int i=0;i<line.length();i++)
    { 
      int ctype=Character.getType(line.charAt(i));
      if(trace) print(ctype,"`"+line.charAt(i)+"’ ");
      if(ptype!=ctype //Other type of character
      && abs(ptype-ctype)>1 //Capital letters & small letter & parentheses differ in 1.
      )
      {
        pieces.append(line.substring(beg,i));
        ptype=ctype;
        beg=i;
      }
    }   
    pieces.append(line.substring(beg,line.length()));
    if(trace) println();
  }
  
  return pieces.array();
}

void exit()
{
  super.exit();
}

void _Test1() 
{
  int a=1,b=2;
  a+=b;
  if( a==b && b!=1) print( 'o' );
}

//https://github.com/borkowsk/bookProcessingEN

