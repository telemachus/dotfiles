local wo = vim.wo
local bo = vim.bo
local cmd = vim.cmd

wo.colorcolumn = "73"
bo.textwidth = 72
wo.spell = true
cmd([[match ErrorMsg /\%1l.\%>51v/]])
