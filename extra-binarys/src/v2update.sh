#!/bin/sh
LOGFILE="/var/log/shadowsocks.log"
LOCK_FILE=/var/lock/v2update.lock
reboot="0"

echo_date(){
	local log=$1
	echo $(date): "$log" >> $LOGFILE
}

set_lock(){
	exec 1000>"$LOCK_FILE"
	flock -x 1000
}

unset_lock(){
	flock -u 1000
	rm -rf "$LOCK_FILE"
}

_exit()
{
    local rc=$1
    unset_lock
    exit ${rc}
}

version=$(cat /etc/openwrt_release 2>/dev/null | grep -w DISTRIB_RELEASE | grep -w "By stones")
version2=$(cat /etc/openwrt_release 2>/dev/null | grep -w DISTRIB_DESCRIPTION | grep -w Koolshare)
[ -z "$version" -a -z "$version2" ] && exit 0

set_lock
echo_date "***********************************"
echo_date "开始检测远程服务器V2Ray最新版本..."
local_version=`/usr/bin/v2ray -version 2>/dev/null | grep V2Ray | awk '{print $2}'`

if [ -n "$local_version" ]; then
	echo_date "本地 V2Ray 客户端版本：$local_version"
else
	local_version="v3.34" && echo_date "未检测到当前固件内 V2Ray 客户端版本!"
fi

latest_version=`curl -S  https://github.com/v2ray/v2ray-core/releases/latest | awk -F"/tag/" '{print $2}' | awk -F"\">" '{print $1}'`
if [ -n "$latest_version" ]; then
	echo_date "远程 V2Ray 最新版本：$latest_version"
else
	echo_date "未检测到远程服务器 V2Ray 客户端最新版本，请稍候重试!" && _exit 0
fi

arch=`uname -m`
if [ "$arch" == "armv7l" ]; then
	s_arch="arm"
elif [ "$arch" == "x86_64" ]; then
	s_arch="64"
	client_arch="amd64"
fi

if [ "$latest_version" != "$local_version" ]; then
	echo_date "开始更新本地 V2Ray 客户端..."
	mkdir -p /tmp/v2ray-linux-$s_arch
	/usr/bin/wget --no-check-certificate --timeout=8 -t 1 https://code.aliyun.com/repobackup/v2core/raw/master/$latest_version/v2ray-linux-$s_arch.zip -O /tmp/v2ray-linux-$s_arch/v2ray-$latest_version-linux-$s_arch.zip
	[ ! -s "/tmp/v2ray-linux-$s_arch/v2ray-$latest_version-linux-$s_arch.zip" ] && \
		/usr/bin/wget --no-check-certificate --timeout=8 -t 2 https://github.com/v2ray/v2ray-core/releases/download/$latest_version/v2ray-linux-$s_arch.zip -O /tmp/v2ray-linux-$s_arch/v2ray-$latest_version-linux-$s_arch.zip
	[ ! -s "/tmp/v2ray-linux-$s_arch/v2ray-$latest_version-linux-$s_arch.zip" ] && echo_date "下载失败，请稍候重试！" && _exit 0
	unzip /tmp/v2ray-linux-$s_arch/v2ray-$latest_version-linux-$s_arch.zip -d /tmp/v2ray-linux-$s_arch
	v2ctl_path=$(find /tmp/v2ray-linux-$s_arch -name v2ctl)
	v2ray_path=$(find /tmp/v2ray-linux-$s_arch -name v2ray)
	if [ -n "$v2ctl_path" ]; then
		mv $v2ctl_path /usr/bin/v2ctl && chmod +x /usr/bin/v2ctl
	fi
	if [ -n "$v2ray_path" ]; then
		mv $v2ray_path /usr/bin/v2ray && chmod +x /usr/bin/v2ray
		if [ "$?" -eq 0 ]; then
			echo_date "==================================="
			echo_date "本地 V2Ray 客户端更新成功"
		else
			echo_date "==================================="
			echo_date "本地 V2Ray 客户端更新失败，请稍候再试！"
			rm -rf /tmp/v2ray-linux-$s_arch
			_exit 0
		fi
	else
		echo_date "==================================="
		echo_date "本地 V2Ray 客户端更新失败，请稍候再试！"
		rm -rf /tmp/v2ray-linux-$s_arch
		_exit 0
	fi

	rm -rf /tmp/v2ray-linux-$s_arch
	reboot="1"
else
	echo_date "==================================="
	echo_date "本地V2Ray客户端已经是最新版本了，无需更新！"
fi

unset_lock

if [ "$reboot" == "1" ];then
	[ -f "/var/lock/shadowsocks.lock" ] && exit 0
	echo_date "自动重启shadowsocks，以应用新的V2Ray客户端！请稍后！"
	/etc/init.d/shadowsocks restart
fi

exit
