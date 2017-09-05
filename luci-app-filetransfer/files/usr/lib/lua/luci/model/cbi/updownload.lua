local n=require"luci.fs"
local t=luci.http
ful=SimpleForm("upload",translate("Upload"),nil)
ful.reset=false
ful.submit=false
sul=ful:section(SimpleSection,"",translate("Upload file to '/tmp/upload/'"))
fu=sul:option(FileUpload,"")
fu.template="cbi/other_upload"
um=sul:option(DummyValue,"",nil)
um.template="cbi/other_dvalue"
fdl=SimpleForm("download",translate("Download"),nil)
fdl.reset=false
fdl.submit=false
sdl=fdl:section(SimpleSection,"",translate("Download file :input file/dir path"))
fd=sdl:option(FileUpload,"")
fd.template="cbi/other_download"
dm=sdl:option(DummyValue,"",nil)
dm.template="cbi/other_dvalue"
function Download()
local e,o,a,i
e=t.formvalue("dlfile")
o=nixio.fs.basename(e)
if luci.fs.isdirectory(e)then
a=io.popen('tar -C "%s" -cz .'%{e},"r")
o=o..".tar.gz"
else
a=nixio.open(e,"r")
end
if not a then
dm.value=translate("Couldn't open file: ")..e
return
end
dm.value=nil
t.header('Content-Disposition','attachment; filename="%s"'%{o})
t.prepare_content("application/octet-stream")
while true do
i=a:read(nixio.const.buffersize)
if(not i)or(#i==0)then
break
else
t.write(i)
end
end
a:close()
t.close()
end
local a,e
a="/tmp/upload/"
nixio.fs.mkdir(a)
t.setfilehandler(
function(t,o,i)
if not e then
if not t then return end
e=nixio.open(a..t.file,"w")
if not e then
um.value=translate("Create upload file error.")
return
end
end
if o and e then
e:write(o)
end
if i and e then
e:close()
e=nil
um.value=translate("File saved to")..' "/tmp/upload/'..t.file..'"'
end
end
)
if luci.http.formvalue("upload")then
local e=luci.http.formvalue("ulfile")
if#e<=0 then
um.value=translate("No specify upload file.")
end
elseif luci.http.formvalue("download")then
Download()
end
local e,a={}
for t,o in ipairs(n.glob("/tmp/upload/*"))do
a=n.stat(o)
if a then
e[t]={}
e[t].name=n.basename(o)
e[t].mtime=os.date("%Y-%m-%d %H:%M:%S",a.mtime)
e[t].modestr=a.modestr
e[t].size=tostring(a.size)
e[t].remove=0
e[t].install=false
end
end
form=SimpleForm("filelist",translate("Upload file list"),nil)
form.reset=false
form.submit=false
tb=form:section(Table,e)
nm=tb:option(DummyValue,"name",translate("File name"))
mt=tb:option(DummyValue,"mtime",translate("Modify time"))
ms=tb:option(DummyValue,"modestr",translate("Mode string"))
sz=tb:option(DummyValue,"size",translate("Size"))
btnrm=tb:option(Button,"remove",translate("Remove"))
btnrm.render=function(e,t,a)
e.inputstyle="remove"
Button.render(e,t,a)
end
btnrm.write=function(a,t)
local a=luci.fs.unlink("/tmp/upload/"..luci.fs.basename(e[t].name))
if a then table.remove(e,t)end
return a
end
function IsIpkFile(e)
e=e or""
local e=string.lower(string.sub(e,-4,-1))
return e==".ipk"
end
btnis=tb:option(Button,"install",translate("Install"))
btnis.template="cbi/other_button"
btnis.render=function(o,a,t)
if not e[a]then return false end
if IsIpkFile(e[a].name)then
t.display=""
else
t.display="none"
end
o.inputstyle="apply"
Button.render(o,a,t)
end
btnis.write=function(a,t)
local e=luci.sys.exec(string.format('opkg --force-depends install "/tmp/upload/%s"',e[t].name))
form.description=string.format('<span style="color: red">%s</span>',e)
end
return ful,fdl,form
