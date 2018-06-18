module("luci.controller.easyexplorer",package.seeall)
function index()
if not nixio.fs.access("/etc/config/easyexplorer")then
return
end
entry({"admin","services","easyexplorer"},cbi("easyexplorer/global"),_("EasyExplorer"),7).dependent=true
entry({"admin","services","easyexplorer","status"},call("act_status")).leaf=true
end
function act_status()
local e={}
e.easyexplorer=luci.sys.call("pgrep /usr/bin/easyexplorer >/dev/null")==0
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
