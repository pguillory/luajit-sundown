local ffi = require 'ffi'

local dir = debug.getinfo(1).source:match('@(.*/)') or ''
local file = io.open(dir .. '/lib/libsundown.min.h')
ffi.cdef(file:read('*a'):match('CDEF_STARTS_HERE;(.*)'))
file:close()

local libsundown = ffi.load(dir .. '/lib/libsundown.so')

return libsundown
