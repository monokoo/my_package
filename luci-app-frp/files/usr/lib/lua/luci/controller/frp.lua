-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.frp", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/frp") then
		return
	end

	local page

	page = entry({"admin", "services", "frp"}, cbi("frp/frp"), _("Frp Setting"),3)
	page.dependent = true
	entry({"admin","services","frp","config"},cbi("frp/config")).leaf=true
	entry({"admin","services","frp","status"},call("status")).leaf=true
end
function status()
local t=require"luci.sys"
local e=require"luci.http"
local a=require"luci.model.uci".cursor()
local t={
running=(t.call("pidof frpc > /dev/null")==0),
}
e.prepare_content("application/json")
e.write_json(t)
end
