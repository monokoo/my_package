local i=require"nixio.fs"
local e=require"luci.dispatcher"
local e=require("luci.model.ipkg")
local e=luci.model.uci.cursor()
local e=require"luci.sys"
local e=luci.http
local o="homekit"
local a,t,e
a=Map(o,translate("homekit"),translate("With the Home app, you can easily and securely control all your HomeKit accessories. Ask Siri to turn off the lights from your iPhone."))
a.template="homekit/index"
t=a:section(TypedSection,"global",translate("Running Status"))
t.anonymous=true
e=t:option(DummyValue,"_status",translate("Running Status"))
e.template="homekit/dvalue"
e.value=translate("Collecting data...")
t=a:section(TypedSection,"global",translate("Global Setting"))
t.anonymous=true
e=t:option(Flag,"enabled",translate("Enable"))
e.default=0
e.rmempty=false
t=a:section(TypedSection,"global",translate("Matching Information"))
t.anonymous=true
e=t:option(DummyValue,"mpasswd",translate("</label><div align=\"left\">Pairing Password:<strong><font color=\"#660099\">98756432</font></strong></div>"))
if nixio.fs.access("/etc/homekit")then
e=t:option(DummyValue,"c2status",translate("<div align=\"left\">Reassign</div>"))
e=t:option(Button,"Reassign")
e.inputtitle=translate("Reassign the device")
e.inputstyle="reload"
e.write=function()
luci.sys.call("rm /etc/homekit && /etc/init.d/homekit restart")
luci.http.redirect(luci.dispatcher.build_url("admin","services","homekit"))
end
end
t=a:section(TypedSection,"global",translate("Homekit Logs"))
t.anonymous=true
e=t:option(TextValue,"log")
e.rows=20
e.wrap="on"
e.readonly=true
e.cfgvalue=function(t,t)
return i.readfile("/var/log/homekit.log")or""
end
e.write=function(e,e,e)
end
return a
