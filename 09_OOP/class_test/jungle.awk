# pde2pyde class sufler
# @date 2024-12-03 (created)
# https://stackoverflow.com/questions/14212993/regular-expression-to-match-a-pattern-inside-awk-command
BEGIN {
        level=0
        in_class=0
        in_function=0
        field_count=0
        class_name[0]="global"
        constructors_patt="constructors_patt"
        constructor_count=0
        def_init["int"]="=0"
        def_init["float"]="=0.0"
        def_init["double"]="=0.0"
        def_init["boolean"]="=false"
        def_init["String"]="=\"\""
} 

/^[[:space:]]*class/ {
        in_class++
        ret=match($2, /[[:alnum:]]+/)
        cname=substr($2, RSTART, RLENGTH)
        class_name[in_class]=cname
        constructors_patt="^[ \t]*" cname "[ \t]*\("
        printf("%s //@CLASS %s\n",$0,cname)
        next
}

$0~constructors_patt { 
      in_function++
      print $0 "//@CONSTRUCTOR:" ++constructor_count
      next
}

/^[[:space:]]*(void|float|int|String)[[:space:]]+([[:alnum:]]+)[[:space:]]*\(/ {
      in_function++
      if(in_class>0) # RSTART RLENGTH?
        print $0 "//@METHOD DECLARATION" 
      else
        print $0 "//@FUNCTION DECLARATION"
      next
}

/static|final/ {
        if(in_class>0 && level==1 ) print "// static and final object members are not supported !!!"
        print
        next
}

/^[[:space:]]*(void|float|int|String)[[:space:]]+([[:alnum:]]+)[[:space:]]*[=\,\;]/ {
                                                                                #print "<<"in_class,level">>"
      if(in_class>0 && level==1 ) { #TYLKO DEKLARACJE NA POZIOMIE CAŁEJ KLASY.
        ret=match($0,/[[:alnum:]]/)                                             
        if(ret) indentation=substr(s$0, 1, RSTART-1)                            
        else indentation==""
                                                                                #; print "<<"RSTART,RLENGTH ">" indentation">>"
        type=$1
        
        rest=$2 " " $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9                #; printf("(%s) (%s) \n",type,rest)
        ret=match(rest,/\/\//)
        if(ret) comment=substr(rest, RSTART, length(rest) ) 
        
        ret=match(rest,/\;/)
        declars=substr(rest,1,RSTART-1)                                         #; printf("(%s) (%s);(%s) \n",type,declars,comment)
        
        ret=split(rest,spl,",")
        for( i in spl) {
                ret=match(spl[i], /[[:alnum:]]+/)
                fname=substr(spl[i], RSTART, RLENGTH)                          
                ret=match(spl[i], /=[[:space:]]*[[:alnum:]\+\-\*/]+/)
                
                if(ret) initial=substr(spl[i], RSTART, RLENGTH);
                else initial=def_init[type]
                                                                                #; print indentation "//@field - " type " " fname initial " " comment
                all_names[++field_count]=fname      # field order                                                          
                all_types[fname]=type              # register type of a field                                                                
                all_fields[fname]=initial          # registering the field
                all_comments[fname]=comment        # and information about
        }        
        #print $0 "//@FIELD DECLARATION " spl[1] , spl[2], spl[3]
      }
      else
        print $0 "//@VAR DECLARATION"
      next
}


/\{/ {
        print $0,"//@BEGIN"
        level++
        next
}

/\}/ {
        level--
        if(level==0 && in_class!=0 ){
                in_class--;
                print indentation "//@FIELD_INITIALISATIONS"
                for(fnum=1;fnum<=field_count;fnum++) {
                        fname=all_names[fnum]
                        print indentation all_types[fname] " " fname " " all_fields[fname] "; "  all_comments[fname] " //@FIELD DECLARATION "
                }
                print indentation "// fc:" field_count
                field_count=0   
                constructor_count=0
                print $0,"//@END_OF_CLASS"
        }
        else if( in_function>0 ) {
                in_function--
                print $0,"//@END_OF_FUNCTION"
             }
        else       
                print $0,"//@END"
                
        next
}


    { 
        print
        # print "$0 //@( " $1 " )" 
}
        
END { 
        printf ("\n// Finally, level is %d,infunction is %s, inclass is %d (%s)\n", level ,in_function,in_class,class_name[in_class])
}
