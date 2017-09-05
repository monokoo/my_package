local e=require"io"
local e=require"os"
local e=require"luci.ltn12"
local e=require"nixio.fs"
local t=require"nixio.util"
local a=type
module"luci.fs"
access=e.access
function glob(...)
local e,a,o=e.glob(...)
if e then
return t.consume(e)
else
return nil,a,o
end
end
function isfile(t)
return e.stat(t,"type")=="reg"
end
function isdirectory(t)
return e.stat(t,"type")=="dir"
end
readfile=e.readfile
writefile=e.writefile
copy=e.datacopy
rename=e.move
function mtime(t)
return e.stat(t,"mtime")
end
function utime(o,a,t)
return e.utimes(o,t,a)
end
basename=e.basename
dirname=e.dirname
function dir(...)
local e,o,a=e.dir(...)
if e then
local e=t.consume(e)
e[#e+1]="."
e[#e+1]=".."
return e
else
return nil,o,a
end
end
function mkdir(t,a)
return a and e.mkdirr(t)or e.mkdir(t)
end
rmdir=e.rmdir
local o={
reg="regular",
dir="directory",
lnk="link",
chr="character device",
blk="block device",
fifo="fifo",
sock="socket"
}
function stat(a,t)
local e,i,a=e.stat(a)
if e then
e.mode=e.modestr
e.type=o[e.type]or"?"
end
return t and e and e[t]or e,i,a
end
chmod=e.chmod
function link(a,t,o)
return o and e.symlink(a,t)or e.link(a,t)
end
unlink=e.unlink
readlink=e.readlink
