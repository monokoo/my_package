local o=require"luci.dispatcher"
local e=require("luci.model.ipkg")
local s=require"nixio.fs"
local e=luci.model.uci.cursor()
local i="frp"
local a,t,e
local n={}
a=Map(i,translate("Frp Setting"), translate("Frp is a fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet."))
a:section(SimpleSection).template="frp/frp_status"
t=a:section(NamedSection,"common","frp",translate("Global Setting"))
t.anonymous=true
t.addremove=false
e=t:option(Flag, "enabled", translate("Enabled"))
e.rmempty=false
e=t:option(Value, "server_addr", translate("Server"))
e.optional=false
e.rmempty=false
e=t:option(Value, "server_port", translate("Port"))
e.datatype = "port"
e.optional=false
e.rmempty=false
e=t:option(Value, "privilege_token", translate("Privilege Token"), translate("Time duration between server of frpc and frps mustn't exceed 15 minutes."))
e.optional=false
e.rmempty=false
e=t:option(Value, "vhost_http_port", translate("Vhost HTTP Port"))
e.datatype = "port"
e.rmempty=false
e=t:option(Value, "vhost_https_port", translate("Vhost HTTPs Port"))
e.datatype = "port"
e.rmempty=false
e=t:option(Flag, "tcp_mux", translate("TCP Stream Multiplexing"), translate("Default is Ture. This feature in frps.ini and frpc.ini must be same."))
e.default = "1"
e.rmempty=false
e=t:option(Flag, "login_fail_exit", translate("Exit program when first login failed"),translate("decide if exit program when first login failed, otherwise continuous relogin to frps."))
e.default = "1"
e.rmempty=false
e=t:option(Flag, "enable_cpool", translate("Enable Connection Pool"), translate("This feature is fit for a large number of short connections."))
e.rmempty=false
e=t:option(Value, "pool_count", translate("Connection Pool"), translate("Connections will be established in advance."))
e.datatype="uinteger"
e.default = "1"
e:depends("enable_cpool",1)
e.optional=false
e=t:option(Value,"time",translate("Service registration interval"),translate("unit: min"))
e.datatype="uinteger"
e.default=30
e.rmempty=false
e=t:option(ListValue, "log_level", translate("Log Level"))
e.default = "warn"
e:value("trace",translate("Trace"))
e:value("debug",translate("Debug"))
e:value("info",translate("Info"))
e:value("warn",translate("Warning"))
e:value("error",translate("Error"))
e=t:option(Value, "log_max_days", translate("Log Keepd Max Days"))
e.datatype = "uinteger"
e.default = "3"
e.rmempty=false
e.optional=false
t=a:section(TypedSection,"proxy",translate("Services List"))
t.anonymous=true
t.addremove=true
t.template="cbi/tblsection"
t.extedit=o.build_url("admin","services","frp","config","%s")
function t.create(e,t)
new=TypedSection.create(e,t)
luci.http.redirect(e.extedit:format(new))
end
function t.remove(e,t)
e.map.proceed=true
e.map:del(t)
luci.http.redirect(o.build_url("admin","services","frp"))
end
local o=""
e=t:option(DummyValue,"remark",translate("Service Remark Name"))
e.width="10%"
e=t:option(DummyValue,"type",translate("Frp Protocol Type"))
e.width="10%"
e=t:option(DummyValue,"custom_domains",translate("Domain/Subdomain"))
e.width="20%"
e.cfgvalue=function(t,n)
local t=a.uci:get(i,n,"domain_type")or""
if t==""or b==""then return""end
if t=="custom_domains" then
local b=a.uci:get(i,n,"custom_domains")or""
return b end
if t=="subdomain" then
local b=a.uci:get(i,n,"subdomain")or""
return b end
if t=="both_dtype" then
local b=a.uci:get(i,n,"custom_domains")or""
local c=a.uci:get(i,n,"subdomain")or""
b="%s/%s"%{b,c} return b end
return b
end
e=t:option(DummyValue,"remote_port",translate("Remote Port"))
e.width="10%"
e.cfgvalue=function(t,b)
local t=a.uci:get(i,b,"type")or""
if t==""or b==""then return""end
if t=="http" then
local b=a.uci:get(i,"common","vhost_http_port")or""
return b end
if t=="https" then
local b=a.uci:get(i,"common","vhost_https_port")or""
return b end
return b
end
e=t:option(DummyValue,"local_ip",translate("Local Host Address"))
e.width="15%"
e=t:option(DummyValue,"local_port",translate("Local Host Port"))
e.width="10%"
e=t:option(DummyValue,"use_encryption",translate("Use Encryption"))
e.width="15%"
e.cfgvalue=function(t,n)
local t=a.uci:get(i,n,"use_encryption")or""
local b
if t==""or b==""then return""end
if t=="1" then
b="On"
else
b="Off"
end
return b
end
e=t:option(DummyValue,"use_compression",translate("Use Compression"))
e.width="15%"
e.cfgvalue=function(t,n)
local t=a.uci:get(i,n,"use_encryption")or""
local b
if t==""or b==""then return""end
if t=="1" then
b="On"
else
b="Off"
end
return b
end
e=t:option(Flag,"enable",translate("Enable State"))
e.width="10%"
e.rmempty=false
t=a:section(TypedSection,"frp",translate("Client Log"))
t.anonymous=true
e=t:option(TextValue,"log")
e.rows=15
e.wrap="on"
e.readonly=true
e.cfgvalue=function(t,t)
return s.readfile("/var/etc/frp/frpc.log")or""
end
e.write=function(e,e,e)
end
return a
