#!/bin/sh

for filename in *.png
do 
    #echo $filename
    #b= echo $filename | cut -d. -f1
    #echo $b    
    mv "${filename}" "mini-${filename}"    
done

