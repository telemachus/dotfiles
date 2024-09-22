local bo = vim.bo
local create_namespace = vim.api.nvim_create_namespace
local set_highlight_namespace = vim.api.nvim_set_hl_ns
local matchadd = vim.fn.matchadd
local set_highlight = vim.api.nvim_set_hl

bo.tabstop = 4
bo.softtabstop = 4
bo.shiftwidth = 4
bo.expandtab = true
bo.textwidth = 88

local ns = create_namespace("myPython")
set_highlight_namespace(ns)
matchadd("trailingWhitespace", [[\s\+$]])
matchadd("tabSpaces", [[ \+\t]])
matchadd("tabSpaces", [[\t\+ ]])
set_highlight(ns, "trailingWhiteSpace", { undercurl = true })
set_highlight(ns, "tabSpaces", { undercurl = true })
