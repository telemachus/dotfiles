local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt
local cmd = vim.cmd
local lsp = vim.lsp
local diagnostic = vim.diagnostic
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
    pattern = { "*.go", "*.lua", "*.rockspec", ".luacheckrc" },
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
    group = telemachus_augroup,
})

autocmd("QuickFixCmdPost", {
    pattern = "[^l]*",
    callback = function()
        cmd("cwindow")
    end,
    group = telemachus_augroup,
})

autocmd("QuickFixCmdPost", {
    pattern = "l*",
    callback = function()
        cmd("lwindow")
    end,
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

-- If wait_ms is nil, vim.lsp.buf_request_sync defaults to 1000ms.
local goimports = function(wait_ms)
    local params = lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result =
        lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                local enc = (lsp.get_client_by_id(cid) or {}).offset_encoding
                    or "utf-16"
                lsp.util.apply_workspace_edit(r.edit, enc)
            end
        end
    end
end

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        -- goimports defaults to a 1000ms timeout. Depending on your machine and
        -- codebase, you may want longer. Add an argument (e.g., 2000 or more) if
        -- you find that you have to write the file twice for changes to be saved.
        goimports()
        -- lsp.buf.format({ async = false })
    end,
    group = telemachus_augroup,
})

-- github.com/VonHeikemen/nvim-lsp-sans-plugins/blob/main/lua/lsp/init.lua
autocmd("ModeChanged", {
    pattern = { "n:i", "v:s" },
    desc = "Disable diagnostics while typing",
    callback = function()
        diagnostic.disable(0)
    end,
    group = telemachus_augroup,
})

autocmd("ModeChanged", {
    pattern = { "i:n" },
    desc = "Enagle diagnostics after leaving insert mode",
    callback = function()
        diagnostic.enable(0)
    end,
    group = telemachus_augroup,
})
