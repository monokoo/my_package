local e=require"luci.tools.webadmin"
local e=require"nixio.fs"
local e=require"luci.model.uci".cursor()
require"luci.sys"
local e=luci.sys.init.enabled("qos_guoguo")
m=Map("qos_guoguo",translate("General Settings"),translate("QoS by GuoGuo.Based on the QoS scripts in Gargoyle firmware."))
m:section(SimpleSection).template="qos_guoguo/web_script"
s=m:section(TypedSection,"global",translate("Toggle"),translate("Toggle QoS here."))
s.anonymous=true
o=s:option(Flag,"enabled",translate("Enable"))
o.default=0
o.rmempty=false
s=m:section(TypedSection,"upload",translate("Upload Settings"))
s.anonymous=true
uclass=s:option(Value,"default_class",translate("Default Service Class"),translate("The <em>Default Service Class</em> specifies how packets that do not match any rule should be classified."))
uclass.rmempty="true"
for e in io.lines("/etc/config/qos_guoguo")do
local t=e
e=string.gsub(e,"config ['\"]*upload_class['\"]* ","")
if t~=e then
e=string.gsub(e,"^'","")
e=string.gsub(e,"^\"","")
e=string.gsub(e,"'$","")
e=string.gsub(e,"\"$","")
uclass:value(e,m.uci:get("qos_guoguo",e,"name"))
end
end
tb=s:option(Value,"total_bandwidth",translate("Total Upload Bandwidth"),translate("<em>Total Upload Bandwidth</em> should be set to around 98% of your available upload bandwidth. Entering a number which is too high will result in QoS not meeting its class requirements. Entering a number which is too low will needlessly penalize your upload speed. You should use a speed test program (with QoS off) to determine available upload bandwidth. Note that bandwidth is specified in kbps. There are 8 kilobits per kilobyte."))
tb.datatype="and(uinteger,min(0))"
s=m:section(TypedSection,"download",translate("Download Settings"))
s.anonymous=true
dclass=s:option(Value,"default_class",translate("Default Service Class"),translate("The <em>Default Service Class</em> specifies how packets that do not match any rule should be classified."))
dclass.rmempty="true"
for e in io.lines("/etc/config/qos_guoguo")do
local t=e
e=string.gsub(e,"config ['\"]*download_class['\"]* ","")
if t~=e then
e=string.gsub(e,"^'","")
e=string.gsub(e,"^\"","")
e=string.gsub(e,"'$","")
e=string.gsub(e,"\"$","")
dclass:value(e,translate(m.uci:get("qos_guoguo",e,"name")))
end
end
tb=s:option(Value,"total_bandwidth",translate("Total Download Bandwidth"),translate("Specifying <em>Total Download Bandwidth</em> correctly is crucial to making QoS work.Note that bandwidth is specified in kbps. There are 8 kilobits per kilobyte."))
tb.datatype="and(uinteger,min(0))"
monen=s:option(ListValue,"qos_monenabled",translate("Enable Active Congestion Control"),
translate("<p>The active congestion control (ACC) observes your download activity and automatically adjusts your download link limit to maintain proper QoS performance. ACC automatically compensates for changes in your ISP's download speed and the demand from your network adjusting the link speed to the highest speed possible which will maintain proper QoS function. The effective range of this control is between 15% and 100% of the total download bandwidth you entered above.</p>")..
translate("<p>While ACC does not adjust your upload link speed you must enable and properly configure your upload QoS for it to function properly.</p>")..
translate("<p><em>Ping Target-</em> The segment of network between your router and the ping target is where congestion is controlled. By monitoring the round trip ping times to the target congestion is detected. By default ACC uses your WAN gateway as the ping target. If you know that congestion on your link will occur in a different segment then you can enter an alternate ping target.</p>")..
translate("<p><em>Manual Ping Limit</em> Round trip ping times are compared against the ping limits. ACC controls the link limit to maintain ping times under the appropriate limit. By default ACC attempts to automatically select appropriate target ping limits for you based on the link speeds you entered and the performance of your link it measures during initialization. You cannot change the target ping time for the minRTT mode but by entering a manual time you can control the target ping time of the active mode. The time you enter becomes the increase in the target ping time between minRTT and active mode.")
)
monen:value("true",translate("Enable"))
monen:value("false",translate("Disable"))
monen.default="false"
ptip=s:option(Value,"ptarget_ip",translate("Use non-standard ping target"),translate("Specify a custom ping target here if you want.Leave empty to use the default settings."))
ptip.datatype="ipaddr"
ptip:depends({qos_monenabled="true"})
ptime=s:option(Value,"pinglimit",translate("Manual Ping Limit"),translate("Specify a custom ping time limit here if you want.Leave empty to use the default settings."))
ptime.datatype="range(100,2000)"
ptime:depends({qos_monenabled="true"})
return m
