#!/bin/sh

timestamp=$(date -u "+%Y-%m-%dT%H%%3A%M%%3A%SZ")
server=http://sc.ftqq.com

version=$(cat /etc/openwrt_release | grep -w DISTRIB_RELEASE | grep -w "By stones")
version2=$(cat /etc/openwrt_release | grep -w DISTRIB_DESCRIPTION | grep -w Koolshare)
[ -z "$version" -a -z "$version2" ] && exit 0

config_load "serverchan"
local enabled sckey
local title router_status router_temp router_wan koolss_status client_list send_mode regular_time interval_time
local t_redial t_client_up t_client_up_type t_client_up_blacklist t_client_up_whitelist 

config_get_bool enabled global enabled 0
config_get sckey global sckey

[ "$enabled" -gt 0 ] && [ -n "$sckey" ] || exit

config_get title timing_message title
config_get router_status timing_message router_status
config_get router_temp timing_message router_temp
config_get router_wan timing_message router_wan 0
config_get koolss_status timing_message koolss_status
config_get client_list timing_message client_list
config_get send_mode timing_message send_mode
config_get regular_time timing_message regular_time
config_get interval_time timing_message interval_time


config_get t_redial trigger_message t_redial
config_get t_client_up trigger_message t_client_up
config_get t_client_up_type trigger_message t_client_up_type
config_get t_client_up_blacklist trigger_message t_client_up_blacklist
config_get t_client_up_whitelist trigger_message t_client_up_whitelist



check_network() {
  curl -s $server
  if [ "$?" = "0" ]; then
    /etc/init.d/sysntpd restart
    DT=`date '+%Y-%m-%d %H:%M:%S'`
  else
    logger -t ServerChan "网络连接错误，请稍候尝试！"
    exit
  fi
}

api_post() {
  curl -s "$server/$sckey.send?text=$1" -d "desp=$2"
}

get_wan_info() {
local desp_wan=""
all_interfaces=`uci show network | grep -v 'lan\|loopback' | grep "=interface" | awk -F'.' '{print $2}' |awk -F'=' '{print $1}'`
for iface in $all_interfaces
do
	devname=`uci -P /var/state get network.$iface.ifname 2>/dev/null`
	if [ -n "$devname" ]; then
		publicip=`curl -s --interface $devname http://members.3322.org/dyndns/getip 2>/dev/null` || publicip=`curl -s --interface $devname http://1212.ip138.com/ic.asp 2>/dev/null | grep -Eo '([0-9]+\.){3}[0-9]+'`
		[ -z "$publicip" ] && publicip="无法获取"
		wanip=$(ifconfig $devname 2>/dev/null | grep "inet addr:" | grep -E -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"|head -1)
		if_uptime=`ifstatus $devname | grep -w "uptime\":" | awk '{print $2}'|awk -F',' '{print $1}'`
		day=$(($if_uptime/86400))
		hour=$(($(($if_uptime-86400*$day))/3600))
		min=$(($(($if_uptime/60))%60))
		second=$(($if_uptime%60))
		wan_uptime="$day天 $hour小时 $min分钟 $second秒"
		RX_bytes=`ifconfig $devname 2>/dev/null | grep "RX bytes" | awk -F'TX bytes' '{print $1}'| grep -Po '(?<=\050)[^\051]+'`
		TX_bytes=`ifconfig $devname 2>/dev/null | grep "RX bytes" | awk -F'TX bytes' '{print $2}'| grep -Po '(?<=\050)[^\051]+'`
		if [ -z "$wanip" ]; then
			temp_desp_wan="
####$iface状态：

$iface 公网地址: $publicip

$iface IP地址: $wanip

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

}


check_network
[ "$router_wan" -eq 1 ] && {
	get_wan_info
	api_post $title $desp_wan
}
