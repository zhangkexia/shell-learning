#!/bin/bash
#filename: aspellcheck.sh
word=$1

output=`echo \"$word\" | aspell list`
echo $output

if [ -z $output ];then
    echo $word is a dictionary word;
else
    echo $word is not a dictionary word;
fi

