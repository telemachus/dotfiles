local keymap_set = vim.keymap.set
local default_opts = { remap = false, silent = true }
local extended_opts = { remap = false, silent = true, expr = true }
local g = vim.g
local fn = vim.fn
local diagnostic = vim.diagnostic

-- Text objects for lines.
keymap_set("x", "il", "g_o^", default_opts)
keymap_set("o", "il", ":normal vil<CR>", default_opts)
keymap_set("x", "al", "$o0", default_opts)
keymap_set("o", "al", ":normal val<CR>", default_opts)

-- Delete everything below the current line. Mnemonic: t is for trim.
keymap_set("n", "<Leader>t", ":+1,$d<CR>", default_opts)

-- Use |ib| and |ab| for vim-sandwich mappings because *b* reminds me of bun.↲
-- keymap_set({ "x", "o" }, "ib", "<Plug>(textobj-sandwich-auto-i)", default_opts)
-- keymap_set({ "x", "o" }, "ab", "<Plug>(textobj-sandwich-auto-a)", default_opts)
-- Properly indent yanked text. keymap_set("n", "<Leader>pi", "p`[v`]=`", default_opts)

-- Use Q for gq.
keymap_set({ "n", "v" }, "Q", "gq", default_opts)

-- From Practical Vim (ed. 2, page 101):
--
-- Use %% to get current buffer's directory for :edit, :write, :saveas, :read
-- and :find.
cmd = [[getcmdtype() == ':' ? expand('%:h') . '/' : '%%']]
keymap_set("c", "%%", cmd, extended_opts)

-- A mapping for the :w !sudo tee % > /dev/null trick.
keymap_set("c", "w!!", "w !sudo tee % > /dev/null", default_opts)

-- From tpope's unimpaired.vim via Practical Vim. NB: I've changed a few.
keymap_set("n", "[b", ":bprevious<CR>", default_opts)
keymap_set("n", "]b", ":bnext<CR>", default_opts)
keymap_set("n", "[B", ":bfirst<CR>", default_opts)
keymap_set("n", "]B", ":blast<CR>", default_opts)
keymap_set("n", "[t", ":tabprevious<CR>", default_opts)
keymap_set("n", "]t", ":tabnext<CR>", default_opts)
keymap_set("n", "[T", ":tabfirst<CR>", default_opts)
keymap_set("n", "]T", ":tablast<CR>", default_opts)
keymap_set("n", "[l", ":lprevious<CR>", default_opts)
keymap_set("n", "]l", ":lnext<CR>", default_opts)
keymap_set("n", "[L", ":lfirst<CR>", default_opts)
keymap_set("n", "]L", ":llast<CR>", default_opts)
keymap_set("n", "[q", ":cprevious<CR>", default_opts)
keymap_set("n", "]q", ":cnext<CR>", default_opts)
keymap_set("n", "[Q", ":cfirst<CR>", default_opts)
keymap_set("n", "]Q", ":clast<CR>", default_opts)

-- Use my bitly command to shorten URLs.
local cmd =
    [[c<C-R>=trim(system(['bitly', '-stdout', '-url', trim(getreg('*'))], getreg('"')))<CR><ESC>]]
keymap_set("v", "<Leader>b", cmd, default_opts)

-- Yank the rest of the current line into the system clipboard.
keymap_set("n", "<Leader>y", '"+y$', default_opts)

-- Yank the entire current line into the system clipboard.
-- keymap_set('n', '<Leader>Y', '0"+y$', default_opts)
keymap_set("n", "<Leader>Y", function()
    fn.setreg("+", fn.getline("."))
end, default_opts)

-- Yank the visual selection into the system clipboard.
keymap_set("v", "<Leader>y", '"+y', default_opts)

-- Edit or source $MYVIMRC.
keymap_set("n", "<Leader>ev", ":split $MYVIMRC<CR>", default_opts)
keymap_set("n", "<Leader>sv", ":source $MYVIMRC<CR>", default_opts)

-- Make a WORD all uppercase after the fact while in insert mode.
-- (I took this from Steve Losh's *Learn Vimscript the Hard Way*.)
keymap_set("i", "<C-U>", "<Esc>bgUiWea", default_opts)

-- Make WORD under cursor all uppercase while in normal mode.
keymap_set("n", "<Leader>u", "gUiW", default_opts)

-- Mappings for diagnostics.
keymap_set("n", "[d", diagnostic.goto_prev, default_opts)
keymap_set("n", "]d", diagnostic.goto_next, default_opts)
keymap_set("n", "<Leader>do", diagnostic.open_float, default_opts)
keymap_set("n", "<Leader>dq", diagnostic.setqflist, default_opts)
