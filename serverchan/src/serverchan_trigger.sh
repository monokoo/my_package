#!/bin/sh
#Author: monokoo <realstones2012@gmail.com>

server=http://sc.ftqq.com

version=$(cat /etc/openwrt_release | grep -w DISTRIB_RELEASE | grep -w "By stones")
version2=$(cat /etc/openwrt_release | grep -w DISTRIB_DESCRIPTION | grep -w Koolshare)
[ -z "$version" -a -z "$version2" ] && exit 0

TYPE=$1
ACTION=$2
PARAM3=$3
PARAM4=$4
PARAM5=$5

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

get_client_list(){
	local client_lease_file=/tmp/client_lease_$(echo $PARAM3 | sed 's/://g')
	echo -e "\n"  >$client_lease_file
	if [ "$t_client_up" == "all" ]; then
		echo "|IP地址　|MAC地址　|客户端名 |" >>$client_lease_file
		echo "| :- | :- | :- |" >>$client_lease_file
	else
		echo "|IP地址　|客户端名 |" >>$client_lease_file
		echo "| :- | :- |" >>$client_lease_file
	fi
	all_leases=`cat /tmp/dhcp.leases 2>/dev/null | sed 's/ /+/g'`
	for lease in $all_leases
	do
		lease_mac=`echo $lease | awk -F'+' '{print $2}' | tr '[a-z]' '[A-Z]'`
		lease_ip=`echo $lease | awk -F'+' '{print $3}'`
		lease_hostname=`echo $lease | awk -F'+' '{print $4}'`
		if [ "$t_client_up" == "all" ]; then
			tmp_client="
|$lease_ip　|$lease_mac　|$lease_hostname |
"
		else
			tmp_client="
|$lease_ip　|$lease_hostname |
"
		fi
		echo $tmp_client >>$client_lease_file
	done
	echo "****"  >>$client_lease_file
	lease_client=$(cat $client_lease_file)
	rm -rf $client_lease_file
	echo -n "$lease_client"

}

enabled=`uci -q get serverchan.global.enabled`
sckey=`uci -q get serverchan.global.sckey`
[ "$enabled" -gt 0 ] && [ -n "$sckey" ] || exit 0
check_network
if [ "$TYPE" == "iface" -a "$ACTION" == "ifup" ]; then
	INTERFACE=$PARAM3
	DEVICE=$PARAM4
	[ -z "$INTERFACE" ] || [ -z "$DEVICE" ] && exit 0
	t_redial=`uci -q get serverchan.trigger_message.t_redial`
	[ "$t_redial" -eq 1 ] || exit 0
	nowtime=`date '+%Y-%m-%d %H:%M:%S'`
	publicip=`curl -s --interface $DEVICE http://members.3322.org/dyndns/getip 2>/dev/null` || publicip=`curl -s --interface $DEVICE http://1212.ip138.com/ic.asp 2>/dev/null | grep -Eo '([0-9]+\.){3}[0-9]+'`
	[ -z "$publicip" ] && publicip="暂时无法获取公网IP"
	wanip=$(ifconfig $DEVICE 2>/dev/null | grep "inet addr:" | grep -E -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"|head -1)
	desp_wan="
****
**上线时间：**$nowtime  
****
**$INTERFACE信息：**

$INTERFACE 公网IP: $publicip

$INTERFACE 接口IP: $wanip
"
	text="路由$(uname -n)--接口$INTERFACE上线啦"
	api_post "$text" "$desp_wan" >/dev/null
	
elif [ "$TYPE" == "dhcp" ]; then
	[ -z "$PARAM3" ] || [ -z "$PARAM4" ] || [ -z "$PARAM5" ] && exit 0
	[ "$ACTION" == "update" ] && {
		is_newonline=`logread -l 30 | grep "DHCPACK(br-lan)" | grep -w "$PARAM3"`
		[ -z "$is_newonline" ] && exit 0
	}
	t_client_up=`uci -q get serverchan.trigger_message.t_client_up`
	[ "$t_client_up" == "disable" ] && exit 0
	nowtime=`date '+%Y-%m-%d %H:%M:%S'`
	t_client_up_type=`uci -q get serverchan.trigger_message.t_client_up_type`
	upper_PARAM3=`echo $PARAM3 | tr '[a-z]' '[A-Z]'`
	is_inwlist=`uci -q get serverchan.trigger_message.t_client_up_whitelist | grep -c "$upper_PARAM3"`
	is_inblist=`uci -q get serverchan.trigger_message.t_client_up_blacklist | grep -c "$upper_PARAM3"`
	if [ "$t_client_up_type" == "whitelist" -a "$is_inwlist" -eq 0 ] ||  [ "$t_client_up_type" == "blacklist" -a "$is_inblist" -gt 0 ]; then
		temp_lease_time_remaining=`cat /tmp/dhcp.leases 2>/dev/null | grep -w "$PARAM3" |awk '{print $1}'`
		lease_time_remaining=`date -d @$temp_lease_time_remaining  "+%Y-%m-%d %H:%M:%S"`
		if [ "$t_client_up" == "all" ]; then
			desp_header="
**有新的客户端加入$(uname -n)网络，信息如下：**  
****
客户端名：$PARAM5  
客户端IP：$PARAM4  
客户端MAC：$upper_PARAM3  
客户端上线时间：$nowtime  
租约过期的时间：$lease_time_remaining
****
**现在租约期内的客户端共有：$(cat /tmp/dhcp.leases 2>/dev/null |wc -l)个，具体如下：**  
"
			else
				desp_header="
**有新的客户端加入$(uname -n)网络，信息如下：**  
****
客户端名：$PARAM5  
客户端IP：$PARAM4  
客户端上线时间：$nowtime  
租约过期的时间：$lease_time_remaining
****
**现在租约期内的客户端共有：$(cat /tmp/dhcp.leases 2>/dev/null |wc -l)个，具体如下：**  
"
		fi
		text="您有新的客户端接入路由"
		lease_client=`get_client_list`
		desp_client=$desp_header$lease_client
		api_post "$text" "$desp_client" >/dev/null
	fi
		
fi
