local n="frp"
local i=require"luci.dispatcher"
local o=require"luci.model.network".init()
local m=require"nixio.fs"
local a,t,e
arg[1]=arg[1]or""
a=Map(n,translate("Frp Config"))
a.redirect=i.build_url("admin","services","frp")
t=a:section(NamedSection,arg[1],"frp",translate("Config Frp"))
t.addremove=false
t.dynamic=false
e=t:option(ListValue,"enable",translate("Enable State"))
e.default="1"
e.rmempty=false
e:value("1",translate("Enable"))
e:value("0",translate("Disable"))
e=t:option(ListValue, "type", translate("Frp Protocol Type"))
e:value("http",translate("HTTP"))
e:value("https",translate("HTTPS"))
e:value("tcp",translate("TCP"))
e:value("udp",translate("UDP"))
e = t:option(ListValue, "domain_type", translate("Domain Type"))
e.default = "custom_domains"
e:value("custom_domains",translate("Custom Domains"))
e:value("subdomain",translate("SubDomain"))
e:value("both_dtype",translate("Both the above two Domain types"))
e:depends("type","http")
e:depends("type","https")
e = t:option(Value, "custom_domains", translate("Custom Domains"), translate("If SubDomain is used, Custom Domains couldn't be subdomain or wildcard domain of the maindomain(subdomain_host)."))
e:depends("domain_type","custom_domains")
e:depends("domain_type","both_dtype")
e = t:option(Value, "subdomain", translate("SubDomain"), translate("subdomain_host must be configured in server: frps in advance."))
e:depends("domain_type","subdomain")
e:depends("domain_type","both_dtype")
e = t:option(Value, "remote_port", translate("Remote Port"))
e.datatype = "port"
e:depends("type","tcp")
e:depends("type","udp")
e = t:option(Flag, "enable_plugin", translate("Use Plugin"),translate("If plugin is defined, local_ip and local_port is useless, plugin will handle connections got from frps."))
e.default = "0"
e:depends("type","tcp")
e = t:option(Value, "local_ip", translate("Local Host Address"))
luci.sys.net.arptable(function(x)
e:value(x["IP address"])
end)
e.datatype = "ip4addr"
e:depends("type","udp")
e:depends("type","http")
e:depends("type","https")
e:depends("enable_plugin",0)
e = t:option(Value, "local_port", translate("Local Host Port"))
e.datatype = "port"
e:depends("type","udp")
e:depends("type","http")
e:depends("type","https")
e:depends("enable_plugin",0)
e = t:option(Flag, "enable_locations", translate("Enable URL routing"), translate("Frp support forward http requests to different backward web services by url routing."))
e:depends("type","http")
e = t:option(Value, "locations ", translate("URL routing"), translate("Http requests with url prefix /news will be forwarded to this service."))
e.default="locations=/"
e:depends("enable_locations",1)
e = t:option(ListValue, "plugin", translate("Choose Plugin"))
e:value("http_proxy",translate("http_proxy"))
e:value("unix_domain_socket",translate("unix_domain_socket"))
e:depends("enable_plugin",1)
e = t:option(Value, "plugin_http_user", translate("Plugin HTTP UserName"))
e.default = "abc"
e:depends("plugin","http_proxy")
e = t:option(Value, "plugin_http_passwd", translate("Plugin HTTP Passwd"))
e.default = "abc"
e:depends("plugin","http_proxy")
e = t:option(Value, "plugin_unix_path", translate("Plugin Unix Sock Path"))
e.default = "/var/run/docker.sock"
e:depends("plugin","unix_domain_socket")
e = t:option(Flag, "enable_http_auth", translate("Password protecting your web service"), translate("Http username and password are safety certification for http protocol."))
e.default = "0"
e:depends("type","http")
e = t:option(Value, "http_user", translate("HTTP UserName"))
e.default = "frp"
e:depends("enable_http_auth",1)
e = t:option(Value, "http_pwd", translate("HTTP PassWord"))
e.default = "frp"
e:depends("enable_http_auth",1)
e = t:option(Flag, "enable_host_header_rewrite", translate("Rewriting the Host Header"), translate("Frp can rewrite http requests with a modified Host header."))
e.default = "0"
e:depends("type","http")
e = t:option(Value, "host_header_rewrite", translate("Host Header"), translate("The Host header will be rewritten to match the hostname portion of the forwarding address."))
e.default = "dev.yourdomain.com"
e:depends("enable_host_header_rewrite",1)
e = t:option(Flag, "use_encryption", translate("Use Encryption"), translate("Encrypted the communication between frpc and frps, will effectively prevent the traffic intercepted."))
e.default = "1"
e.rmempty = false
e = t:option(Flag, "use_compression", translate("Use Compression"), translate("The contents will be compressed to speed up the traffic forwarding speed, but this will consume some additional cpu resources."))
e.default = "1"
e.rmempty = false
e = t:option(Value, "remark", translate("Service Remark Name"), translate("<font color=\"red\">Please ensure the remark name is unique.</font>"))
e.rmempty = false
return a
