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

sc = m:section(NamedSection, "connection", "connection", translate("Connection Settings"))

o = sc:option(Flag, "portmode", translate("Enable PORT mode"))
o.default = 1
o = sc:option(Flag, "pasvmode", translate("Enable PASV mode"))
o.default = 1

o = sc:option(Value, "pasv_address", translate("PASV Address"))
o:depends("pasvmode",1)
o = sc:option(Flag, "pasv_addr_resolve", translate("Resolve PASV Address"))
o:depends("pasvmode",1)
o = sc:option(Value, "pasv_min_port", translate("Min PASV Port"))
o.datatype="range(1025,65535)"
o.default = "5000"

o = sc:option(Value, "pasv_max_port", translate("Max PASV Port"))
o.datatype="range(1026,65535)"
o.default = "5003"

o = sc:option(ListValue, "ascii", translate("ASCII mode"))
o:value("disabled", translate("Disabled"))
o:value("download", translate("Download only"))
o:value("upload", translate("Upload only"))
o:value("both", translate("Both download and upload"))
o.default = "both"

o = sc:option(Value, "idletimeout", translate("Idle session timeout"), translate("in seconds"))
o.datatype = "uinteger"
o.default = "1800"
o = sc:option(Value, "conntimeout", translate("Connection timeout"), translate("in seconds"))
o.datatype = "uinteger"
o.default = "120"
o = sc:option(Value, "dataconntimeout", translate("Data connection timeout"), translate("in seconds"))
o.datatype = "uinteger"
o.default = "120"
o = sc:option(Value, "maxclient", translate("Max clients"), translate("0 means no limitation"))
o.datatype = "uinteger"
o.default = "0"
o = sc:option(Value, "maxperip", translate("Max clients per IP"), translate("0 means no limitation"))
o.datatype = "uinteger"
o.default = "0"
o = sc:option(Value, "maxrate", translate("Max transmit rate"), translate("in KB/s, 0 means no limitation"))
o.datatype = "uinteger"
o.default = "0"
o = sc:option(Value, "maxretry", translate("Max login fail count"), translate("Can not be zero, default is 3"))
o.datatype = "uinteger"
o.default = "3"

return m
