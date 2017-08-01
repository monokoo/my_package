--Alex<1886090@gmail.com>


local state_msg = "" 


local bandwidthd_on = (luci.sys.call("pgrep /usr/sbin/bandwidthd > /dev/null") == 0)
local router_ip = luci.sys.exec("uci -q get network.lan.ipaddr")

if bandwidthd_on then	
	state_msg = "<b><font color=\"green\">" .. translate("Running") .. "</font></b>"
else
	state_msg = "<b><font color=\"red\">" .. translate("Not running") .. "</font></b>"
end

m=Map("bandwidthd",translate("Bandwidthd"),translate("通过Bandwidthd可以通过图形界面观察某一网段所有IP的流量状况，并且可以绘制图形<br>状态 - ") .. state_msg .. "<br><br>web观察页面：<a href='http://" .. router_ip .. "/bandwidthd'>http://" .. router_ip .. "/bandwidthd <font color=\"green\">点击跳转</font></a>")
s=m:section(TypedSection,"bandwidthd","")
s.addremove=false
s.anonymous=true
	view_enable = s:option(Flag,"enabled",translate("Enable"))
	view_enable.default=0
	view_dev = s:option(ListValue,"dev",translate("dev"))
	view_dev:value("br-lan","br-lan")
	view_dev:value("eth0","eth0")
	view_dev:value("eth0.1","eth0.1")
	view_dev:value("eth0.2","eth0.2")
	view_subnets = s:option(Value,"subnets",translate("subnets"))
	view_skip_intervals = s:option(Value,"skip_intervals",translate("skip_intervals"))
	view_skip_intervals.datatype="uinteger"
	view_skip_intervals.empty=false
	view_graph_cutoff = s:option(Value,"graph_cutoff",translate("graph_cutoff"))
	view_graph_cutoff.datatype="uinteger"
	view_graph_cutoff.empty=false
	view_promiscuous = s:option(ListValue,"promiscuous",translate("promiscuous"))
	view_promiscuous:value("true","true")
	view_promiscuous:value("false","false")
	view_output_cdf = s:option(ListValue,"output_cdf",translate("output_cdf"))
	view_output_cdf:value("true","true")
	view_output_cdf:value("false","false")
	view_recover_cdf = s:option(ListValue,"recover_cdf",translate("recover_cdf"))
	view_recover_cdf:value("true","true")
	view_recover_cdf:value("false","false")	
	view_filter = s:option(Value,"filter",translate("filter"))
	view_filter.empty=false
	view_graph = s:option(ListValue,"graph",translate("graph"))
	view_graph:value("true","true")
	view_graph:value("false","false")
	view_meta_refresh = s:option(Value,"meta_refresh",translate("meta_refresh"))
	view_meta_refresh.datatype="uinteger"
	view_meta_refresh.empty=false

return m
