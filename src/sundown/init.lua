local ffi = require 'ffi'
local libsundown = require 'sundown/libsundown'

local sundown = {}

function sundown.render(txt, callbacks)
  callbacks = callbacks or {}

  local cb = ffi.new('struct sd_callbacks')
  local options = ffi.new('struct html_renderopt')
  libsundown.sdhtml_renderer(cb, options, 0)

  if callbacks.blockcode then
    local default_cb = cb.blockcode
    cb.blockcode = function(ob, codebuf, langbuf, opaque)
      local buf = ffi.gc(libsundown.bufnew(64), libsundown.bufrelease)
      local code = ffi.string(codebuf.data, codebuf.size)
      local lang = ffi.string(langbuf.data, langbuf.size)
      local html = callbacks.blockcode(code, lang)
      if html then
        libsundown.bufput(ob, html, #html)
      else
        default_cb(ob, codebuf, langbuf, opaque)
      end
    end
  end

  local markdown = libsundown.sd_markdown_new(0xfff, 16, cb, options)
  local outbuf = libsundown.bufnew(64)
  libsundown.sd_markdown_render(outbuf, txt, #txt, markdown)
  local html = ffi.string(outbuf.data, outbuf.size)
  libsundown.sd_markdown_free(markdown)
  libsundown.bufrelease(outbuf)

  if callbacks.blockcode then
    cb.blockcode:free()
  end

  return html
end

return sundown
