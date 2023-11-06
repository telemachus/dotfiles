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

local smart_tab = function(direction)
    local tabs = { "<Tab>", "<S-Tab>" }
    local completions = { "<C-n>", "<C-p>" }
    if vim.fn.pumvisible() == 0 then
        if direction == -1 then
            return "<S-Tab>"
        end
        return "<Tab>"
    else
        if direction == -1 then
            return "<C-p>"
        end
        return "<C-n>"
    end
end

local hover_close = function(base_win_id)
    local windows = vim.api.nvim_tabpage_list_wins(0)
    for _, win_id in ipairs(windows) do
        if win_id ~= base_win_id then
            local win_cfg = vim.api.nvim_win_get_config(win_id)
            if win_cfg.relative == "win" and win_cfg.win == base_win_id then
                vim.api.nvim_win_close(win_id, {})
                break
            end
        end
    end
end

autocmd("LspAttach", {
    callback = function(ev)
        vim.g.hover_open = false
        local keymap_opts = { remap = false, silent = true, buffer = ev.buf }
        local extended_keymap_opts =
            { remap = false, silent = true, buffer = ev.buf, expr = true }
        keymap_set("n", "gd", lsp.buf.definition, keymap_opts)
        keymap_set("n", "gs", "<C-w>]", keymap_opts)
        keymap_set("n", "K", lsp.buf.hover, keymap_opts)
        keymap_set("n", "R", lsp.buf.rename, keymap_opts)
        keymap_set("n", "T", lsp.buf.type_definition, keymap_opts)
        keymap_set("n", ";", function()
            hover_close(vim.api.nvim_get_current_win())
        end, keymap_opts)
        keymap_set("i", "<Tab>", function()
            return smart_tab(1)
        end, extended_keymap_opts)
        keymap_set("i", "<S-Tab>", function()
            return smart_tab(-1)
        end, extended_keymap_opts)
    end,
})

autocmd("LspDetach", {
    callback = function(ev)
        vim.command("redraw!")
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
    end,
    group = telemachus_augroup,
})
