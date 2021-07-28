#! /bin/bash
echo -e "\e[1;32m **** CHECKING SYSTEM INFO AS SHOWN BELOW ****\e[0m"
# this script return some info as shown below
# -hostname:
echo -e "\e[31;43m**** HOSTNAME INFORMATION ****\e[0m"
hostnamectl
echo ""
#- file system disk space usage:
echo -e "\e[31;43m**** FILE SYSTEM DISK SPACE USAGE ****\e[0m"
df -h
echo ""
#-free and used memory
echo -e "\e[31;43m**** FREE AND USED MEMORY ****\e[0m"
free
echo ""
#-system uptime
echo -e "\e[31;43m**** SYSTEM UPTIME AND LOAD ****\e[0m"
uptime
echo ""
#-login user
echo -e "\e[31;43m**** CURRENTLY LOGGED-IN USERS ****\e[0m"
who
echo ""
#-top 5 processes
echo -e "\e[31;43m**** TOP 5 MEMEMORY-CONSUMING PROCESSES ****\e[0m"
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6
echo ""
echo -e "\e[1;32mDone.\e[0m"


