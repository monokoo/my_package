module("luci.controller.homekit",package.seeall)
function index()
if not nixio.fs.access("/etc/config/homekit")then
return
end
entry({"admin","services","homekit"},cbi("homekit/global"),_("homekit"),7).dependent=true
entry({"admin","services","homekit","status"},call("act_status")).leaf=true
end
function act_status()
local e={}
e.homekit=luci.sys.call("pidof %s >/dev/null"%"PHK")==0
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
