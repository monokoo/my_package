module("luci.controller.wrtbwmon", package.seeall)

function index()
	entry({"admin", "status", "nlbw", "usage"},alias("admin", "status", "nlbw", "usage", "details"),_("Traffic Status"), 60)
	entry({"admin", "status", "nlbw", "usage", "details"},template("wrtbwmon"),_("Details"), 10).leaf=true
	entry({"admin", "status", "nlbw", "usage", "config"},arcombine(cbi("wrtbwmon/config")),_("Configuration"), 20).leaf=true
	entry({"admin", "status", "nlbw", "usage", "custom"},form("wrtbwmon/custom"),_("User file"), 30).leaf=true
end
