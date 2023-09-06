local command = vim.api.nvim_create_user_command
local buf_opt = vim.bo
local cmd = vim.cmd

command('Revive', function(_)
    local old_make = buf_opt.makeprg
    buf_opt.makeprg = 'make lint'
    cmd('silent make')
    buf_opt.makeprg = old_make
end, { desc = 'Lint with revive', bar = true })

command('Stylua', function(_)
    require('refinery').format('stylua', {})
end, { desc = 'Format current file with stylua', bar = true })
