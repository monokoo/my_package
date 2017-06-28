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

sg = m:section(NamedSection, "global", "global", translate("Global Settings"))

o = sg:option(Flag, "write", translate("Enable write"), translate("When disabled, all write request will give permission denied."));
o.default = true

o = sg:option(Flag, "download", translate("Enable download"), translate("When disabled, all download request will give permission denied."));
o.default = true

o = sg:option(Flag, "dirlist", translate("Enable directory list"), translate("When disabled, list commands will give permission denied."))
o.default = true

o = sg:option(Flag, "lsrecurse", translate("Allow directory recursely list"))

o = sg:option(Flag, "dotfile", translate("Show dot files"), translate(". and .. are excluded."));
o.default = true

o = sg:option(Value, "umask", translate("File mode umask"), translate("Uploaded file mode will be 666 - &lt;umask&gt;; directory mode will be 777 - &lt;umask&gt;."))
o.default = "022"

o = sg:option(Value, "banner", translate("FTP Banner"))

o = sg:option(Flag, "dirmessage", translate("Enable directory message"), translate("A message will be displayed when entering a directory."))

o = sg:option(Value, "dirmsgfile", translate("Directory message filename"))
o.default = ".message"

return m
