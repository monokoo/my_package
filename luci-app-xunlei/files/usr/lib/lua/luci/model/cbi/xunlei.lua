local fs = require "nixio.fs"
local util = require "nixio.util"
local running=(luci.sys.call("pidof EmbedThunderManager > /dev/null") == 0)
local button=""
local xunleiinfo=""
local tblXLInfo={}
local detailInfo = "<br />启动后会看到类似如下信息：<br /><br />[ 0, 1, 1, 0, “7DHS94”,1, “201_2.1.3.121”, “shdixang”, 1 ]<br /><br />其中有用的几项为：<br /><br />第一项： 0表示返回结果成功；<br /><br />第二项： 1表示检测网络正常，0表示检测网络异常；<br /><br />第四项： 1表示已绑定成功，0表示未绑定；<br /><br />第五项： 未绑定的情况下，为绑定的需要的激活码；<br /><br />第六项： 1表示磁盘挂载检测成功，0表示磁盘挂载检测失败。"
if running then
	xunleiinfo = luci.sys.exec("wget http://localhost:9000/getsysinfo -O - 2>/dev/null")
    button = "</br>" .. translate("运行状态：") .. xunleiinfo
	string.gsub(string.sub(xunleiinfo, 2, -2),'[^,]+',function(w) table.insert(tblXLInfo, w) end)
	
	detailInfo = [[<p style="color:blue">启动信息：]] .. xunleiinfo .. [[</p>]]
	if tonumber(tblXLInfo[1]) == 0 then
	  detailInfo = detailInfo .. [[<p style="color:green">状态正常</p>]]
	else
	  detailInfo = detailInfo .. [[<p style="color:red">执行异常</p>]]
	end
	
	if tonumber(tblXLInfo[2]) == 0 then
	  detailInfo = detailInfo .. [[<p style="color:red">网络异常</p>]]
	else
	  detailInfo = detailInfo .. [[<p style="color:green">网络正常</p>]]
	end
	
	if tonumber(tblXLInfo[4]) == 0 then
	  detailInfo = detailInfo .. [[<p style="color:red">未绑定]].. [[&nbsp;&nbsp;激活码：]].. tblXLInfo[5] ..[[</p>]]	  
	else
	  detailInfo = detailInfo .. [[<p style="color:green">已绑定</p>]]
	end

	if tonumber(tblXLInfo[6]) == 0 then
	  detailInfo = detailInfo .. [[<p style="color:red">磁盘挂载检测失败</p>]]
	else
	  detailInfo = detailInfo .. [[<p style="color:green">磁盘挂载检测成功</p>]]
	end	
end

-----------
--Xware--
-----------
m = Map("xunlei", translate("Xware"), translate("迅雷远程下载"))
m:section(SimpleSection).template="xunlei_status"
s = m:section(TypedSection, "xunlei", translate("Xware 设置"),translate("第一次启动将下载迅雷启动程序，时间稍长，请稍安勿躁...</br><font color=\"red\">如果下载到错误版本，请手动删除\"/etc/xware/xlfile\"文件。</font>"))
s.anonymous = true
s:tab("basic",  translate("Settings"))
enable = s:taboption("basic", Flag, "enable", translate("启用 迅雷远程下载"))
enable.rmempty = false

local devices = {}
util.consume((fs.glob("/mnt/sd?*")), devices)
device = s:taboption("basic", Value, "device", translate("挂载点"), translate("迅雷程序下载目录所在的“挂载点”。"))
for i, dev in ipairs(devices) do
        device:value(dev)
end

file = s:taboption("basic", Value, "file", translate("迅雷程序安装目录"), translate("迅雷程序将安装在：“挂载点”/xunlei。例如：“迅雷下载目录”为 /mnt/sda1，迅雷就会安装在 /mnt/sda1/xunlei 下。"))
for i, dev in ipairs(devices) do
        file:value(dev)
end
if fs.access("/etc/config/xunlei") then
	file.titleref = luci.dispatcher.build_url("admin", "system", "fstab")
end

if fs.access("/etc/xware/version") then
upinfo = luci.sys.exec("cat /etc/xware/version")
else
upinfo = "<font color=\"red\">暂未安装</font>"
end
op = s:taboption("basic", Button, "upxlast", translate("重新下载"),translate("<strong><font color=\"red\">当前版本：</font></strong>") .. upinfo)
op.inputstyle = "apply"
op.write = function(self, section)
	opstatus = (luci.sys.exec("/etc/xware/xlup" %{ self.option }) == 0)
	if  opstatus then
	self.inputstyle = "apply"
	end
luci.model.uci.cursor()
end
vod = s:taboption("basic", Flag, "vod", translate("删除迅雷VOD服务器"), translate("删除迅雷VOD服务器。"))
vod.rmempty = false

