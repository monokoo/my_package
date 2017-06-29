--[[
LuCI - Lua Configuration Interface - aria2 support

Copyright 2014 nanpuyue <nanpuyue@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0
]]--

module("luci.controller.ngrokc", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ngrokc") then
		return
	end

	entry({"admin", "services", "ngrokc"}, cbi("ngrokc/overview"), _("Ngrok Settings"),6).dependent = true
	entry({"admin", "services", "ngrokc", "detail"}, cbi("ngrokc/detail"), nil ).leaf = true
	entry({"admin","services","ngrokc","status"},call("status")).leaf=true
end
function status()
local t=require"luci.sys"
local e=require"luci.http"
local a=require"luci.model.uci".cursor()
local t={
running=(t.call("pgrep /usr/bin/ngrokc > /dev/null")==0),
}
e.prepare_content("application/json")
e.write_json(t)
end