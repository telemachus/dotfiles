local bo = vim.bo
local wo = vim.wo

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
-- TODO: do I still need this? I don't think that I do. Comment out for now.
-- vim.api.nvim_set_hl(0, "@markup.quote", { link = "Comment" })

-- The formatoptions that I want are currently the default: "1tqln".
-- However, I'm leaving this comment in case that ever changes.
