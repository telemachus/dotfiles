local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt
local cmd = vim.cmd
local find = vim.fs.find
local dirname = vim.fs.dirname
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local telemachus_augroup = augroup('TelemachusAugroup', { clear = true })

-- From :help incsearch. This should be the default.
autocmd('CmdlineEnter', {
    pattern = { '/', '?' },
    callback = function()
        opt.hlsearch = true
    end,
    group = telemachus_augroup,
})
autocmd('CmdlineLeave', {
    pattern = { '/', '?' },
    callback = function()
        opt.hlsearch = false
    end,
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

autocmd('BufWritePre', {
    pattern = '*.lua',
    command = 'Stylua',
    group = telemachus_augroup,
})

autocmd('User', {
    pattern = 'RefineryFormatPost',
    command = 'IndentBlanklineRefresh',
    group = telemachus_augroup,
})

autocmd('QuickFixCmdPost', {
    pattern = '[^l]*',
    callback = function()
        cmd('cwindow')
    end,
    group = telemachus_augroup,
})

autocmd('QuickFixCmdPost', {
    pattern = 'l*',
    callback = function()
        cmd('lwindow')
    end,
    group = telemachus_augroup,
})

local keymap_set = vim.keymap.set
local keymap_opts = { remap = false, silent = true, buffer = 0 }
local on_attach = function(client, bufnr)
    keymap_set('n', 'gD', lsp.buf.declaration, keymap_opts)
    keymap_set('n', 'gd', lsp.buf.definition, keymap_opts)
    keymap_set('n', 'gs', '<C-w>]', keymap_opts)
    keymap_set('n', 'K', lsp.buf.hover, keymap_opts)
    keymap_set('n', 'rn', lsp.buf.rename, keymap_opts)
end

autocmd('FileType', {
    pattern = 'go',
    callback = function()
        local d = find({ 'go.mod', 'go.work', '.git' }, { upward = true })[1]
        local root_dir = dirname(d)
        local client = lsp.start({
            name = 'gopls',
            cmd = { 'gopls', 'serve' },
            filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
            root_dir = root_dir,
            single_file_support = true,
            on_attach = on_attach,
            settings = {
                gopls = {
                    gofumpt = true,
                },
            },
        })
        lsp.buf_attach_client(0, client)
    end,
    group = telemachus_augroup,
})

local goimports = function(wait_ms)
    wait_ms = wait_ms or 1000
    local params = lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    local result =
        lsp.buf_request_sync(0, 'textDocument/codeAction', params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                lsp.util.apply_workspace_edit(r.edit, 'UTF-8')
            else
                lsp.buf.execute_command(r.command)
            end
        end
    end
end

autocmd('BufWritePre', {
    pattern = '*.go',
    callback = function()
        goimports()
        lsp.buf.format({ async = false })
    end,
    group = telemachus_augroup,
})
