module("luci.controller.autoreboot",package.seeall)
function index()
entry({"admin","system","autoreboot"},cbi("autoreboot"),_("AutoReboot"),88)
end
