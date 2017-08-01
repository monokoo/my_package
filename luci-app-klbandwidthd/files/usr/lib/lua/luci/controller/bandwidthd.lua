module("luci.controller.bandwidthd", package.seeall)
function index()
        if not nixio.fs.access("/etc/config/bandwidthd") then
                return
        end
        entry({"admin", "status", "traffic"}, cbi("bandwidthd"), _("Traffic Statistics"),13).dependent = true
end
