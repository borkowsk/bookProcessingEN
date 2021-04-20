/**
_ReadAndCounts_: 
This file define function which split string into tokens basing on a character types borders
2021 (c) Wojciech Borkowski wborkowski@uw.edu.pl
*/

String[] splitIntoTokens(String line)
{
  StringList pieces=new StringList();// for return
  
  if(line.length()>0)
  {
    int beg=0;//First position of substring
    int ptype=Character.getType(line.charAt(0));
    
    for(int i=0;i<line.length();i++)
    { 
      char c=line.charAt(i);
      int ctype=Character.getType(c);
      if(trace) print(ctype,"`"+c+"’ ");
      
      if( 
       ( ptype!=ctype //Other type of character
         && c!='_' //Never brake... Typically inside name
         && abs(ptype-ctype)>1 ) //Capital letters & small letter & parentheses differ in 1.
      || c==',' || c==';' || c=='\\'
      || c==']' || c=='}' || c==')' //Never combined with others
      || c=='"' || c=='\''  //Does not work? Sometimes? Why?
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
