local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt
local cmd = vim.cmd

local telemachus_augroup = augroup('TelemachusAugroup', { clear = true })

-- From :help incsearch. This should be the default.
autocmd('CmdlineEnter', {
    pattern = {'/', '?'},
    callback = function() opt.hlsearch = true end,
    group = telemachus_augroup,
})
autocmd('CmdlineLeave', {
    pattern = {'/', '?'},
    callback = function() opt.hlsearch = false end,
    group = telemachus_augroup,
})

-- Stolen from https://developer.ibm.com/tutorials/l-vim-script-5
autocmd('FocusGained', {
    pattern = '*',
    callback = function()
        opt.cursorline = true
        cmd('redraw')
        cmd('sleep 600m')
        opt.cursorline = false
    end,
    group = telemachus_augroup,
})

local format = require('refinery').format
local goimports = function()
    format('goimports', {'-w'})
end

autocmd('BufWritePre', {
    pattern = '*.go',
    command = 'Goimports',
    group = telemachus_augroup,
})

autocmd('User', {
    pattern = 'RefineryFormatPost',
    command = 'IndentBlanklineRefresh',
    group = telemachus_augroup,
})

autocmd('QuickFixCmdPost', {
    pattern = '[^l]*',
    callback = function() cmd('cwindow') end,
    group = telemachus_augroup,
})

autocmd('QuickFixCmdPost', {
    pattern = 'l*',
    callback = function() cmd('lwindow') end,
    group = telemachus_augroup,
})
