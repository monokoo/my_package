#!/bin/sh
LOGFILE="/var/log/shadowsocks.log"
reboot="0"

echo_date(){
	local log=$1
	echo $(date): "$log" >> $LOGFILE
}

version=$(cat /etc/openwrt_release 2>/dev/null | grep -w DISTRIB_RELEASE | grep -w "By stones")
version2=$(cat /etc/openwrt_release 2>/dev/null | grep -w DISTRIB_DESCRIPTION | grep -w Koolshare)
[ -z "$version" -a -z "$version2" ] && exit 0

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
	echo_date "服务器 V2Ray 最新版本：$latest_version"
else
	echo_date "未检测到远程服务器 V2Ray 客户端最新版本，请稍候重试!" && exit 0
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
	/usr/bin/wget --no-check-certificate --timeout=8 -t 2 https://github.com/v2ray/v2ray-core/releases/download/$latest_version/v2ray-linux-$s_arch.zip -O /tmp/v2ray-linux-$s_arch/v2ray-$latest_version-linux-$s_arch.zip
	[ ! -s "/tmp/v2ray-linux-$s_arch/v2ray-$latest_version-linux-$s_arch.zip" ] && echo_date "下载失败，请稍候重试！" && exit 0
	unzip /tmp/v2ray-linux-$s_arch/v2ray-$latest_version-linux-$s_arch.zip -d /tmp/v2ray-linux-$s_arch
	mv /tmp/v2ray-linux-$s_arch/v2ray-$latest_version-linux-$s_arch/v2ctl /usr/bin/v2ctl && chmod +x /usr/bin/v2ctl
	mv /tmp/v2ray-linux-$s_arch/v2ray-$latest_version-linux-$s_arch/v2ray /usr/bin/v2ray && chmod +x /usr/bin/v2ray && {
		echo_date "==================================="
		echo_date "本地 V2Ray 客户端更新成功"
	}
	rm -rf /tmp/v2ray-linux-$s_arch
	reboot="1"
else
	echo_date "==================================="
	echo_date "本地客户端已经是最新版本了，无需更新！"
fi

if [ "$reboot" == "1" ];then
	echo_date "自动重启shadowsocks，以应用新的客户端！请稍后！"
	/etc/init.d/shadowsocks restart
fi

exit
