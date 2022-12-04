#!/bin/bash
result=""
shas=""
IFS=$'\n'
for file in $(find $1 -type f -name '.*')
do
    sha=$(sha256sum $file | cut -d ' ' -f 1)
    size=$(du $file | cut -f 1)
    result+="$sha\t$size\t$file\n"
    shas+="$sha\n"
done

for file in $(find $1 -type f)
do
    sha=$(sha256sum $file | cut -d ' ' -f 1)
    size=$(du $file | cut -f 1)
    result+="$sha\t$size\t$file\n"
    shas+="$sha\n"
done

duplicated=""
dupshas=$(echo -e $shas | uniq -cd)

for line in $(echo -e $result)
do
    sha=$(cut -d $'\t' -f 1 <<< $line)
    size=$(cut -d $'\t' -f 2 <<< $line)
    file=$(cut -d $'\t' -f 3 <<< $line)

    if [ $(expr "$dupshas" : ".*$sha.*") -gt 0 ]; 
    then
        count=$(grep -Po '[^;:]+(?='$sha')' <<< $dupshas | tr -d ' ')
        duplicated+="$(expr $size \* $count)\t$file\n"
    fi
done

echo -e $duplicated | sort -r | cut -f 2