local e=require"nixio.fs"
local e=luci.http
local a,t,e
local router_ip = luci.sys.exec("uci -q get network.lan.ipaddr")
a=Map("easyexplorer",translate("easyexplorer"),translate("EasyExplorer是koolshare小宝开发的，支持跨设备、点对点文件传输同步工具。</br>你需要先到 https://ddns.to 注册，然后在本插件内填入Token和设置本地同步文件夹"))
a.template="easyexplorer/index"
t=a:section(TypedSection,"global",translate("Running Status"))
t.anonymous=true
e=t:option(DummyValue,"_status",translate("Running Status"))
e.template="easyexplorer/dvalue"
e.value=translate("Collecting data...")
t=a:section(TypedSection,"global",translate("全局设置"),translate("设置教程:</font><a style=\"color: #ff0000;\" onclick=\"window.open('http://koolshare.cn/thread-129199-1-1.html')\">点击跳转到论坛教程</a>"))
t.anonymous=true
t.addremove=false
e=t:option(Flag,"enable",translate("启用"))
e.default=0
e.rmempty=false
e=t:option(Value,"start_delay",translate("Delay Start"),translate("Units:seconds"))
e.datatype="uinteger"
e.default="0"
e.rmempty=true
e=t:option(Value,"token",translate('ddnsto Token'))
e.password=true
e.rmempty=false
local devices = {}
nixio.util.consume((nixio.fs.glob("/tmp/mnt/sd?*")), devices)
e=t:option(Value,"folder",translate('本地同步文件夹'))
e.rmempty=false
for i, dev in ipairs(devices) do
        e:value(dev.."/easyexplorer")
end
e=t:option(Value,"folder",translate('本地同步文件夹'))
e.rmempty=false
if(luci.sys.call("pgrep /usr/bin/easyexplorer >/dev/null")==0)then
e=t:option(Button,"Configuration",translate("WEB控制台"))
e.inputtitle=translate("打开网站")
e.inputstyle="reload"
e.write=function()
luci.http.redirect("http:// .. router_ip .. :8899")
end
end
return a
