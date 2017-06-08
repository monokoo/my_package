local o=require"luci.sys"
local a,e,t
a=Map("webrestriction",translate("访问限制"),translate("开启后默认禁止所有客户端连接到互联网，只有在白名单列表中的例外。"))
a.template="webrestriction/index"
e=a:section(TypedSection,"basic",translate("Running Status"))
e.anonymous=true
t=e:option(DummyValue,"webrestriction_status",translate("当前状态"))
t.template="webrestriction/webrestriction"
t.value=translate("Collecting data...")
e=a:section(TypedSection,"basic",translate("全局设置"))
e.anonymous=true
t=e:option(Flag,"enable",translate("开启"))
t.rmempty=false
e=a:section(TypedSection,"whitelist","macbind",translate("白名单设置"),translate("白名单中的客户端可以连接到互联网"))
e.template="cbi/tblsection"
e.anonymous=true
e.addremove=true
t=e:option(Flag,"enable",translate("开启控制"))
t.rmempty=false
t=e:option(Value,"macaddr",translate("白名单MAC地址"))
t.rmempty=true
o.net.mac_hints(function(e,a)
t:value(e,"%s (%s)"%{e,a})
end)

e=a:section(TypedSection,"blacklist","macbind",translate("黑名单设置"),translate("黑名单中的客户端被禁止连接到互联网"))
e.template="cbi/tblsection"
e.anonymous=true
e.addremove=true
t=e:option(Flag,"enable",translate("开启控制"))
t.rmempty=false
t=e:option(Value,"macaddr",translate("黑名单MAC地址"))
t.rmempty=true
o.net.mac_hints(function(e,a)
t:value(e,"%s (%s)"%{e,a})
end)

return a
