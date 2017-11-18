#!/bin/sh
#Author: monokoo <realstones2012@gmail.com>

server=http://sc.ftqq.com
CONFIG=/etc/config/serverchan

version=$(cat /etc/openwrt_release 2>/dev/null| grep -w DISTRIB_RELEASE | grep -w "By stones")
version2=$(cat /etc/openwrt_release 2>/dev/null| grep -w DISTRIB_DESCRIPTION | grep -w Koolshare)
[ -z "$version" -a -z "$version2" ] && exit 0

config_t_get() {
        local ret=$(uci get $CONFIG.$1.$2 2>/dev/null)
        #echo ${ret:=$3}
		[ -z "$ret" -a -n "$3" ] && ret=$3
        echo $ret
}

check_network() {
  curl -s $server
  if [ "$?" = "0" ]; then
    /usr/sbin/ntpd -q -p 0.openwrt.pool.ntp.org -p 3.openwrt.pool.ntp.org -p asia.pool.ntp.org -p ntp.sjtu.edu.cn
  else
    logger -t ServerChan "网络连接错误，请稍候尝试！"
    exit 0
  fi
}

api_post() {
  curl -sSL "$server/$sckey.send?text=$1" -d "desp=$2"
}

get_wan_info() {
	local desp_wan=""
	all_interfaces=`uci show network | grep -v 'lan\|loopback' | grep "=interface" | awk -F'.' '{print $2}' |awk -F'=' '{print $1}'`
	for iface in $all_interfaces
	do
		devname=`cat /var/state/network 2>/dev/null | grep -w "network.$iface.ifname" |awk -F"'" '{print $2}'`
		[ -z "$devname" ] && devname=`ifstatus $iface 2>/dev/null| grep l3_device |awk -F'"' '{print $4}'`
		if [ -n "$devname" ]; then
			publicip=`curl -s --interface $devname http://members.3322.org/dyndns/getip 2>/dev/null` || publicip=`curl -s --interface $devname http://1212.ip138.com/ic.asp 2>/dev/null | grep -Eo '([0-9]+\.){3}[0-9]+'`
			[ -z "$publicip" ] && publicip="无法获取"
			devinfo=$(ifconfig $devname 2>/dev/null)
			wanip=$(echo $devinfo | grep "inet addr:" | grep -E -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"|head -1)
			wan_uptime=`ifstatus $iface 2>/dev/null| grep -w "uptime\":" | awk '{print $2}'|awk -F',' '{print $1}' | awk '{print int($1/86400)"天 "int($1%86400/3600)"小时 "int(($1%3600)/60)"分钟 "int($1%60)"秒"}'`
			RX_bytes=`echo $devinfo| grep "RX bytes" | awk -F'TX bytes' '{print $1}'| grep -Po '(?<=\050)[^\051]+'`
			TX_bytes=`echo $devinfo| grep "RX bytes" | awk -F'TX bytes' '{print $2}'| grep -Po '(?<=\050)[^\051]+'`
			if [ -n "$wanip" ]; then
				temp_desp_wan="

**$iface状态：**

$iface 公网IP: $publicip

$iface 接口IP: $wanip

$iface 连接时间: $wan_uptime

$iface 接收流量: $RX_bytes

$iface 发送流量: $TX_bytes  
"
			fi
			desp_wan=$desp_wan$temp_desp_wan
		else
			logger -t ServerChan "无法获取接口名称，请稍候尝试！"
		fi
	done
	desp_wan_header="
****
"
	desp_wan=$desp_wan_header$desp_wan
	echo -n "$desp_wan"
}

get_router_status(){
	nowtime=`date '+%Y-%m-%d %H:%M:%S'`
	uptime=$(awk '{print int($1/86400)"天 "int($1%86400/3600)"小时 "int(($1%3600)/60)"分钟 "int($1%60)"秒"}' /proc/uptime)
	loadavg=`cat /proc/loadavg |awk '{print $1,$2,$3}' | sed 's/ /,/g'`
	sum_mem=$((`cat /proc/meminfo |grep "MemTotal"| awk '{print $2}'`/1024))
	free_mem=$((`cat /proc/meminfo |grep "MemFree"| awk '{print $2}'`/1024))
	lan_ip=`uci -q get network.lan.ipaddr` || lan_ip=`ifconfig br-lan 2>/dev/null | grep "inet addr:" | grep -E -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"|head -1`
	
	router_status="
****
**系统运行状态：**

路由名称：$(uname -n)

系统时间：$nowtime

开机时长：$uptime

管理地址：$lan_ip

平均负载：$loadavg

内存总数：$sum_mem MB； 空闲内存：$free_mem MB  
"
	echo -n "$router_status"
}

get_router_temp(){
	CPU_TEMP=$(awk 'BEGIN{printf "%.2f\n",'$(cat /sys/class/thermal/thermal_zone0/temp)'/1000}')"℃"
	router_temp="

****
**cpu温度状况：**

温度：$CPU_TEMP  
"
	echo -n "$router_temp"
}

get_koolss_status(){
	internal_code=`curl -I -o /dev/null -s -m 10 --connect-timeout 5 -w %{http_code} 'https://www.baidu.com'`
	foreign_code=`curl -I -o /dev/null -s -m 10 --connect-timeout 5 -w %{http_code} 'https://www.google.com.tw'`
	if [ "$internal_code" == "200" ]; then
		koolss_china="连接正常"
	else
		koolss_china="无法访问"
	fi
	if [ "$foreign_code" == "200" ]; then
		koolss_foreign="连接正常"
	else
		koolss_foreign="无法访问"
	fi
	koolss_status="

****
**koolss连接状态：**

国内连接：$koolss_china

国外连接：$koolss_foreign  
"
	echo -n "$koolss_status"
}

get_client_list(){
	local client
	local list_file=/tmp/client_list_$(date '+%N')
	echo -e "\n"  >$list_file
	echo "****"  >>$list_file
	echo "**在线客户端列表：**" >>$list_file
	echo -e "\n"  >>$list_file
	if [ "$client_list" == "all" ]; then
		echo "|IP地址　|MAC地址　|客户端名 |" >>$list_file
		echo "| :- | :- | :- |" >>$list_file
	else
		echo "|IP地址　|客户端名 |" >>$list_file
		echo "| :- | :- |" >>$list_file
	fi
	mac_list=`cat /proc/net/arp | grep br-lan | grep -w "0x2" | awk '{print $4}'`
	for mac in $mac_list
	do
		hostip=`cat /tmp/dhcp.leases 2>/dev/null| grep "$mac" |awk '{print $3}'`
		hostname=`cat /tmp/dhcp.leases 2>/dev/null| grep "$mac" |awk '{print $4}'`

		[ -z "$hostip" -o -z "$hostname" ] && {
			dhcp_index=`uci show dhcp | grep "$mac" |awk -F'.' '{print $2}'`
            [ -z "$hostip" ] && hostip=`uci -q get dhcp.$dhcp_index.ip`
			[ -z "$hostname" ] && hostname=`uci -q get dhcp.$dhcp_index.name`
		}
		upper_mac=`echo $mac | tr '[a-z]' '[A-Z]'`
		if [ "$client_list" == "all" ]; then
			tmp_client="
|$hostip　|$upper_mac　|$hostname |
"
		else
			tmp_client="
|$hostip　|$hostname |
"
		fi
		echo  $tmp_client >>$list_file		
	done
	echo "****"  >>$list_file
	client=$(cat $list_file)
	rm -rf $list_file
	echo -n "$client"
}

load_config(){
	[ ! -f "$CONFIG" ] && exit 0
	enabled=$(config_t_get global enabled 0)
	sckey=$(config_t_get global sckey)
	[ "$enabled" -gt 0 ] && [ -n "$sckey" ] || exit 0
	check_network
	title=$(config_t_get timing_message title "K3 Lede 路由状态消息:")
	text=`echo -n "$title" | sed 's/ /+/g'`
	router_wan=$(config_t_get timing_message router_wan 0)
	
	router_status=$(config_t_get timing_message router_status 0)
	router_temp=$(config_t_get timing_message router_temp 0)
	koolss_status=$(config_t_get timing_message koolss_status 0)
	client_list=$(config_t_get timing_message client_list disable)
	send_mode=$(config_t_get timing_message send_mode disable)
	no_disturb_time=$(config_t_get timing_message no_disturb_time 0)
}


start(){	
	load_config
	local desp="
本条消息来自于：手动发送
"
	[ "$router_status" -eq 1 ] && {
		desp_router_status=`get_router_status`
		desp=$desp$desp_router_status
	}
	[ "$router_temp" -eq 1 ] && {
		desp_router_temp=`get_router_temp`
		desp=$desp$desp_router_temp
	}
	[ "$koolss_status" -eq 1 ] && {
		desp_koolss_status=`get_koolss_status`
		desp=$desp$desp_koolss_status
	}
	[ "$router_wan" -eq 1 ] && {
		desp_router_wan=`get_wan_info`
		desp=$desp$desp_router_wan
	}
	[ "$client_list" != "disable" ] && {
		desp_client_list=`get_client_list`
		desp=$desp$desp_client_list
	}
	api_post "$text" "$desp" >/dev/null
}

auto(){
	load_config
	[ "$send_mode" == "disable" ] && exit 0
	[ "$no_disturb_time" -eq 1 ] && {
		timeoff=$(config_t_get timing_message timeoff 1)
		timeon=$(config_t_get timing_message timeon 7)
		nowh=`date '+%H'`
		[ "$nowh" -gt "$timeoff" -a "$nowh" -lt "$timeon" ] && exit 0
	}
	local desp="
本条消息来自于：定时发送
"
	[ "$router_status" -eq 1 ] && {
		desp_router_status=`get_router_status`
		desp=$desp$desp_router_status
	}
	[ "$router_temp" -eq 1 ] && {
		desp_router_temp=`get_router_temp`
		desp=$desp$desp_router_temp
	}
	[ "$koolss_status" -eq 1 ] && {
		desp_koolss_status=`get_koolss_status`
		desp=$desp$desp_koolss_status
	}
	[ "$router_wan" -eq 1 ] && {
		desp_router_wan=`get_wan_info`
		desp=$desp$desp_router_wan
	}
	[ "$client_list" != "disable" ] && {
		desp_client_list=`get_client_list`
		desp=$desp$desp_client_list
	}
	api_post "$text" "$desp" >/dev/null
}

case $1 in
auto)
	auto
	;;
start)
	start
	;;
esac
