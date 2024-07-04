local o = vim.o
local bo = vim.bo
local wo = vim.wo

bo.tabstop = 4
bo.softtabstop = 4
bo.shiftwidth = 4
bo.expandtab = true
bo.textwidth = 88
wo.colorcolumn = "89"
o.encoding = "utf-8"

local ns = vim.api.nvim_create_namespace("myPython")
vim.api.nvim_set_hl_ns(ns)
vim.fn.matchadd("trailingWhitespace", [[\s\+$]])
vim.fn.matchadd("tabSpaces", [[ \+\t]])
vim.fn.matchadd("tabSpaces", [[\t\+ ]])
vim.api.nvim_set_hl(ns, "trailingWhiteSpace", { bold = true })
vim.api.nvim_set_hl(ns, "tabSpaces", { strikethrough = true })
