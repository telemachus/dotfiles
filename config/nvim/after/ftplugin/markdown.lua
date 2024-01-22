vim.opt_local.cpo:append("J")
vim.opt_local.textwidth = 78
vim.opt_local.colorcolumn = "79"
vim.opt_local.list = true
vim.opt_local.formatoptions:append("1tqln")
vim.opt_local.showbreak = "↪"
vim.opt_local.tabstop = 8
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.spell = true

-- Treesitter highlights quotes as text; I prefer the dimness of Comment.
vim.api.nvim_set_hl(0, "@markup.quote", { link = "Comment" })

-- Treesitter highlights strong and emphasis as text; I prefer bold and italic.
vim.api.nvim_set_hl(0, "@markup.strong", { link = "Bold" })
vim.api.nvim_set_hl(0, "@markup.italic", { link = "Italic" })
