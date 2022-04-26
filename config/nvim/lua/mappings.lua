local keymap_set = vim.keymap.set
local default_opts = { remap = false, silent = true }

-- Delete everything below the current line. Mnemonic: t is for trim.
keymap_set('n', '<Leader>t', ':+1,$d<CR>', default_opts)
