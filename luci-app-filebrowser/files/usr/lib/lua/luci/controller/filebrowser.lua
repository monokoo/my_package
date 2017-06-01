module("luci.controller.filebrowser",package.seeall)
function index()
page=entry({"admin","system","filebrowser"},template("filebrowser"),_("FileBrowser"),89)
page.i18n="base"
page.dependent=true
page=entry({"admin","system","filebrowser_list"},call("filebrowser_list"),nil)
page.leaf=true
page=entry({"admin","system","filebrowser_open"},call("filebrowser_open"),nil)
page.leaf=true
page=entry({"admin","system","filebrowser_delete"},call("filebrowser_delete"),nil)
page.leaf=true
page=entry({"admin","system","filebrowser_rename"},call("filebrowser_rename"),nil)
page.leaf=true
page=entry({"admin","system","filebrowser_upload"},call("filebrowser_upload"),nil)
page.leaf=true
end
function list_response(t,a)
luci.http.prepare_content("application/json")
local e
if a then
local t=scandir(t)
e={
ec=0,
data=t
}
else
e={
ec=1
}
end
luci.http.write_json(e)
end
function filebrowser_list()
local e=luci.http.formvalue("path")
list_response(e,true)
end
function filebrowser_open(e,t)
e=e:gsub("<>","/")
local a=require"io"
local o=to_mime(t)
local e=a.open(e,"r")
luci.http.header('Content-Disposition','inline; filename="'..t..'"')
luci.http.prepare_content(o or"application/octet-stream")
luci.ltn12.pump.all(luci.ltn12.source.file(e),luci.http.write)
end
function filebrowser_delete()
local e=luci.http.formvalue("path")
local a=luci.http.formvalue("isdir")
e=e:gsub("<>","/")
e=e:gsub(" ","\ ")
local t
if a then
t=os.execute('rm -r "'..e..'"')
else
t=os.remove(e)
end
list_response(nixio.fs.dirname(e),t)
end
function filebrowser_rename()
local e=luci.http.formvalue("filepath")
local t=luci.http.formvalue("newpath")
local t=os.execute('mv "'..e..'" "'..t..'"')
list_response(nixio.fs.dirname(e),t)
end
function filebrowser_upload()
local e=luci.http.formvalue("upload-file")
local e=luci.http.formvalue("upload-filename")
local t=luci.http.formvalue("upload-dir")
local i=t..e
local e
luci.http.setfilehandler(
function(t,a,o)
if not e and t and t.name=="upload-file"then
e=io.open(i,"w")
end
if e and a then
e:write(a)
end
if e and o then
e:close()
end
end
)
list_response(t,true)
end
function scandir(i)
local e,n,t=0,{},io.popen
local o=t("ls -lh \""..i.."\" | egrep '^d' ; ls -lh \""..i.."\" | egrep -v '^d|^l'")
for t in o:lines()do
e=e+1
n[e]=t
end
o:close()
o=t("ls -lh \""..i.."\" | egrep '^l' ;")
for a in o:lines()do
e=e+1
linkindex,_,linkpath=string.find(a,"->%s+(.+)$")
local t;
if string.sub(linkpath,1,1)=="/"then
t=linkpath
else
t=nixio.fs.realpath(i..linkpath)
end
local o;
if not t then
t=linkpath;
o='x'
elseif nixio.fs.stat(t,"type")=="dir"then
o='z'
else
o='l'
end
a=string.sub(a,2,linkindex-1)
a=o..a.."-> "..t
n[e]=a
end
o:close()
return n
end
MIME_TYPES={
["txt"]="text/plain";
["conf"]="text/plain";
["ovpn"]="text/plain";
["js"]="text/javascript";
["json"]="application/json";
["css"]="text/css";
["htm"]="text/html";
["html"]="text/html";
["patch"]="text/x-patch";
["c"]="text/x-csrc";
["h"]="text/x-chdr";
["o"]="text/x-object";
["ko"]="text/x-object";
["bmp"]="image/bmp";
["gif"]="image/gif";
["png"]="image/png";
["jpg"]="image/jpeg";
["jpeg"]="image/jpeg";
["svg"]="image/svg+xml";
["zip"]="application/zip";
["pdf"]="application/pdf";
["xml"]="application/xml";
["xsl"]="application/xml";
["doc"]="application/msword";
["ppt"]="application/vnd.ms-powerpoint";
["xls"]="application/vnd.ms-excel";
["odt"]="application/vnd.oasis.opendocument.text";
["odp"]="application/vnd.oasis.opendocument.presentation";
["pl"]="application/x-perl";
["sh"]="application/x-shellscript";
["php"]="application/x-php";
["deb"]="application/x-deb";
["iso"]="application/x-cd-image";
["tgz"]="application/x-compressed-tar";
["mp3"]="audio/mpeg";
["ogg"]="audio/x-vorbis+ogg";
["wav"]="audio/x-wav";
["mpg"]="video/mpeg";
["mpeg"]="video/mpeg";
["avi"]="video/x-msvideo";
}
function to_mime(e)
if type(e)=="string"then
local e=e:match("[^%.]+$")
if e and MIME_TYPES[e:lower()]then
return MIME_TYPES[e:lower()]
end
end
return"application/octet-stream"
end
