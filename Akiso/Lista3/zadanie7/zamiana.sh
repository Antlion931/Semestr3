#!/bin/bash
IFS=$'\n'
for file in $(find -maxdepth 1 -type f) 
do
    new_name=`tr '[A-ZĄŻŹĆŃÓĘŁŚ]' '[a-zążźćńóęłś]' <<< $file`
    mv $file $new_name
done
