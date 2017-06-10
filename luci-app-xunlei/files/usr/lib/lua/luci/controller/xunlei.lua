
module("luci.controller.xunlei", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/xunlei") then
		return
	end
	local page
	page = entry({"admin", "services", "xunlei"}, cbi("xunlei"), _("迅雷远程下载"),6)
	page.i18n = "xunlei"
	page.dependent = true
	entry({"admin","services","xunlei","status"},call("status")).leaf=true
end
function status()
local t=require"luci.sys"
local e=require"luci.http"
local a=require"luci.model.uci".cursor()
local t={
running=(t.call("pidof EmbedThunderManager > /dev/null")==0),
}
e.prepare_content("application/json")
e.write_json(t)
end