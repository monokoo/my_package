module("luci.controller.filetransfer",package.seeall)
function index()
entry({"admin","system","filetransfer"},cbi("updownload"),_("FileTransfer"),52)
end
