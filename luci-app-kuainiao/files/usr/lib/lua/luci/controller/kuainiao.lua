module("luci.controller.kuainiao", package.seeall)

function index()
     require("luci.i18n")
     luci.i18n.loadc("setting")
    local fs = luci.fs or nixio.fs
    if not fs.access("/etc/config/kuainiao") then
		return
	end
	
	
	local page = entry({"admin", "services", "kuainiao"}, cbi("kuainiao"), "迅雷快鸟")
	page.i18n = "kuainiao"
	page.dependent = true
	entry({"admin","services","kuainiao","status"},call("status")).leaf=true
end
function status()
local t=require"luci.sys"
local e=require"luci.http"
local a=require"luci.model.uci".cursor()
local t={
running=(t.call("pgrep /usr/bin/kuainiao > /dev/null")==0),
}
e.prepare_content("application/json")
e.write_json(t)
end
