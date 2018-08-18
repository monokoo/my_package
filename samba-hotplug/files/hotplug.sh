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
	section=$get_uuid

	uci set samba4.${section}="sambashare"
	uci set samba4.${section}.name="Disk_${device}"
	uci set samba4.${section}.path="${mountpoint}"
	uci set samba4.${section}.create_mask="0777"
	uci set samba4.${section}.dir_mask="0777"
	uci set samba4.${section}.read_only="no"
	uci set samba4.${section}.guest_ok="yes"
	uci commit samba4
}
set_samba_path(){
	section=$get_uuid

	uci set samba4.${section}.path="${mountpoint}"
	uci commit samba4
}

del_sambadir(){
	mountdir=$(uci -q get samba4.${s_uuid}.path)
	[ -z "`mount | grep '$mountdir'`" ] && {
		#[ -d "$mountdir" ] && [ -z "`ls $mountdir`" ] && rm -rf $mountdir
		uci del samba4.${s_uuid}
		uci commit samba4
		logger -t Auto-Samba "The unused samba share uuid: $s_uuid has been removed."
	}
}

remove_samba(){
	samba_uuid=$(uci show samba4 |grep "=sambashare" | awk -F'.' '{print $2}'|awk -F'=' '{print $1}')
	[ -n "$samba_uuid" ] && {
		for s_uuid in $samba_uuid
		do
			[ -n `cat /proc/self/mounts | grep -w "$(uci -q get samba4.${s_uuid}.path)"` ] && continue
			del_sambadir
			/etc/init.d/samba4 restart
		done
	}
}

countdev=$(ls /dev/sd* |grep -c $DEVNAME)
alldev=$(ls /dev/sd* | wc -l)

[ "$countdev" -gt 0 ] && ([ "$alldev" == "1" ] || ([ "$alldev" -gt 1 ] && [ "$countdev" -lt "$alldev" ])) || exit 1

device=$DEVNAME
case "$ACTION" in
	add)
		mountpoint=$(cat /proc/self/mounts | grep -w "/dev/$device" |awk -F' ' '{print $2}')
		[ -z "$mountpoint" ] && logger -t Auto-Samba "No devices was mounted on this system! Please mount it manually!"
		[ -n "$mountpoint" ] && {
			get_uuid=`block info | grep -w "/dev/$device" | awk -F "UUID=" '{print $2}' | awk -F "\"" '{print $2}' | sed 's/-//g'`
			[ -z "$get_uuid" ] && get_uuid=`blkid  /dev/$device | awk -F "UUID=" '{print $2}' | awk -F "\"" '{print $2}' | sed 's/-//g'`
			[ -z "$get_uuid" ] && logger -t Auto-Samba "The new device /dev/${device} has no uuid!" && exit 1
			have_uuid=$(uci show samba4 | grep -c "${get_uuid}=sambashare")
			[ "$have_uuid" = "0" ] && {
				#remove_samba
				set_samba
				logger -t Auto-Samba "The new device /dev/${device} has been shared in $mountpoint ."
			}
			[ "$have_uuid" = "1" ] && {
				[ "$(uci -q get samba4.${get_uuid}.path)" != "$mountpoint" ] && {
					set_samba_path
					logger -t Auto-Samba "The new device /dev/${device} has been shared in $mountpoint ."
				}
			}
			/etc/init.d/samba4 restart
		}
	;;
	remove)
		# sleep 1s
		# remove_samba
	;;
esac
