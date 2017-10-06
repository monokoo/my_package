#!/bin/sh
LOGFILE="/var/log/shadowsocks.log"
reboot="0"

echo_date(){
	local log=$1
	echo $(date): "$log" >> $LOGFILE
}

version=$(cat /etc/openwrt_release | grep -w DISTRIB_RELEASE | grep -w "By stones")
[ -z "$version" ] && exit 0

echo_date "***********************************"
echo_date "开始检测远程服务器最新版本..."
local_version=`/usr/bin/kcpclient -v | awk '{print $3}'`

if [ -n "$local_version" ]; then
	echo_date "本地 KCP 客户端版本：v$local_version"
else
	local_version="20170000" && echo_date "未检测到当前固件内 KCP 客户端版本!"
fi

latest_version=`curl -S  https://github.com/xtaci/kcptun/releases/latest | awk -F"/tag/v" '{print $2}' | awk -F"\">" '{print $1}'`
if [ -n "$latest_version" ]; then
	echo_date "服务器 KCP 最新版本：v$latest_version"
else
	echo_date "未检测到远程服务器 KCP 客户端最新版本，请稍候重试!" && exit 0
fi
if [ "$latest_version" != "$local_version" ]; then
	echo_date "开始更新本地 KCP 客户端..."
	mkdir -p /tmp/kcptun-linux-arm
	/usr/bin/wget --no-check-certificate --timeout=8 -t 2 https://github.com/xtaci/kcptun/releases/download/v$latest_version/kcptun-linux-arm-$latest_version.tar.gz -O /tmp/kcptun-linux-arm/kcptun-linux-arm-$latest_version.tar.gz
	[ ! -s "/tmp/kcptun-linux-arm/kcptun-linux-arm-$latest_version.tar.gz" ] && echo_date "下载失败，请稍候重试！" && exit 0
	tar -xf /tmp/kcptun-linux-arm/kcptun-linux-arm-$latest_version.tar.gz -C /tmp/kcptun-linux-arm
	mv /tmp/kcptun-linux-arm/client_linux_arm5 /usr/bin/kcpclient && chmod +x /usr/bin/kcpclient && {
		echo_date "==================================="
		echo_date "本地 KCP 客户端更新成功"
	}
	rm -rf /tmp/kcptun-linux-arm
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
