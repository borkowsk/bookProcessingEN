/**
_ReadAndCounts_: 
This file define function which split string into tokens basing on a character types borders
2021 (c) Wojciech Borkowski wborkowski AT uw.edu.pl
*/

String[] splitIntoTokens(String iline)
{
  StringList pieces=new StringList();// for return
  
  if(iline.length()>0)
  {
    int beg=0;//First position of substring
    int ptype=Character.getType(iline.charAt(0));
    
    for(int i=0;i<iline.length();i++)
    { 
      char c=iline.charAt(i);
      int ctype=Character.getType(c);
      if(trace) print(ctype,'`'+c+"’ ");
      
      if(i>0 && iline.charAt(i-1)=='"' && iline.charAt(i-2)!='\'')
      {
        do{ 
            //println(iline.charAt(i)); 
            if(iline.charAt(i-1)=='\\') i++;
        }while(iline.charAt(i++)!='"');
        ctype=-10;
      }
      
      if( 
         c==',' || c==';' || c=='\\'
      || c=='[' || c=='{' || c=='(' 
      || c==']' || c=='}' || c==')' //Never combined with others
      || c=='\''|| c=='"'  //Does it work? Sometimes not? Why?
      || ( //ptype!=ctype &&  //Other type of character
         c!='_' //Never brake... Typically inside name
         && abs(ptype-ctype)>1 ) //Capital letters & small letter & parentheses differ in 1.
      )
      {
        String substr=iline.substring(beg,i);
        pieces.append(substr);
        if(substr.equals("//")) //comment to the end if line
            return pieces.array();
        ptype=ctype;
        beg=i;
      }
    }   
    pieces.append(iline.substring(beg,iline.length()));
    if(trace) println();
  }
  
  return pieces.array();
}

//https://github.com/borkowsk/bookProcessingEN/tree/main/33_extensions/readandcounts
