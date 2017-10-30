local m=require"luci.sys"
local e=require"nixio.fs"
local e=luci.http
local o=require"luci.model.network".init()
local a,t,e,b
a=Map("serverchan",translate("ServerChan"),translate("「Server酱」，英文名「ServerChan」，是一款从服务器推送报警信息和日志到微信的工具。"))
a:section(SimpleSection).template  = "serverchan/serverchan_status"
t=a:section(NamedSection,"global","serverchan",translate("Server酱配置"))
t.anonymous=true
t.addremove=false
e=t:option(Flag,"enabled",translate("启用"))
e.default=0
e.rmempty=false
e=t:option(Value,"sckey",translate('SCKEY'))
e.password=true
e.rmempty=false
t=a:section(NamedSection,"timing_message","serverchan",translate("定时发送状态消息 (长消息)"))
t.anonymous=true
t.addremove=false
e=t:option(Value,"title",translate("微信推送标题"))
e.rmempty=false
e=t:option(Flag,"router_status",translate("系统运行情况"))
e.default=0
e=t:option(Flag,"router_temp",translate("设备温度"))
e.default=0
e=t:option(Flag,"router_wan",translate("WAN信息"))
e.default=0
e=t:option(Flag,"koolss_status",translate("koolss状态"))
e.default=0
e=t:option(ListValue,"client_list",translate("客户端列表"))
e.default="disable"
e:value("disable",translate("关闭"))
e:value("all",translate("发送"))
e:value("nomac",translate("发送(不包含MAC地址)"))
e=t:option(ListValue,"send_mode",translate("定时任务设定"))
e.default="disable"
e:value("disable",translate("关闭"))
e:value("regular",translate("定时发送"))
e:value("interval",translate("间隔发送"))
e=t:option(ListValue,"regular_time",translate("regular"))
for t=0,23 do
e:value(t,translate("每天"..t.."点"))
end
e.default=5
e.datatype=uinteger
e:depends("send_mode","regular")
e=t:option(Value,"interval_time",translate("interval"))
for t=1,72 do
	e:value(t,translate(t.."小时"))
end
e.default=24
e.datatype=uinteger
e:depends("send_mode","interval")
t=a:section(NamedSection,"trigger_message","serverchan",translate("触发发送通知消息 (短消息)"))
t.anonymous=true
t.addremove=false
e=t:option(Flag,"t_redial",translate("网络重拨时"))
e.default=0
e=t:option(ListValue,"t_client_up",translate("设备上线时"))
e.default="disable"
e:value("disable",translate("关闭"))
e:value("all",translate("发送"))
e:value("nomac",translate("发送(不包含MAC地址)"))
e=t:option(ListValue,"t_client_up_filter",translate("黑白名单（设备上线）"))
e.default="blacklist"
e:value("blacklist",translate("黑名单"))
e:value("whitelist",translate("白名单"))
e:depends("t_client_up","all")
e:depends("t_client_up","nomac")
e=t:option(DynamicList,"t_client_up_blacklist",translate("黑名单（设备上线）"))
e.datatype="macaddr"
e.optional=false
m.net.mac_hints(function(m,a)
e:value(m,"%s (%s)"%{m,a})                                                                                                                    
end)
e:depends("t_client_up_filter","blacklist")
e=t:option(DynamicList,"t_client_up_whitelist",translate("白名单（设备上线）"))
e.datatype="macaddr"
e.optional=false
m.net.mac_hints(function(m,a)
e:value(m,"%s (%s)"%{m,a})                                                                                                                    
end)
e:depends("t_client_up_filter","whitelist")
return a
