--Alex<1886090@gmail.com>


local state_msg = "" 
local bandwidthd_on = (luci.sys.call("pgrep /usr/sbin/bandwidthd > /dev/null") == 0)

m=Map("bandwidthd",translate("Bandwidthd"),translate("通过Bandwidthd可以通过图形界面观察某一网段所有IP的流量状况，并且可以绘制图形<br>"))
m:section(SimpleSection).template  = "bandwidthd/bandwidthd_status"
s=m:section(TypedSection,"bandwidthd","")
s.addremove=false
s.anonymous=true

	view_enable = s:option(Flag,"enabled",translate("Enable"))
	view_enable.default=0
	if bandwidthd_on then
	e=s:option(Button,"Configuration",translate("web观察页面"))
	e.inputtitle=translate("打开统计页面")
	e.inputstyle="reload"
	e.write=function()
	e.template  = "bandwidthd/bandwidthd_url"
	end
	end
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
