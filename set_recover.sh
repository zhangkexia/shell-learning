#!/bin/sh
#author: zhangyueyue@cmss.chinamobile.com
#date: 2020-10-26
#version: 1.0
#crontab: NA 
#location: /home/deployer/ or /home/onest/

#var settings


#main code
#get input
echo "set or unset osd recover options!"

while getopts "m:s:h:" opt; do
    case $opt in
        h)
          echo "usage: "
          echo "-h for help;"
          echo "-m for ceph or /var/lib/ceph/bin/ceph;"
          echo "-s for set or unset."
          h_cmd=$OPTARG
          ;;
        s)
          s_cmd=$OPTARG
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
function do_setting {
    if [ $# != 2 ]
    then
        echo "var num not ok!"
    else
        /usr/bin/sudo $1 osd $2 nobackfill&&/usr/bin/sudo $1 osd $2 norecover&&echo "$2 ok!"
    fi
}


#main
if [ ! $h_cmd ];then
    do_setting $ceph_cmd $s_cmd

fi
