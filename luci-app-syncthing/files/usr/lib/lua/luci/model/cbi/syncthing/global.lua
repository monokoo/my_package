local o=require"nixio.fs"
local util = require "nixio.util"
local e=luci.http
local a,t,e
a=Map("syncthing",translate("Syncthing"),translate("Syncthing replaces proprietary sync and cloud services with something open"))
a.template="syncthing/index"
t=a:section(TypedSection,"syncthing",translate("Running Status"))
t.anonymous=true
e=t:option(DummyValue,"_status",translate("Running Status"))
e.template="syncthing/dvalue"
e.value=translate("Collecting data...")
t=a:section(TypedSection,"syncthing",translate("Global Setting"))
t.anonymous=true
t.addremove=false
e=t:option(Flag,"enable",translate("Enable"))
e.default=0
e.rmempty=false
e=t:option(Flag,"wan_enable",translate("Wan Enable"))
e.default=0
e.rmempty=false
local devices = {}
util.consume((o.glob("/tmp/mnt/sd?*")), devices)
e=t:option(Value,"sharepath",translate('Default Path'))
for i, dev in ipairs(devices) do
        e:value(dev.."/Sync")
end
e.rmempty=false
e=t:option(Value,"port",translate('Port'))
e.default="8383"
e.rmempty=false
local i=uci.get("syncthing","global","port")
local n=uci.get("network","lan","ipaddr")
if nixio.fs.access("/usr/share/syncthing/config")then
e=t:option(Button,"Configuration",translate("Configuration"))
e.inputtitle=translate("Program Configuration")
e.inputstyle="reload"
e.write=function()
luci.http.redirect("http://"..n..":"..i)
end
end
t=a:section(TypedSection,"syncthing",translate("Log View"))
t.anonymous=true
t.addremove=false
local i="/var/log/syncthing.log"
e=t:option(TextValue,"configfile")
e.description=translate("syncthing Logs")
e.rows=22
e.wrap="off"
e.cfgvalue=function(t,t)
return o.readfile(i)or""
end
e.write=function(e,e,e)
end
return a
