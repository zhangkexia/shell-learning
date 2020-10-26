#!/bin/sh
#author: zhangyueyue@cmss.chinamobile.com
#date: 2020-10-26
#version: 1.0
#crontab: NA 
#location: /home/deployer/ or /home/onest/
#usage: Adjust full_ratio temporarily


#var settings


#main code
#get input
echo "For adjust full_ratio temporarily!"

while getopts "m:a:h:" opt; do
    case $opt in
        h)
          echo "usage: "
          echo "-h for help;"
          echo "-m for ceph or /var/lib/ceph/bin/ceph;"
          echo "-a for ajust ratio."
          h_cmd=$OPTARG
          ;;
        a)
          a_num=$OPTARG
          ;;
        m)
          ceph_cmd=$OPTARG
          ;;
        \?)
          echo "Invalid option: -$OPTARG"
          echo "-h for help!"
    esac
done

#function
function do_ajust {
    if [ $# != 2 ];then
        echo $#
        echo "var num not ok!"
    elif [[ $2 > 0.01 || $2 < -0.01 ]];then
        echo "adjust too much,the number needs to be less then 0.01."
    else
        nearfull_ratio=`/usr/bin/sudo $1 osd dump |grep nearfull_ratio|egrep -o [0-9].*.[0-9].*`
        backfillfull_ratio=`/usr/bin/sudo $1 osd dump |grep backfillfull_ratio|egrep -o [0-9].*.[0-9].*` 
        full_ratio=`/usr/bin/sudo $1 osd dump |grep full_ratio |egrep -o [0-9].*.[0-9].*`
        if [ $full_ratio > 0.97 ];then
            echo "ratio too high, no adjust!"
        else
            nearfull_ratio=`expr $nearfull_ratio + $2`
            backfillfull_ratio=`expr $backfillfull_ratio + $2`
            full_ratio=`expr $full_ratio + $2`
            /usr/bin/sudo $1 osd set_nearfull_ratio $nearfull_ratio&&/usr/bin/sudo $1 osd set_backfillfull_ratio $backfillfull_ratio&&/usr/bin/sudo $1 osd set_full_ratio $full_ratio&&echo "adjust ok!" 
       fi
    fi
}


#main
if [ ! $h_cmd ];then
    do_ajust $ceph_cmd $a_num

fi
