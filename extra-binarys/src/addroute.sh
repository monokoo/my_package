#!/bin/sh
# Copyright (C) 2016 fw867 <ffkykzs@gmail.com>
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.

wanport=$1
routeip=$2
cleanfile=$3

version=$(cat /etc/openwrt_release | grep -w DISTRIB_RELEASE | grep -w "By stones")
version2=$(cat /etc/openwrt_release | grep -w DISTRIB_DESCRIPTION | grep -w Koolshare)
[ -z "$version" -a -z "$version2" ] && exit 0

if [ $wanport -gt 0 ] && [ -z $(/usr/sbin/ip route show|grep $routeip) ];then
  gateway=$(/usr/sbin/ip route show|grep default|awk -F " " '{print $3}'|sed -n $wanport"p")
  devname=$(/usr/sbin/ip route show|grep default|awk -F " " '{print $5}'|sed -n $wanport"p")
  epname=$(cat /var/state/network|grep -w $devname|awk -F'.' '{print $2}')
  if [ -n $gateway ] && [ -n $devname ];then
    /usr/sbin/ip route add $routeip via $gateway dev $devname >/dev/null 2>&1 &
    echo "$(date): 设置指定IP：$routeip 出口为：$epname"
	if [ ! -f $cleanfile ];then
		cat > $cleanfile <<EOF
#!/bin/sh
EOF
	fi
	if [ ! -x $cleanfile ];then
		chmod a+x $cleanfile
	fi
    echo "ip route del $routeip via $gateway dev $devname" >> $cleanfile
  fi
fi

