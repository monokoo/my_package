module("luci.controller.qosv4",package.seeall)
function index()
if nixio.fs.access("/etc/config/qosv4")then
local e
e=entry({"admin","qos","qosv4"},cbi("qosv4"),_("QOSv4"),55)
e.i18n="qosv4"
e.dependent=true
end
entry({"admin","qos","qosv4","qosv4ip"},cbi("qosv4ip"),nil).leaf=true
end
