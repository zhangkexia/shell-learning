#!/bin/bash

condition=true

if [ "$condition" = true ]; then
   mail -V -s "Party" $person <<- EOF
    this
    is 
    your 
   EOF
else
    echo "条件不满足，不执行 here document。"
fi
