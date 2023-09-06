local lsp = vim.lsp
local diagnostic = vim.diagnostic
local cmd = vim.cmd
local _border = 'single'
local highlight = vim.api.nvim_set_hl

-- Shut off inline diagnostic text.
diagnostic.config({ virtual_text = false })

-- Add borders to floating windows in the LSP.
-- Thanks to this post for the code: https://vi.stackexchange.com/a/39075.
lsp.handlers['textDocument/hover'] =
    lsp.with(lsp.handlers.hover, { border = _border })

lsp.handlers['textDocument/signatureHelp'] =
    lsp.with(lsp.handlers.signature_help, { border = _border })

diagnostic.config({ float = { border = _border } })

cmd('highlight FloatBorder ctermfg=NONE ctermbg=NONE cterm=NONE')
