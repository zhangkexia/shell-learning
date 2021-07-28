#/bin/bash
#environment variable
source /etc/profile
#cpu
cpu_us=`vmstat |awk '{print $13}' |sed -n '$p'`
cpu_sy=`vmstat |awk '{print $14}' |sed -n '$p'`
cpu_id=`vmstat |awk '{print $15}' |sed -n '$p'`
cpu_sum=$(($cpu_us+$cpu_sy))

if [ $cpu_sum -gt 90 ]
    then
    msg="TIME:$(date +%F_%T)
        HOSTNAME:$(hostname)
        IPADDR:$(ifconfig |awk 'NR==2 {print $2}')
        MSG:CPU high! used ${cpu_sum}%"
    echo $msg
fi
