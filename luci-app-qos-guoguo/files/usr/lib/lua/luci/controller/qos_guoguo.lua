module("luci.controller.qos_guoguo",package.seeall)
function index()
if not nixio.fs.access("/etc/config/qos_guoguo")then
return
end
local e
e=entry({"admin","qos","qos_guoguo"},
alias("admin","qos","qos_guoguo","general"),
_("QoS by GuoGuo"),60)
e=entry({"admin","qos","qos_guoguo","general"},
arcombine(cbi("qos_guoguo/general")),
_("General Settings"),20)
e=entry({"admin","qos","qos_guoguo","upload"},
arcombine(cbi("qos_guoguo/upload")),
_("Upload Settings"),30)
e=entry({"admin","qos","qos_guoguo","download"},
arcombine(cbi("qos_guoguo/download")),
_("Download Settings"),40)
entry({"admin","qos","qos_guoguo","status"},call("status")).leaf=true
end
function status()
local t=require"luci.sys"
local e=require"luci.http"
local a=require"luci.model.uci".cursor()
local t={
running=(t.call("iptables -t mangle -L qos_egress 2> /dev/null")==0),
}
e.prepare_content("application/json")
e.write_json(t)
end
