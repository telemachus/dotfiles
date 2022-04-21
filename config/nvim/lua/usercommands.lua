local command = vim.api.nvim_create_user_command

command('Goimports',
    function(_)
        require('refinery').format('goimports', {'-w'})
    end,
    { desc = 'Format current file with goimports', bar = true, }
)

command('Gofumpt',
    function(_)
        require('refinery').format('gofumpt', {'-w'})
    end,
    { desc = 'Format current file with goimports', bar = true, }
)

command('Golines',
    function(_)
        require('refinery').format('golines', {'-w', '--base-formatter=gofumpt'})
    end,
    { desc = 'Format current file with goimports', bar = true, }
)
