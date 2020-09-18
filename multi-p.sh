#!/bin/bash
#filename:multi-p.sh
PIDARRAY=()
for i in `seq 1 10000`
do
    
    {
    echo $i;sleep 1
    } &
    PIDARRAY+=("$!")
done
wait ${PIDARRAY[@]}
