luajit-sundown
==============

This is a LuaJIT FFI binding for [Sundown], a C library for rendering
markdown.

Usage
-----

```lua
print(sundown.render('Hello world'))
// <p>Hello world</p>
```

You can also pass callbacks for rendering specific types of content. The only
one supported at the moment is `blockcode`, so that you can do syntax
highlighting. See the `tests` directory for an example.

[Sundown]: https://github.com/vmg/sundown
