#!/bin/sh

wan_enable=$1
syncthing_port=$2
CONPATH=$3
LOGFILE=$4
sharepath=$5

lanip=$(uci get network.lan.ipaddr)

[ ! -f "$CONPATH/config.xml" ] && /usr/share/syncthing/syncthing -generate="$CONPATH" > $LOGFILE

input_linenum=$(iptables -nL zone_wan_input --line-number | grep "allow syncthing port access" | awk '{print $1}')
forward_linenum=$(iptables -nL zone_wan_forward --line-number | grep "allow syncthing port access" | awk '{print $1}')
forwarding_linenum=$(iptables -nL forwarding_rule --line-number | grep "allow syncthing port access" | awk '{print $1}')
[ -n "$input_linenum" ] && iptables -D zone_wan_input $input_linenum
[ -n "$forward_linenum" ] && iptables -D zone_wan_forward $forward_linenum
[ -n "$forwarding_linenum" ] && iptables -D forwarding_rule $forwarding_linenum

if [ "$wan_enable" == 1 ];then
	iptables -I zone_wan_input 2 -p tcp --dport $syncthing_port -m comment --comment "allow syncthing port access" -j ACCEPT
	iptables -I zone_wan_forward 2 -p tcp --dport $syncthing_port -m comment --comment "allow syncthing port access" -j zone_lan_dest_ACCEPT
	iptables -A forwarding_rule -p tcp --dport $syncthing_port -m comment --comment "allow syncthing port access" -j ACCEPT
	[ -f "$CONPATH/config.xml" ] && {
		sed -i "s/<address>[0-9].*<\/address>/<address>0.0.0.0:${syncthing_port}<\/address>/" $CONPATH/config.xml
	}
else
	iptables -I zone_wan_forward 2 -p tcp --dport $syncthing_port -m comment --comment "allow syncthing port access"  -j zone_lan_dest_ACCEPT
	[ -f "$CONPATH/config.xml" ] && {
		sed -i "s/<address>[0-9].*<\/address>/<address>${lanip}:${syncthing_port}<\/address>/" $CONPATH/config.xml
	}
fi
[ -f "$CONPATH/config.xml" ] && {
	sed -i "s#path=".*/"#path=\"$sharepath/#" $CONPATH/config.xml
	sed -i "s/<localAnnounceMCAddr>\[ff12::.*\]/<localAnnounceMCAddr>\[ff12::${syncthing_port}\]/" $CONPATH/config.xml
}
