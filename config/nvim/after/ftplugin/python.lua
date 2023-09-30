vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.textwidth = 88
vim.opt_local.colorcolumn = "89"
vim.opt_local.encoding = "utf-8"

local ns = vim.api.nvim_create_namespace("myPython")
vim.api.nvim_set_hl_ns(ns)
vim.fn.matchadd("trailingWhitespace", [[\s\+$]])
vim.fn.matchadd("tabSpaces", [[ \+\t]])
vim.fn.matchadd("tabSpaces", [[\t\+ ]])
vim.api.nvim_set_hl(ns, "trailingWhiteSpace", { bold = true })
vim.api.nvim_set_hl(ns, "tabSpaces", { strikethrough = true })
