local bo = vim.bo
local wo = vim.wo

bo.comments = ""
bo.formatoptions = "1tnw"
bo.textwidth = 80
wo.list = true
wo.spell = true
bo.formatprg = "par -w80q"
wo.colorcolumn = "81"
vim.b.match_words = { '":"', "':'", "(:)", "[:]", "<:>", "“:”", "‘:’" }
