local command = vim.api.nvim_create_user_command

command('Goimports', function(_)
    require('refinery').format('goimports', { '-w' })
end, { desc = 'Format current file with goimports', bar = true })

command('Gofumpt', function(_)
    require('refinery').format('gofumpt', { '-w' })
end, { desc = 'Format current file with gofumpt', bar = true })

command('Golines', function(_)
    require('refinery').format('golines', {
        '--write-output',
        '--base-formatter=gofumpt',
        '--tab-len=4',
        '--max-len=100',
        '--no-reformat-tags',
    })
end, { desc = 'Format current file with goimports and gofumpt', bar = true })
