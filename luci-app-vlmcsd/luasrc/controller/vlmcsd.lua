--[[
openwrt-dist-luci: ShadowSocks
]]--

module("luci.controller.vlmcsd", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/vlmcsd") then
		return
	end
	
	entry({"admin", "services", "vlmcsd"}, cbi("vlmcsd"), _("KMS服务器")).dependent = true
	entry({"admin","services","vlmcsd","status"},call("act_status")).leaf=true
end
function act_status()
local e={}
e.vlmcsd=luci.sys.call("pgrep /usr/bin/vlmcsd >/dev/null")==0
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
