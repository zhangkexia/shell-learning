#!/bin/sh
#author: zhangyueyue@cmss.chinamobile.com
#date: 2020-10-26
#version: 1.0
#crontab: NA 
#location: /home/deployer/ or /home/onest/

#var settings
#na

#main code
#get input
echo "check disk by smartctl!"

while getopts "d:h:" opt; do
    case $opt in
        h)
          echo "usage: "
          echo "-h for help;"
          echo "-d for disk label;"
          h_cmd=$OPTARG
          ;;
        d)
          disk_=$OPTARG
          ;;
        \?)
          echo "Invalid option: -$OPTARG"
          echo "-h for help!"
    esac
done

#function
function do_check {
    if [ $# != 1 ];then
        echo "var num not ok!"
    else
        /usr/bin/sudo smartctl --all '/dev/'$1
    fi
}


#main
if [ ! $h_cmd ];then
    do_check  $disk_

fi