if not fs.access("/etc/xware/xlfile") then
zurl = s:taboption("basic", Value, "url", translate("地址"), translate("自定义迅雷远程下载地址。默认：https://github.com/monokoo/Xware/raw/master/software"))
zurl.rmempty = false
zurl:value("https://github.com/monokoo/Xware/raw/master/software")
xwareup = s:taboption("basic", Value, "xware", translate("Xware 程序版本："),translate("<br />ARM系列的选择默认版本，其他型号的路由根据CPU选择。"))
xwareup.rmempty = false
xwareup:value("Xware1.0.31_mipseb_32_uclibc.zip", translate("Xware1.0.31_mipseb_32_uclibc.zip"))
xwareup:value("Xware1.0.31_mipsel_32_uclibc.zip", translate("Xware1.0.31_mipsel_32_uclibc.zip"))
xwareup:value("Xware1.0.31_x86_32_glibc.zip", translate("Xware1.0.31_x86_32_glibc.zip"))
xwareup:value("Xware1.0.31_x86_32_uclibc.zip", translate("Xware1.0.31_x86_32_uclibc.zip"))
xwareup:value("Xware1.0.31_pogoplug.zip", translate("Xware1.0.31_pogoplug.zip"))
xwareup:value("Xware1.0.31_armeb_v6j_uclibc.zip", translate("Xware1.0.31_armeb_v6j_uclibc.zip"))
xwareup:value("Xware1.0.31_armeb_v7a_uclibc.zip", translate("Xware1.0.31_armeb_v7a_uclibc.zip"))
xwareup:value("Xware1.0.31_armel_v5t_uclibc.zip", translate("Xware1.0.31_armel_v5t_uclibc.zip"))
xwareup:value("Xware1.0.31_armel_v5te_android.zip", translate("Xware1.0.31_armel_v5te_android.zip"))
xwareup:value("Xware1.0.31_armel_v5te_glibc.zip", translate("Xware1.0.31_armel_v5te_glibc.zip"))
xwareup:value("Xware1.0.31_armel_v6j_uclibc.zip", translate("Xware1.0.31_armel_v6j_uclibc.zip"))
xwareup:value("Xware1.0.31_armel_v7a_uclibc.zip", translate("Xware1.0.31_armel_v7a_uclibc.zip"))
xwareup:value("Xware1.0.31_asus_rt_ac56u.zip", translate("Xware1.0.31_asus_rt_ac56u.zip"))
xwareup:value("Xware1.0.31_cubieboard.zip", translate("Xware1.0.31_cubieboard.zip"))
xwareup:value("Xware1.0.31_iomega_cloud.zip", translate("Xware1.0.31_iomega_cloud.zip"))
xwareup:value("Xware1.0.31_my_book_live.zip", translate("Xware1.0.31_my_book_live.zip"))
xwareup:value("Xware1.0.31_netgear_6300v2.zip", translate("Xware1.0.31_netgear_6300v2.zip"))
end
s:taboption("basic", DummyValue,"opennewwindow" ,translate("<br /><p align=\"justify\"><script type=\"text/javascript\"></script><input type=\"button\" class=\"cbi-button cbi-button-apply\" value=\"获取启动信息\" onclick=\"window.open('http://'+window.location.host+':9000/getsysinfo')\" /></p>"), detailInfo)
s:taboption("basic", DummyValue,"opennewwindow" ,translate("<br /><p align=\"justify\"><script type=\"text/javascript\"></script><input type=\"button\" class=\"cbi-button cbi-button-apply\" value=\"迅雷远程下载页面\" onclick=\"window.open('http://yuancheng.xunlei.com')\" /></p>"), translate("将激活码填进网页即可绑定。"))
s:taboption("basic", DummyValue,"opennewwindow" ,translate("<br /><p align=\"justify\"><script type=\"text/javascript\"></script><input type=\"button\" class=\"cbi-button cbi-button-apply\" value=\"迅雷论坛\" onclick=\"window.open('http://luyou.xunlei.com/forum-51-1.html')\" /></p>"))
s:tab("editconf_mounts", translate("挂载点配置"))
editconf_mounts = s:taboption("editconf_mounts", TextValue, "_editconf_mounts")
editconf_mounts.description=translate("一般情况下只需填写你的挂载点目录即可，注释用 #")
editconf_mounts.template = "cbi/tvalue"
editconf_mounts.rows = 20
editconf_mounts.wrap = "off"
function editconf_mounts.cfgvalue(self, section)

	return fs.readfile("/tmp/etc/thunder_mounts.cfg") or ""
end
function editconf_mounts.write(self, section, value1)
	if value1 then
		value1 = value1:gsub("\r\n?", "\n")
		fs.writefile("/tmp/thunder_mounts.cfg", value1)
		if (luci.sys.call("cmp -s /tmp/thunder_mounts.cfg /tmp/etc/thunder_mounts.cfg") == 1) then
			fs.writefile("/tmp/etc/thunder_mounts.cfg", value1)
		end
		fs.remove("/tmp/thunder_mounts.cfg")
	end
end
s:tab("editconf_etm", translate("Xware 配置"))
editconf_etm = s:taboption("editconf_etm", TextValue, "_editconf_etm")
editconf_etm.description=translate("注释用“ ; ”")
editconf_etm.template = "cbi/tvalue"
editconf_etm.rows = 20
editconf_etm.wrap = "off"
function editconf_etm.cfgvalue(self, section)
	return fs.readfile("/tmp/etc/etm.cfg") or ""
end
function editconf_etm.write(self, section, value2)
	if value2 then
		value2 = value2:gsub("\r\n?", "\n")
		fs.writefile("/tmp/etm.cfg", value2)
		if (luci.sys.call("cmp -s /tmp/etm.cfg /tmp/etc/etm.cfg") == 1) then
			fs.writefile("/tmp/etc/etm.cfg", value2)
		end
		fs.remove("/tmp/etm.cfg")
	end
end
s:tab("editconf_download", translate("下载配置"))
editconf_download = s:taboption("editconf_download", TextValue, "_editconf_download")
editconf_download.description=translate("注释用“ ; ”")
editconf_download.template = "cbi/tvalue"
editconf_download.rows = 20
editconf_download.wrap = "off"
function editconf_download.cfgvalue(self, section)
	return fs.readfile("/tmp/etc/download.cfg") or ""
end
function editconf_download.write(self, section, value3)
	if value3 then
		value3 = value3:gsub("\r\n?", "\n")
		fs.writefile("/tmp/download.cfg", value3)
		if (luci.sys.call("cmp -s /tmp/download.cfg /tmp/etc/download.cfg") == 1) then
			fs.writefile("/tmp/etc/download.cfg", value3)
		end
		fs.remove("/tmp/download.cfg")
	end
end
return m
