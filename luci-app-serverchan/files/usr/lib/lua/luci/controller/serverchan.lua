module("luci.controller.serverchan",package.seeall)
function index()
if not nixio.fs.access("/etc/config/serverchan")then
return
end
entry({"admin","services","serverchan"},cbi("serverchan"),_("ServerChan"),4).dependent=true
end
