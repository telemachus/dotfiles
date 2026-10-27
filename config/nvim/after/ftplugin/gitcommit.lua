local wo = vim.wo[0][0]
local bo = vim.bo
local cmd = vim.cmd

bo.textwidth = 72
wo.spell = true
cmd([[match ErrorMsg /\%1l.\%>51v/]])
