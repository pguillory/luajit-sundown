local sundown = require 'sundown'

do
  local html = sundown.render('Hello world')
  assert(html == '<p>Hello world</p>\n')
end

do
  local md = [[
# An example with a callback

```lua
local sundown = require 'sundown'
```

```javascript
document.setTimeout()
```
]]
  local expected = [[
<h1>An example with a callback</h1>
<code>some lua code: local sundown = require 'sundown'
</code>
<pre><code class="javascript">document.setTimeout()
</code></pre>
]]
  local html = sundown.render(md, {
    blockcode = function(code, lang)
      if lang == 'lua' then
        return '<code>some lua code: ' .. code .. '</code>'
      end
    end,
  })
  assert(html == expected)
end
