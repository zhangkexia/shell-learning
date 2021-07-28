#/bin/bash
#environmnet variable
source /etc/profile

#memory
bu=`free |awk 'NR==2 {print $6}'`
us=`free |awk 'NR==2 {print $3}'`
to=`free |awk 'NR==2 {print $2}'`
mem=`expr "scale=2;($us-$bu)/$to" |bc -l |cut -d. -f2`
#echo $mem
if [ $mem -gt 70 ]
    then
    msg="TIME:$(date +%F_%T)
        HOSTNAME:$(hostname)
        IPADDR:$(ifconfig |awk 'NR==2 {print $2}')
        MSG:mem high! used ${mem}%"
    echo $msg
fi
