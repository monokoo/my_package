require("luci.sys")
require("luci.sys.zoneinfo")
require("luci.config")
local fs = require "nixio.fs"
local ut = require "luci.util"
local o=require"luci.model.network".init()
local sys = require "luci.sys"

m = Map("kuainiao", translate("迅雷快鸟"),translate("迅雷快鸟是迅雷联合宽带运营商推出的一款致力于帮助用户解决宽带低、网速慢、上网体验差的专业级宽带加速软件。"))

m:section(SimpleSection).template  = "kuainiao/kuainiao_status"
s = m:section(NamedSection, "base", "kuainiao", translate("Please Set before apply."))
s.addremove = false
s:tab("base",translate("Basic Settings"))
s:tab("log",translate("Client Log"))

enabled = s:taboption("base",Flag, "enabled", translate("Enable"))
enabled.default=0
enabled.rmempty = false

enable_down = s:taboption("base",Flag, "enable_down", translate("开启下行加速"))
enable_down.default=1
enabled.rmempty = false
enable_down:depends("enabled",1)

enable_up = s:taboption("base",Flag, "enable_up", translate("开启上行加速"))
enable_up.default=0
enabled.rmempty = false
enable_up:depends("enabled",1)

username = s:taboption("base",Value, "kuainiao_name", translate("Thunder Username"))
username.datatype = "minlength(1)"
username.rmempty = false

password = s:taboption("base",Value, "kuainiao_passwd", translate("Thunder Password"))
password.password = true
password.datatype = "minlength(1)"
password.rmempty = false

kuainiao_config_pwd = s:taboption("base",Value, "kuainiao_config_pwd", translate("加密后密码"))
kuainiao_config_pwd.password = true
kuainiao_config_pwd.datatype = "minlength(1)"
kuainiao_config_pwd.rmempty = true
kuainiao_config_pwd.readonly=true

local a
speed_wan=s:taboption("base",ListValue,"speed_wan",translate("指定加速的接口"))
for a,s in ipairs(o:get_networks())do
if s:name()~="loopback" and s:name()~="lan" then speed_wan:value(s:name())end
end

startup = s:taboption("base",Flag, "startup", translate("Run when router startup"))
startup.default = true
startup.optional = false
startup.rmempty = true

if fs.access("/usr/share/kuainiao/kuainiao_down_state") then
kuainiao_down_state = sys.exec("touch /usr/share/kuainiao/kuainiao_down_state && cat /usr/share/kuainiao/kuainiao_down_state")
end

kuainiao_down_state = s:taboption("base",DummyValue, "kuainiao_down_state", translate("下行提速状态" ..kuainiao_down_state))
--kuainiao_down_state.value=sys.exec("cat /usr/share/kuainiao/kuainiao_down_state")

kuainiao_up_state = s:taboption("base",DummyValue, "kuainiao_up_state", translate("上行提速状态"))
--kuainiao_up_state.value="0"


log=s:taboption("log",TextValue,"log")
log.rows=26
log.wrap="off"
log.readonly=true
log.cfgvalue=function(t,t)
return nixio.fs.readfile("/var/log/kuainiao.log")or""
end
log.write=function(log,log,log)
end

m:section(SimpleSection).template  = "kuainiao/kuainiao_rsa"

local apply = luci.http.formvalue("cbi.apply")
if apply then
    io.popen("luci_fastdick_apply")
end
return m
