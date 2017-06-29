module("luci.controller.syncthing",package.seeall)
function index()
if not nixio.fs.access("/etc/config/syncthing")then
return
end
entry({"admin","services","syncthing"},cbi("syncthing/global"),_("syncthing"),4).dependent=true
entry({"admin","services","syncthing","status"},call("act_status")).leaf=true
end
function act_status()
local e={}
e.syncthing=luci.sys.call("pgrep %s >/dev/null"%"/usr/share/syncthing/syncthing")==0
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
