local keymap_set = vim.keymap.set
local win_get_cursor = vim.api.nvim_win_get_cursor
local buf_line_count = vim.api.nvim_buf_line_count
local buf_set_lines = vim.api.nvim_buf_set_lines
local cmd = vim.cmd
local set_register = vim.fn.setreg
local get_line = vim.fn.getline
-- local diagnostic = vim.diagnostic
local get_current_buf = vim.api.nvim_get_current_buf
local helpers = require("helpers")
local default_opts = helpers.concat_table({ remap = false, silent = true })
local extended_opts =
    helpers.concat_table({ remap = false, silent = true, expr = true })

-- Text objects for lines.
keymap_set(
    "x",
    "il",
    "g_o^",
    default_opts .. { desc = "Inner-line textobject" }
)
keymap_set(
    "o",
    "il",
    ":normal vil<CR>",
    default_opts .. { desc = "Inner-line textobject" }
)
keymap_set(
    "x",
    "al",
    "$o0",
    default_opts .. { desc = "Around-line textobject" }
)
keymap_set(
    "o",
    "al",
    ":normal val<CR>",
    default_opts .. { desc = "Around-line textobject" }
)

-- Text objects for the entire document.
-- TODO: improve the ie object.
keymap_set(
    "x",
    "ie",
    ":<C-u>let z = @/|1;/^./kz<CR>G??<CR>:let @/ = z<CR>V'z",
    default_opts .. { desc = "Inner-document textobject" }
)
keymap_set(
    "o",
    "ie",
    ":<C-u>normal vie<CR>",
    default_opts .. { desc = "Inner-document textobject" }
)
keymap_set(
    "x",
    "ae",
    "GoggV",
    default_opts .. { desc = "Around-document textobject" }
)
keymap_set(
    "o",
    "ae",
    ":<C-u>normal vae<CR>",
    default_opts .. { desc = "Around-document textobject" }
)

