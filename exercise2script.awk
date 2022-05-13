#!/bin/bash

for file in $@; do
        if [ -f $file ] ; then
echo "File is: $file" 	#print out filename
                				#print the total number of times the number 1 appears in the file
                awk ' BEGIN {  print "The number of times the number 1 appears in the file is:" ; }
                      /^1/ {  counter+=1  ;  }
                      END {  printf "%s\n",  counter  ; } 
                    '  $file
        else
                #print error info incase input is not a file
                echo "$file is not a file, please specify a file." >&2 && exit 1
        fi
done

exit 0 	
