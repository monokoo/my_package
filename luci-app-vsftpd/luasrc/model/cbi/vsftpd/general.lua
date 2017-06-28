--[[
LuCI - Lua Configuration Interface

Copyright 2016 Weijie Gao <hackpascal@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

m = Map("vsftpd", translate("FTP Server - General Settings"))

sl = m:section(NamedSection, "listen", "listen", translate("Listening Settings"))

o = sl:option(Flag, "enable4", translate("Enable IPv4"))
o.rmempty = false
o.default = true

o = sl:option(Value, "ipv4", translate("IPv4 Address"))
o.datatype = "ip4addr"
o.default = "0.0.0.0"

o = sl:option(Flag, "enable6", translate("Enable IPv6"))
o.rmempty = false

o = sl:option(Value, "ipv6", translate("IPv6 Address"))
o.datatype = "ip6addr"
o.default = "::"

o = sl:option(Value, "port", translate("Listen Port"))
o.datatype = "uinteger"
o.default = "21"

o = sl:option(Value, "dataport", translate("Data Port"))
o.datatype = "uinteger"
o.default = "20"


sl = m:section(NamedSection, "local", "local", translate("Local Users"))

o = sl:option(Flag, "enabled", translate("Enable local user"))
o.rmempty = false

o = sl:option(Value, "root", translate("Root directory"), translate("Leave empty will use user's home directory"))
o.default = ""

return m
