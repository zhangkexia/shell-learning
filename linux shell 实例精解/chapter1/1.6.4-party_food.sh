#!/bin/bash
# Gnu bash Version 2.xx
# The Party Program——Invitations to friends from the
# "guest" file
guestfile=./guests
if [[ ! -e "$guestfile" ]]
then
    printf "${guestfile##*/} non-existent"
    # 删除匹配，对于guestfile这个变量的字符串，*/匹配到的部分，删除掉
    # ./guests经过删除匹配后，剩余的就是guests
    # 这里是根据文件路径字符串，匹配出文件名
    exit 1
fi

export PLACE="Sarotini's"
(( Time=$(date +%H) + 1))
# 运算后，赋值给Time
# echo $Time
set cheese crackers shrimp drinks "hot dogs" sandwiches
for person in $(cat $guestfile)
do
    if [[ "$person" == "root" ]]
    then
        continue
    else
        echo "send mail here"
        printf "send mail here\n"
        echo "$person"" come ""$PLACE"", bring $1"" from ""$(hostname)"
        shift
        if [[ $# == 0 ]]
        then
            set cheese crackers shrimp drinks "hot dogs" sandwiches
        fi
    fi
done
printf "Bye..."