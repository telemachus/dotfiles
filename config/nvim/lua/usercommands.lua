local command = vim.api.nvim_create_user_command
local buf_opt = vim.bo
local cmd = vim.cmd

command('Gofmt', function(_)
    require('refinery').format('gofmt', { '-w', '-s' })
end, { desc = 'Format current file with gofmt', bar = true })

command('Gofumpt', function(_)
    require('refinery').format('gofumpt', { '-w' })
end, { desc = 'Format current file with gofumpt', bar = true })

command('Goimports', function(_)
    require('refinery').format('goimports', { '-w' })
end, { desc = 'Format current file with goimports', bar = true })

command('Golines', function(_)
    require('refinery').format('golines', {
        '--write-output',
        '--base-formatter=gofumpt',
        '--tab-len=4',
        '--max-len=100',
        '--no-reformat-tags',
    })
end, { desc = 'Format current file with golines', bar = true })

command('Revive', function(_)
    local old_make = buf_opt.makeprg
    buf_opt.makeprg = 'revive -config ~/go/extras/revive.toml'
    cmd('silent make')
    buf_opt.makeprg = old_make
end, { desc = 'Lint with revive', bar = true })

command('Stylua', function(_)
    require('refinery').format('stylua', {})
end, { desc = 'Format current file with stylua', bar = true })
