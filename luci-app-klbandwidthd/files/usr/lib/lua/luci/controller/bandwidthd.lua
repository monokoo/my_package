module("luci.controller.bandwidthd", package.seeall)
function index()
        if not nixio.fs.access("/etc/config/bandwidthd") then
                return
        end
        entry({"admin", "status", "traffic"}, cbi("bandwidthd"), _("Traffic Statistics"),13).dependent = true
		entry({"admin","status","traffic","status"},call("status")).leaf=true
end
function status()
local t=require"luci.sys"
local e=require"luci.http"
local a=require"luci.model.uci".cursor()
local t={
running=(t.call("pgrep /usr/sbin/bandwidthd > /dev/null")==0),
}
e.prepare_content("application/json")
e.write_json(t)
end