#!/bin/sh
. /usr/share/libubox/jshn.sh
logger -t Serverchan "Serverchan Monitor is started."
ubus=$(which is ubus)
#dhcp_msg='{ "dhcp.ack": {"mac":"66:24:0c:23:a6:cc","ip":"192.168.2.57","name":"OpenWrt","interface":"br-lan"} }'
$ubus -v subscribe dnsmasq | while read dhcp_msg; 
do
	#cat /root/dnsmasq_msg.log | while read dhcp_msg; do
	json_init
	json_load "$dhcp_msg"
	#json_get_type type "dhcp.ack"
	#case "$type" in
	#       object|array)
	#	       json_select "dhcp.ack"
	#	       json_get_vars mac ip name interface
	#	       echo mac--$mac, ip--$ip, nam--$name, interface--$interface
	#       ;;
	#       *)
	#	       continue
	#
	#       ;;
	#esac
	
	json_select "dhcp.ack" >/dev/null 2>&1 || continue
	json_get_vars mac ip name interface
	/usr/bin/serverchan_trigger dhcp ACK "$mac" "$ip" "$name"
done

