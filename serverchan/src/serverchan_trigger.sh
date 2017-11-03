#!/bin/sh
#Author: monokoo <realstones2012@gmail.com>

server=http://sc.ftqq.com

version=$(cat /etc/openwrt_release | grep -w DISTRIB_RELEASE | grep -w "By stones")
version2=$(cat /etc/openwrt_release | grep -w DISTRIB_DESCRIPTION | grep -w Koolshare)
[ -z "$version" -a -z "$version2" ] && exit

TYPE=$1
ACTION=$2
PARAM3=$3
PARAM4=$4
PARAM5=$5

check_network() {
  curl -s $server
  if [ "$?" = "0" ]; then
    /etc/init.d/sysntpd restart
  else
    logger -t ServerChan "网络连接错误，请稍候尝试！"
    exit
  fi
}

api_post() {
  curl -sSL "$server/$sckey.send?text=$1" -d "desp=$2"
}

if [ "$TYPE" == "iface" -a "$ACTION" == "ifup" ]; then
	INTERFACE=$PARAM3
	DEVICE=$PARAM4
	[ -z "$INTERFACE" ] || [ -z "$DEVICE" ] && exit
	t_redial=`uci -q get serverchan.trigger_message.t_redial`
	[ "t_redial" -eq 1 ] || exit

	check_network
	nowtime=`date '+%Y-%m-%d %H:%M:%S'`
	publicip=`curl -s --interface $DEVICE http://members.3322.org/dyndns/getip 2>/dev/null` || publicip=`curl -s --interface $DEVICE http://1212.ip138.com/ic.asp 2>/dev/null | grep -Eo '([0-9]+\.){3}[0-9]+'`
	[ -z "$publicip" ] && publicip="暂时无法获取公网IP"
	wanip=$(ifconfig $DEVICE 2>/dev/null | grep "inet addr:" | grep -E -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"|head -1)
	desp_wan="
**接口$INTERFACE上线后信息：**  
系统时间：$nowtime
$INTERFACE 公网IP: $publicip

$INTERFACE 接口IP: $wanip
"
	text="接口$INTERFACE上线了"
	api_post "$text" "$desp_wan" >/dev/null
	
elif [ "$TYPE" == "dhcp" -a "$ACTION" == "add" ]; then
	[ -z "$PARAM3" ] || [ -z "$PARAM4" ] || [ -z "$PARAM5" ] && exit
	t_client_up=`uci -q get serverchan.trigger_message.t_client_up`
	[ "$t_client_up" == "disable" ] && exit
	check_network

	t_client_up_type=`uci -q get serverchan.trigger_message.t_client_up_type`
	is_inwlist=`uci -q get serverchan.trigger_message.t_client_up_whitelist | grep -c "$PARAM3"`
	is_inblist=`uci -q get serverchan.trigger_message.t_client_up_blacklist | grep -c "$PARAM3"`
	if [ "t_client_up_type" == "whitelist" -a "$is_inwlist" -eq 0 ] ||  [ "t_client_up_type" == "blacklist" -a "$is_inblist" -gt 0 ]; then
		if [ "$t_client_up" == "all" ]; then
			desp_client="
**客户端信息**  
|IP地址　|MAC地址　|客户端名 |
| :- | :- | :- |
|$PARAM4　|$PARAM3　|$PARAM5 |
"
			else
				desp_client="
**客户端信息**  
|ip地址　|客户端名 |
| :- | :- |
|$PARAM4　|$PARAM5 |
"
		fi
		text="您有新的客户端接入路由"
		api_post "$text" "$desp_client" >/dev/null		
	fi
		
fi
