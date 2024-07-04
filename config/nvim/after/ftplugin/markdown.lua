local bo = vim.bo
local wo = vim.wo
-- The formatoptions that I want are currently the default: "1tqln".

bo.textwidth = 78
wo.colorcolumn = "79"
wo.list = true
wo.showbreak = "↪"
bo.tabstop = 8
bo.shiftwidth = 4
bo.softtabstop = 4
bo.expandtab = true
wo.spell = true
bo.complete = ".,k"

-- Treesitter highlights blockquotes as regular text. I want them to be dim
-- like comments.
vim.api.nvim_set_hl(0, "@markup.quote", { link = "Comment" })
