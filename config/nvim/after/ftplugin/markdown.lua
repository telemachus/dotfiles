local bo = vim.bo
local wo = vim.wo[0][0]

bo.textwidth = 80
wo.list = true
wo.showbreak = "↪"
bo.tabstop = 8
bo.shiftwidth = 4
bo.softtabstop = 4
bo.expandtab = true
wo.spell = true
bo.complete = ".,k"

-- The formatoptions that I want are currently the default: "1tqln".
-- However, I'm leaving this comment in case that ever changes.
