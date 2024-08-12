local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd
local o = vim.o
local bo = vim.bo
local cmd = vim.cmd
local lsp = vim.lsp
local keymap_set = vim.keymap.set
local defer_fn = vim.defer_fn
local nvim_get_current_win = vim.api.nvim_get_current_win

local telemachus_augroup = create_augroup("TelemachusAugroup", { clear = true })

-- Highlight searches while searching, but not while moving over matches.
-- Taken from :help incsearch. This should be the default.
create_autocmd("CmdlineEnter", {
    pattern = { "/", "?" },
    callback = function()
        o.hlsearch = true
    end,
    group = telemachus_augroup,
})
create_autocmd("CmdlineLeave", {
    pattern = { "/", "?" },
    callback = function()
        o.hlsearch = false
    end,
    group = telemachus_augroup,
})

-- Use only absolute line numbers when browsing help files.
create_autocmd("Filetype", {
    pattern = { "help" },
    callback = function()
        o.number = false
        o.relativenumber = false
        o.statuscolumn = ""
        -- TODO: add a namespace for highlighting line numbers here.
    end,
    group = telemachus_augroup,
})

-- Highlight cursor line briefly when neovim regains focus.  This helps to
-- reorient the user and tell them where they are in the buffer.
-- Stolen from https://developer.ibm.com/tutorials/l-vim-script-5
create_autocmd("FocusGained", {
    pattern = "*",
    callback = function()
        o.cursorline = true
        cmd("redraw")
        defer_fn(function()
            o.cursorline = false
            cmd("redraw")
        end, 600)
    end,
    group = telemachus_augroup,
})

-- For conform.nvim: format on save.
create_autocmd("BufWritePre", {
    pattern = { "*" },
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
    group = telemachus_augroup,
})

-- Open quickfix window automatically. TODO: add items to pattern.
create_autocmd("QuickFixCmdPost", {
    pattern = "cgetexpr",
    command = ":cwindow",
    group = telemachus_augroup,
})

-- Open location list window automatically. TODO: add items to pattern.
create_autocmd("QuickFixCmdPost", {
    pattern = "lgetexpr",
    command = ":lwindow",
    group = telemachus_augroup,
})

-- Open quickfix window after refinery.nvim adds items to it.
create_autocmd("User", {
    pattern = "RefineryQuickFixCmdPost",
    command = ":cwindow",
    group = telemachus_augroup,
})

-- Update helptags after Paq installs or updates plugins.
create_autocmd("User", {
    pattern = "PaqDone*",
    command = ":helptags ALL",
    group = telemachus_augroup,
})

---Close open floating window with one keystroke.
---@param base_win_id integer
local hover_close = function(base_win_id)
    local windows = vim.api.nvim_tabpage_list_wins(0)
    for _, win_id in ipairs(windows) do
        if win_id ~= base_win_id then
            local win_cfg = vim.api.nvim_win_get_config(win_id)
            if win_cfg.relative == "win" and win_cfg.win == base_win_id then
                vim.api.nvim_win_close(win_id, false)
                break
            end
        end
    end
end

-- Add keybindings to a buffer when LSP attaches.
create_autocmd("LspAttach", {
    callback = function(ev)
        -- Do not let the LSP set formatexpr since some LSPs don't support
        -- reformatting comments.
        bo[ev.buf].formatexpr = nil

        -- TODO: remove any of these that are now defaults.
        local keymap_opts = { remap = false, silent = true, buffer = ev.buf }
        keymap_set("n", "gd", lsp.buf.definition, keymap_opts)
        keymap_set("n", "gs", "<C-w>]", keymap_opts)
        keymap_set("n", "R", lsp.buf.rename, keymap_opts)
        keymap_set("n", "T", lsp.buf.type_definition, keymap_opts)
        keymap_set("n", "<Leader>;", function()
            hover_close(nvim_get_current_win())
        end, keymap_opts)
    end,
})

-- Call goimports via gopls on write.
create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        local params = lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        local result =
            lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local client = lsp.get_client_by_id(cid) or {}
                    local enc = client.offset_encoding or "utf-16"
                    lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end
    end,
    group = telemachus_augroup,
})
