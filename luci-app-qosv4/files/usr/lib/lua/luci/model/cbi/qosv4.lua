require("luci.tools.webadmin")
local t=require"luci.ip"
m=Map("qosv4",translate("qosv4 title","QOSv4"),
translate("qosv4 title desc","qosv4 title desc"))
s=m:section(TypedSection,"qos_settings",translate("qos goble setting","qos goble setting"))
s.anonymous=true
s.addremove=false
enable=s:option(Flag,"enable",translate("qos enable","qos enable"))
enable.default=false
enable.optional=false
enable.rmempty=false
qos_scheduler=s:option(Flag,"qos_scheduler",translate("qos scheduler enable","qos scheduler enable"),
translate("qos scheduler desc","qos scheduler desc"))
qos_scheduler.default=false
qos_scheduler.optional=false
qos_scheduler.rmempty=false
crontab=s:option(DummyValue,"crontab",translate("qos scheduler update"))
crontab.titleref=luci.dispatcher.build_url("admin","system","crontab")
DOWN=s:option(Value,"DOWN",translate("DOWN speed","DOWN speed"),
translate("DOWN speed desc","DOWN speed desc"))
DOWN.optional=false
DOWN.rmempty=false
UP=s:option(Value,"UP",translate("UP speed","UP speed"),
translate("UP speed desc","UP speed desc"))
UP.optional=false
UP.rmempty=false
qos_ip=m:section(TypedSection,"qos_ip",translate("qos black ip","qos black ip"))
qos_ip.anonymous=true
qos_ip.addremove=true
qos_ip.sortable=true
qos_ip.template="cbi/tblsection"
qos_ip.extedit=luci.dispatcher.build_url("admin/qos/qosv4/qosv4ip/%s")
qos_ip.create=function(...)
local e=TypedSection.create(...)
if e then
luci.http.redirect(qos_ip.extedit%e)
return
end
end
enable=qos_ip:option(Flag,"enable",translate("enable","enable"))
enable.default=false
enable.optional=false
enable.rmempty=false
limit_ips=qos_ip:option(DummyValue,"limit_ips",translate("limit_ips","limit_ips"))
limit_ips.rmempty=true
limit_ipe=qos_ip:option(DummyValue,"limit_ipe",translate("limitp_ipe","limit_ipe"))
limit_ipe.rmempty=true
DOWNLOADC=qos_ip:option(DummyValue,"DOWNLOADC",translate("DOWNLOADC speed","DOWNLOADC speed"))
DOWNLOADC.optional=false
DOWNLOADC.rmempty=false
UPLOADC=qos_ip:option(DummyValue,"UPLOADC",translate("UPLOADC speed","UPLOADC speed"))
UPLOADC.optional=false
UPLOADC.rmempty=false
tcplimit=qos_ip:option(DummyValue,"tcplimit",translate("tcplimit","tcplimit"))
tcplimit.optional=false
tcplimit.rmempty=false
udplimit=qos_ip:option(DummyValue,"udplimit",translate("udplimit","udplimit"))
udplimit.optional=false
udplimit.rmempty=false
s=m:section(TypedSection,"transmission_limit",translate("transmission limit","transmission limit"))
s.template="cbi/tblsection"
s.anonymous=true
s.addremove=false
enable=s:option(Flag,"enable",translate("enable","enable"))
enable.default=false
enable.optional=false
enable.rmempty=false
downlimit=s:option(Value,"downlimit",translate("downlimit speed","downlimit speed"))
downlimit.optional=false
downlimit.rmempty=false
uplimit=s:option(Value,"uplimit",translate("uplimit speed","uplimit speed"))
uplimit.optional=false
uplimit.rmempty=false
s=m:section(TypedSection,"qos_nolimit_ip",translate("qos white","qos white"))
s.template="cbi/tblsection"
s.anonymous=true
s.addremove=true
s.sortable=true
enable=s:option(Flag,"enable",translate("enable","enable"))
enable.default=false
enable.optional=false
enable.rmempty=false
nolimit_mac=s:option(Value,"nolimit_mac",translate("white mac","white mac"))
nolimit_mac.rmempty=true
nolimit_ip=s:option(Value,"nolimit_ip",translate("white ip","white ip"))
nolimit_ip.rmempty=true
luci.ip.neighbors({family = 4}, function(neighbor)
if neighbor.reachable then
nolimit_ip:value(neighbor.dest:string(), "%s" %{neighbor.dest:string()})
nolimit_mac:value(neighbor.mac, "%s (%s)" %{neighbor.mac, neighbor.dest:string()})
end
end)
return m
