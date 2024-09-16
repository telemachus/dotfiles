local bo = vim.bo
local wo = vim.wo

wo.number = false
wo.relativenumber = false
wo.statuscolumn = ""
bo.comments = ""
bo.formatoptions = "1tn"
bo.textwidth = 72
wo.colorcolumn = "73"
wo.list = true
wo.spell = true
wo.signcolumn = "no"
bo.formatprg = "par -w72q"
