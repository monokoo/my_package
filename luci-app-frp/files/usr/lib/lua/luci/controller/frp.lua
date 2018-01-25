module("luci.controller.frp", package.seeall)
local uci = require "luci.model.uci".cursor()

function index()
	if not nixio.fs.access("/etc/config/frp") then
		return
	end

	entry({"admin","services","frp"},cbi("frp/frp"), _("Frp Setting"),5).dependent=true
	entry({"admin","services","frp","config"},cbi("frp/config")).leaf=true
	entry({"admin","services","frp","status"},call("status")).leaf=true
end

function status()
local e={}
e.running=luci.sys.call("pidof frpc > /dev/null")==0
local admin_addr=uci.get("frp","common","admin_addr")
if admin_addr and admin_addr ~= "127.0.0.1" then
	e.frp_addr="running"
end 
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
