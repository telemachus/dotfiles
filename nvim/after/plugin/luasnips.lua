local luasnip = require('luasnip')
local snippet = luasnip.snippet
local inode = luasnip.insert_node
local fnode = luasnip.function_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

luasnip.snippets = {
    lua = {
        snippet(
            'mirrorreq',
            fmt(
                [[local {} = require('{}')]],
                { fnode(function(import)
                        local parts = vim.split(import[1][1], '.', true)
                        return parts[#parts] or ''
                    end, {1}), inode(1) }
            )
        ),
    },
}

require('luasnip.loaders.from_snipmate').lazy_load()