-- From the Vim wiki: https://bit.ly/4eLAARp.
keymap_set(
    "n",
    "<Leader>r",
    [[:%s/\<<C-r><C-w>\>//g<Left><Left>]],
    default_opts .. { desc = "Search and replace word under cursor" }
)

-- Delete everything below the current line. Mnemonic: t is for trim.
keymap_set("n", "<Leader>t", function()
    local current_line = win_get_cursor(0)[1]
    local last_line = buf_line_count(0)

    if current_line < last_line then
        buf_set_lines(0, current_line, -1, false, {})
    end
end, default_opts .. { desc = "Delete everything below current line" })

-- Paste and indent contents of unnamed register.
keymap_set("n", "<Leader>pi", function()
    cmd(":normal p`[v`]=`")
    local bufnr = get_current_buf()
    require("ibl").debounced_refresh(bufnr)
end, default_opts .. { desc = "Paste and indent contents of unnamed register" })

-- Use Q for gq.
keymap_set(
    { "n", "v" },
    "Q",
    "gq",
    default_opts .. { desc = "Format over movement" }
)

-- From Practical Vim (ed. 2, page 101):
--
-- Use %% to get current buffer's directory for :edit, :write, :saveas, :read
-- and :find.
local ternary_op = [[getcmdtype() == ':' ? expand('%:h') . '/' : '%%']]
keymap_set(
    "c",
    "%%",
    ternary_op,
    extended_opts .. { desc = "Get current buffer's directory with %%" }
)

-- Use my bitly command to shorten URLs.
keymap_set(
    "v",
    "<Leader>b",
    require("bitly").shorten,
    default_opts .. { desc = "Shorten URL with Bitly" }
)

-- Yank the rest of the current line into the system clipboard.
keymap_set("n", "<Leader>y", '"+y$', default_opts .. {
    desc = "Paste from cursor to end of line into the system clipboard",
})

-- Yank the entire current line into the system clipboard.
keymap_set("n", "<Leader>Y", function()
    set_register("+", get_line("."))
end, default_opts .. { desc = "Paste current line into the system clipboard" })

-- Yank the visual selection into the system clipboard.
keymap_set(
    "v",
    "<Leader>y",
    '"+y',
    default_opts
        .. { desc = "Paste visual selection into the system clipboard" }
)

-- Edit or source $MYVIMRC.
keymap_set(
    "n",
    "<Leader>ev",
    ":split $MYVIMRC<CR>",
    default_opts .. { desc = "Edit $MYVIMRC" }
)
keymap_set(
    "n",
    "<Leader>sv",
    ":source $MYVIMRC<CR>",
    default_opts .. { desc = "Source $MYVIMRC" }
)

-- Mappings for diagnostics.
-- TODO: remove these? Check, but I think these are now built-in.
-- keymap_set("n", "[d", function()
--     diagnostic.jump({ count = -1, float = true })
-- end, default_opts)
-- keymap_set("n", "]d", function()
--     diagnostic.jump({ count = 1, float = true })
-- end, default_opts)
-- keymap_set("n", "<Leader>do", diagnostic.open_float, default_opts)
-- keymap_set("n", "<Leader>dq", diagnostic.setqflist, default_opts)

-- Automatically put blank lines into the black-hole register
-- https://nanotipsforvim.prose.sh/keeping-your-register-clean-from-dd
keymap_set("n", "dd", function()
    if get_line("."):find("^%s*$") then
        return '"_dd'
    end
    return "dd"
end, extended_opts .. { desc = "Don't store blank lines when calling dd" })

-- Lazy mappings for nvim-snippy
--
-- Use Tab to start and move through a snippet.
keymap_set({ "i", "s" }, "<Tab>", function()
    if require("snippy").can_expand_or_advance() then
        return "<Plug>(snippy-expand-or-advance)"
    end
    return "<Tab>"
end, extended_opts .. { desc = "Trigger or move through a snippet" })

-- Use Shift-Tab to move backwards through a snippet.
keymap_set({ "i", "s" }, "<S-Tab>", function()
    if require("snippy").can_jump(-1) then
        return "<Plug>(snippy-previous)"
    end
    return "<S-Tab>"
end, extended_opts .. { desc = "Move backwards through a snippet" })

-- Use Leader-x to cut text for the TM_VISUAL placeholder.
keymap_set(
    "x",
    "<Leader>x",
    "<Plug>(snippy-cut-text)",
    default_opts .. { desc = "Cut text for the TM_VISUAL placeholder" }
)
keymap_set(
    "n",
    "<Leader>x",
    "<Plug>(snippy-cut-text)",
    default_opts .. { desc = "Cut text for the TM_VISUAL placeholder" }
)

-- Simplify getting out of pairs like `()`, `[]`, and so on.
-- Enter CTRL-CR, and it will move out of common pair endings.
keymap_set(
    "i",
    "<C-CR>",
    require("pairs").leap,
    default_opts .. { desc = "Jump beyond common pair endings" }
)

-- TODO: paste from the unnamed register without overwriting the contents of
-- that register.
keymap_set(
    "x",
    "<Leader>p",
    [[p:if v:register == '"'<Bar>let @@=@0<Bar>endif<CR>]],
    default_opts
        .. { desc = "Paste from unnamed register without overwriting it" }
)

-- Paste a characterwise yank, as if it were linewise, on the line above.
keymap_set(
    "n",
    "[p",
    function()
        vim.go.operatorfunc = "v:lua.require'put'.linewise_above"
        return "g@l"
    end,
    extended_opts
        .. { desc = "Paste charwise yank on line above—but linewise" }
)

-- Paste a characterwise yank, as if it were linewise, on the line above.
keymap_set(
    "n",
    "]p",
    function()
        vim.go.operatorfunc = "v:lua.require'put'.linewise_below"
        return "g@l"
    end,
    extended_opts
        .. { desc = "Paste charwise yank on line above—but linewise" }
)

-- Use gd instead of C-] for "go to definition".
keymap_set("n", "gd", "<C-]>", default_opts .. { desc = "Go to definition" })

-- Create text object for comments. The `ic` version selects comment text but
-- not comment marker, and `ac` selects comment text and comment marker.
-- (Comments with start and end markers are not supported.)
keymap_set({ "o", "x" }, "ic", function()
    return require("comment-textobj").inner_comment()
end, extended_opts .. { desc = "Inner-comment textobject" })
keymap_set({ "o", "x" }, "ac", function()
    return require("comment-textobj").around_comment()
end, extended_opts .. { desc = "Around-comment textobject" })
