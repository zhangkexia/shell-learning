#!/bin/bash
#clear file
:>''$(hostname)'.stats_info.txt'
:>''$(hostname)'.put_info.txt'

rados_cmd=$1


#get uid list
sudo $rados_cmd metadata list user |sed 's/[\",\,,\[]//g' |sed 's/\]//g' >ids.txt

#end date
end_date=`date -d "-8 hour" "+%Y-%m-%d %H:%M:%S"`
#start date
start_date=`date -d "-32 hour" "+%Y-%m-%d %H:%M:%S"`

#multi process
ps_num=3
[ -e ./fd1 ] || mkfifo ./fd1
exec 3<> ./fd1  
rm -rf ./fd1 
for i in `seq 1 $ps_num`;
do
    echo >&3
done




for id in `cat ids.txt`;
do
   read -u3
   { #get user stats
    stats_info=`sudo $rados_cmd user stats --uid=$id`;
    total_stats=`echo $stats_info |sed 's/{ "stats": { "total_entries": [0-9]*, "total_bytes": //g'|sed 's/, "total_bytes_rounded": .* }, "last_stats_sync": ".*", "last_stats_update": ".*" }//g'`;
    if [ ${#total_stats} != 0 ];then
    echo $id,$total_stats >>''$(hostname).stats_info.txt'';
    fi
    
    #get user put per day
    id_info=`sudo $rados_cmd usage show --uid=$id --start-date="$start_date" --end-date="$end_date" --categories=put_obj`;
    if [ ${#id_info} != 40 ];then
    total_put=`echo $id_info |grep -Eo '\"total\".*bytes_received\": .*\,'|sed 's/"total": { "bytes_sent": .* "bytes_received": //g'|sed 's/\, "ops".*\,//g'`;
    echo $id,$total_put >>''$(hostname).put_info.txt'';
    fi
    echo >&3 
    }&
done
wait

exec 3<&- 
exec 3>&-