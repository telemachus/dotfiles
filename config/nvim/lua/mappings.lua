local keymap_set = vim.keymap.set
local default_opts = { remap = false, silent = true }
local extended_opts = { remap = false, silent = true, expr = true }
local cmd = vim.cmd
local set_register = vim.fn.setreg
local get_line = vim.fn.getline
local diagnostic = vim.diagnostic
local get_current_buf = vim.api.nvim_get_current_buf

-- Text objects for lines.
keymap_set("x", "il", "g_o^", default_opts)
keymap_set("o", "il", ":normal vil<CR>", default_opts)
keymap_set("x", "al", "$o0", default_opts)
keymap_set("o", "al", ":normal val<CR>", default_opts)

-- Text objects for the entire document.
-- TODO: improve the ie object.
keymap_set(
    "x",
    "ie",
    ":<C-u>let z = @/|1;/^./kz<CR>G??<CR>:let @/ = z<CR>V'z",
    default_opts
)
keymap_set("o", "ie", ":<C-u>normal vie<CR>", default_opts)
keymap_set("x", "ae", "GoggV", default_opts)
keymap_set("o", "ae", ":<C-u>normal vae<CR>", default_opts)

-- Open parent directory in current window.
keymap_set("n", "-", "<CMD>Oil<CR>", default_opts)

-- From the Vim wiki: https://bit.ly/4eLAARp.
keymap_set("n", "<Leader>r", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])

-- Delete everything below the current line. Mnemonic: t is for trim.
keymap_set("n", "<Leader>t", ":+1,$d<CR>", default_opts)

-- Properly indent yanked text.
keymap_set("n", "<Leader>pi", function()
    cmd(":normal p`[v`]=`")
    local bufnr = get_current_buf()
    require("ibl").debounced_refresh(bufnr)
end, default_opts)

-- Use Q for gq.
keymap_set({ "n", "v" }, "Q", "gq", default_opts)

-- From Practical Vim (ed. 2, page 101):
--
-- Use %% to get current buffer's directory for :edit, :write, :saveas, :read
-- and :find.
local ternary_op = [[getcmdtype() == ':' ? expand('%:h') . '/' : '%%']]
keymap_set("c", "%%", ternary_op, extended_opts)

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
keymap_set("v", "<Leader>b", require("bitly").shorten, default_opts)

-- Yank the rest of the current line into the system clipboard.
keymap_set("n", "<Leader>y", '"+y$', default_opts)

-- Yank the entire current line into the system clipboard.
keymap_set("n", "<Leader>Y", function()
    set_register("+", get_line("."))
end, default_opts)

-- Yank the visual selection into the system clipboard.
keymap_set("v", "<Leader>y", '"+y', default_opts)

-- Edit or source $MYVIMRC.
keymap_set("n", "<Leader>ev", ":split $MYVIMRC<CR>", default_opts)
keymap_set("n", "<Leader>sv", ":source $MYVIMRC<CR>", default_opts)

-- Mappings for diagnostics.
-- TODO: remove these? Check, but I think these are now built-in.
keymap_set("n", "[d", function()
    diagnostic.jump({ count = -1, float = true })
end, default_opts)
keymap_set("n", "]d", function()
    diagnostic.jump({ count = 1, float = true })
end, default_opts)
keymap_set("n", "<Leader>do", diagnostic.open_float, default_opts)
keymap_set("n", "<Leader>dq", diagnostic.setqflist, default_opts)

-- Automatically put blank lines into the black-hole register
-- https://nanotipsforvim.prose.sh/keeping-your-register-clean-from-dd
keymap_set("n", "dd", function()
    if get_line("."):find("^%s*$") then
        return '"_dd'
    end
    return "dd"
end, extended_opts)

-- Lazy mappings for nvim-snippy
keymap_set({ "i", "s" }, "<Tab>", function()
    if require("snippy").can_expand_or_advance() then
        return "<Plug>(snippy-expand-or-advance)"
    end
    return "<Tab>"
end, extended_opts)
keymap_set({ "i", "s" }, "<S-Tab>", function()
    if require("snippy").can_jump(-1) then
        return "<Plug>(snippy-previous)"
    end
    return "<S-Tab>"
end, extended_opts)
keymap_set("x", "<Leader>x", "<Plug>(snippy-cut-text)", default_opts)
keymap_set("n", "<Leader>x", "<Plug>(snippy-cut-text)", default_opts)

-- Simplify getting out of pairs like `()`, `[]`, and so on.
-- Enter CTRL-CR, and it will move out of common pair endings.
keymap_set("i", "<C-CR>", require("pairs").leap, default_opts)

-- TODO: paste from the unnamed register without overwriting the contents of
-- that register.
keymap_set(
    "x",
    "<Leader>p",
    [[p:if v:register == '"'<Bar>let @@=@0<Bar>endif<CR>]],
    default_opts
)

-- Paste a characterwise yank as if it were linewise.
keymap_set("n", "[p", require("paste").linewise_above, default_opts)
keymap_set("n", "]p", require("paste").linewise_below, default_opts)
keymap_set("n", "[c", require("paste").charwise_above, default_opts)
keymap_set("n", "]c", require("paste").charwise_below, default_opts)
