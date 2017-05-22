#!/bin/sh
#   Samba自动配置脚本，参考PandoraBox的脚本框架并重写。以下为原脚本作者信息：
#===================================================================================
#
#   D-Team Technology Co.,Ltd. ShenZhen
#   作者:Vic
# 
#
# 警告:对着屏幕的哥们,我们允许你使用此脚本，但不允许你抹去作者的信息,请保留这段话。
#===================================================================================
. /lib/functions.sh

set_samba(){
	section=$(echo $get_uuid | sed 's/-//g')

	uci set samba.${section}="sambashare"
	uci set samba.${section}.name="Disk_${device}"
	uci set samba.${section}.path="${mountpoint}"
	uci set samba.${section}.read_only="no"
	uci set samba.${section}.guest_ok="yes"
	uci commit samba
}
set_samba_path(){
	section=$(echo $get_uuid | sed 's/-//g')

	uci set samba.${section}.path="${mountpoint}"
	uci commit samba
}

remove_samba(){
	uci del samba.${s_uuid}
	uci commit samba
}

case "$ACTION" in
	add)
		mounted_device=$(cat /proc/self/mounts | grep "/mnt/sd*" |awk -F ' ' '{print $2}')
		[ -z "$mounted_device" ] && logger -t Auto-Samba "No devices was mounted on this system! Please mount it manually!"
		[ -n "$mounted_device" ] && {
			for mountpoint in $mounted_device
			do
				device=$(echo "$mountpoint" |awk -F'/' '{print $3}')
				get_uuid=`block info | grep -w "$mountpoint" | awk -F "UUID=" '{print $2}'| awk -F "\"" '{print $2}'`
				have_uuid=$(uci show samba | grep -c "$get_uuid")
				[ "$have_uuid" = "0" ] && { 
					set_samba
					logger -t Auto-Samba "The new device /dev/${device} has been shared in $mountpoint ."
				}
				[ "$have_uuid" -gt "0" ] && {
					[ -z "$(uci show samba |grep -w "$mountpoint")" ] && {
						set_samba_path
						logger -t Auto-Samba "The new device /dev/${device} has been shared in $mountpoint ."
					}
				}
				/etc/init.d/samba restart
			done
		}
	;;
	remove)
		sleep 1
		MOUNT=`mount | grep '/mnt/sd*'`
		[ -z "$MOUNT" ] && {
			samba_uuid=$(uci show samba |grep "=sambashare" | awk -F'.' '{print $2}'|awk -F'=' '{print $1}')
			[ -n "$samba_uuid" ] && {
				for s_uuid in $samba_uuid
				do
					remove_samba
					logger -t Auto-Samba "The samba share uuid: $s_uuid has been removed."
					/etc/init.d/samba restart
				done
			}
		}
	;;
esac
