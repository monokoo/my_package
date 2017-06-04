module("luci.controller.qos-emong",package.seeall)
function index()
if nixio.fs.access("/etc/config/qos-emong")then
local e
e=entry({"admin","qos","qos-emong"},cbi("qos-emong"),_("Emong's QOS"),55)
e.i18n="qos-emong"
e.dependent=true
end
end
