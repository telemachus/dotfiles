local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt
local cmd = vim.cmd
local lsp = vim.lsp
local keymap_set = vim.keymap.set

local telemachus_augroup = augroup("TelemachusAugroup", { clear = true })

-- From :help incsearch. This should be the default.
autocmd("CmdlineEnter", {
    pattern = { "/", "?" },
    callback = function()
        opt.hlsearch = true
    end,
    group = telemachus_augroup,
})
autocmd("CmdlineLeave", {
    pattern = { "/", "?" },
    callback = function()
        opt.hlsearch = false
    end,
    group = telemachus_augroup,
})

-- Stolen from https://developer.ibm.com/tutorials/l-vim-script-5
autocmd("FocusGained", {
    pattern = "*",
    callback = function()
        opt.cursorline = true
        cmd("redraw")
        cmd("sleep 600m")
        opt.cursorline = false
    end,
    group = telemachus_augroup,
})

autocmd("BufWritePre", {
    pattern = { "*" },
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
    group = telemachus_augroup,
})

autocmd("QuickFixCmdPost", {
    pattern = "cgetexpr",
    command = ":cwindow",
    group = telemachus_augroup,
})

autocmd("QuickFixCmdPost", {
    pattern = "lgetexpr",
    command = ":lwindow",
    group = telemachus_augroup,
})

autocmd("User", {
    pattern = "RefineryQuickFixCmdPost",
    command = "cwindow",
    group = telemachus_augroup,
})

autocmd("User", {
    pattern = "PaqDone*",
    command = ":helptags ALL",
    group = telemachus_augroup,
})

autocmd("LspAttach", {
    callback = function(ev)
        local keymap_opts = { remap = false, silent = true, buffer = ev.buf }
        keymap_set("n", "gd", lsp.buf.definition, keymap_opts)
        keymap_set("n", "gs", "<C-w>]", keymap_opts)
        keymap_set("n", "K", lsp.buf.hover, keymap_opts)
        keymap_set("n", "R", lsp.buf.rename, keymap_opts)
        keymap_set("n", "T", lsp.buf.type_definition, keymap_opts)
    end,
})

autocmd("BufWritePre", {
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
        -- lsp.buf.format({ async = false })
    end,
    group = telemachus_augroup,
})
